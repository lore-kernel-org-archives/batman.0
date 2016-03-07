Return-Path: <mschiffer@universe-factory.net>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <1456867148-31883-5-git-send-email-andrew@lunn.ch>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <56DD8E53.3010904@universe-factory.net>
Date: Mon, 7 Mar 2016 15:21:07 +0100
MIME-Version: 1.0
In-Reply-To: <1456867148-31883-5-git-send-email-andrew@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7CeoplDsdIcWLxPAPlMF76p1owSm9E0I8"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 4/4] batman-adv: debugfs: Add netns
 support
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7CeoplDsdIcWLxPAPlMF76p1owSm9E0I8
Content-Type: multipart/mixed; boundary="RgNqlbQAD6qrkBK7jdcJI38UxaRKIEaX0"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <56DD8E53.3010904@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 4/4] batman-adv: debugfs: Add netns
 support
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <1456867148-31883-5-git-send-email-andrew@lunn.ch>
In-Reply-To: <1456867148-31883-5-git-send-email-andrew@lunn.ch>

--RgNqlbQAD6qrkBK7jdcJI38UxaRKIEaX0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03/01/2016 10:19 PM, Andrew Lunn wrote:
> Unlike sysfs, debugfs is not netns aware. So batman has to take care
> to avoid namespace clashes.
>=20
> Each namespace is given a directory within debugfs/batman-adv/netns,
> using the namespaces inum as the directory name.
>=20
> Files for namespaces other than the global namespace are placed within
> the namespace specific directory. Additionally, a symbolic link is
> used to link the global namespaces inum back to debugfs/batman-adv/ so
> tools do not need to differentiate between the global namespace and
> other namespaces.
>=20
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

By the way, the netns support is another good reason to switch from the
debugfs interfaces to a netlink-based interface (as the netlink interface=

wouldn't need userspace applications like batctl to be aware of the
namespaces). I guess I should finally finish the patches I started writin=
g
for that...

This becomes even more important when namespaces are used for isolation
(e.g. by LXC/docker/...), as debugfs is really broken and would allow roo=
t
in any namespace to trigger use-after-frees and make the kernel hold the
RTNL lock indefinitely, besides tons of other debug interfaces a containe=
r
root could abuse. Running batman-adv in LXC or docker would be really nic=
e
though...

Regards,
Matthias


> ---
>=20
> v2:
>   Add missing includes
> ---
>  net/batman-adv/debugfs.c | 119 +++++++++++++++++++++++++++++++++++++++=
++++++--
>  1 file changed, 116 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
> index 3dc5208..1c6b71c 100644
> --- a/net/batman-adv/debugfs.c
> +++ b/net/batman-adv/debugfs.c
> @@ -27,8 +27,12 @@
>  #include <linux/fs.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
> +#include <linux/kref.h>
> +#include <linux/list.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/netdevice.h>
> +#include <linux/ns_common.h>
>  #include <linux/poll.h>
>  #include <linux/printk.h>
>  #include <linux/sched.h> /* for linux/wait.h */
> @@ -42,6 +46,7 @@
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
>  #include <linux/wait.h>
> +#include <net/net_namespace.h>
>  #include <stdarg.h>
> =20
>  #include "bridge_loop_avoidance.h"
> @@ -53,6 +58,73 @@
>  #include "translation-table.h"
> =20
>  static struct dentry *batadv_debugfs;
> +static struct dentry *batadv_ns_debugfs;
> +
> +struct batadv_debugfs_ns_entry {
> +	struct net *net;
> +	struct dentry *dir;
> +	struct kref refcount;
> +	struct list_head link;
> +};
> +
> +static LIST_HEAD(batadv_debugfs_ns);
> +static DEFINE_MUTEX(batadv_debugfs_ns_mutex);
> +
> +static struct dentry *batadv_debugfs_ns_get(struct net *net)
> +{
> +	struct batadv_debugfs_ns_entry *ns_entry;
> +	char name[32];
> +
> +	mutex_lock(&batadv_debugfs_ns_mutex);
> +	list_for_each_entry(ns_entry, &batadv_debugfs_ns, link) {
> +		if (ns_entry->net =3D=3D net) {
> +			kref_get(&ns_entry->refcount);
> +			mutex_unlock(&batadv_debugfs_ns_mutex);
> +			return ns_entry->dir;
> +		}
> +	}
> +
> +	ns_entry =3D kzalloc(sizeof(*ns_entry), GFP_ATOMIC);
> +	if (ns_entry) {
> +		INIT_LIST_HEAD(&ns_entry->link);
> +		ns_entry->net =3D net;
> +		kref_init(&ns_entry->refcount);
> +		sprintf(name, "%u", net->ns.inum);
> +		ns_entry->dir =3D debugfs_create_dir(name, batadv_ns_debugfs);
> +		if (!ns_entry->dir) {
> +			kfree(ns_entry);
> +			mutex_unlock(&batadv_debugfs_ns_mutex);
> +			return NULL;
> +		}
> +		list_add(&ns_entry->link, &batadv_debugfs_ns);
> +	}
> +	mutex_unlock(&batadv_debugfs_ns_mutex);
> +	return ns_entry->dir;
> +}
> +
> +static void batadv_ns_entry_release(struct kref *ref)
> +{
> +	struct batadv_debugfs_ns_entry *ns_entry;
> +
> +	ns_entry =3D container_of(ref, struct batadv_debugfs_ns_entry, refcou=
nt);
> +	debugfs_remove_recursive(ns_entry->dir);
> +	list_del(&ns_entry->link);
> +	kfree(ns_entry);
> +}
> +
> +static void batadv_debugfs_ns_put(struct net *net)
> +{
> +	struct batadv_debugfs_ns_entry *ns_entry;
> +
> +	mutex_lock(&batadv_debugfs_ns_mutex);
> +	list_for_each_entry(ns_entry, &batadv_debugfs_ns, link) {
> +		if (ns_entry->net =3D=3D net) {
> +			kref_put(&ns_entry->refcount, batadv_ns_entry_release);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&batadv_debugfs_ns_mutex);
> +}
> =20
>  #ifdef CONFIG_BATMAN_ADV_DEBUG
>  #define BATADV_LOG_BUFF_MASK (batadv_log_buff_len - 1)
> @@ -451,6 +523,7 @@ void batadv_debugfs_init(void)
>  {
>  	struct batadv_debuginfo **bat_debug;
>  	struct dentry *file;
> +	char name[32];
> =20
>  	batadv_debugfs =3D debugfs_create_dir(BATADV_DEBUGFS_SUBDIR, NULL);
>  	if (batadv_debugfs =3D=3D ERR_PTR(-ENODEV))
> @@ -471,6 +544,15 @@ void batadv_debugfs_init(void)
>  		}
>  	}
> =20
> +	batadv_ns_debugfs =3D debugfs_create_dir("netns", batadv_debugfs);
> +	if (!batadv_ns_debugfs)
> +		goto err;
> +
> +	/* Create a symlink for the default name space */
> +	sprintf(name, "%u", init_net.ns.inum);
> +	if (!debugfs_create_symlink(name, batadv_ns_debugfs, ".."))
> +		goto err;
> +
>  	return;
>  err:
>  	debugfs_remove_recursive(batadv_debugfs);
> @@ -492,14 +574,24 @@ void batadv_debugfs_destroy(void)
>   */
>  int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface)
>  {
> +	struct net *net =3D dev_net(hard_iface->net_dev);
> +	char *name =3D hard_iface->net_dev->name;
>  	struct batadv_debuginfo **bat_debug;
> +	struct dentry *debugfs_ns_dir;
>  	struct dentry *file;
> =20
>  	if (!batadv_debugfs)
>  		goto out;
> =20
> -	hard_iface->debug_dir =3D debugfs_create_dir(hard_iface->net_dev->nam=
e,
> -						   batadv_debugfs);
> +	debugfs_ns_dir =3D batadv_debugfs;
> +
> +	if (net !=3D &init_net) {
> +		debugfs_ns_dir =3D batadv_debugfs_ns_get(net);
> +		if (!debugfs_ns_dir)
> +			goto out;
> +	}
> +
> +	hard_iface->debug_dir =3D debugfs_create_dir(name, debugfs_ns_dir);
>  	if (!hard_iface->debug_dir)
>  		goto out;
> =20
> @@ -517,6 +609,8 @@ int batadv_debugfs_add_hardif(struct batadv_hard_if=
ace *hard_iface)
>  rem_attr:
>  	debugfs_remove_recursive(hard_iface->debug_dir);
>  	hard_iface->debug_dir =3D NULL;
> +	if (net !=3D &init_net)
> +		batadv_debugfs_ns_put(net);
>  out:
>  	return -ENOMEM;
>  }
> @@ -528,22 +622,36 @@ out:
>   */
>  void batadv_debugfs_del_hardif(struct batadv_hard_iface *hard_iface)
>  {
> +	struct net *net =3D dev_net(hard_iface->net_dev);
> +
>  	if (batadv_debugfs) {
>  		debugfs_remove_recursive(hard_iface->debug_dir);
>  		hard_iface->debug_dir =3D NULL;
>  	}
> +	if (net !=3D &init_net)
> +		batadv_debugfs_ns_put(net);
>  }
> =20
>  int batadv_debugfs_add_meshif(struct net_device *dev)
>  {
>  	struct batadv_priv *bat_priv =3D netdev_priv(dev);
>  	struct batadv_debuginfo **bat_debug;
> +	struct net *net =3D dev_net(dev);
> +	struct dentry *debugfs_ns_dir;
>  	struct dentry *file;
> =20
>  	if (!batadv_debugfs)
>  		goto out;
> =20
> -	bat_priv->debug_dir =3D debugfs_create_dir(dev->name, batadv_debugfs)=
;
> +	debugfs_ns_dir =3D batadv_debugfs;
> +
> +	if (net !=3D &init_net) {
> +		debugfs_ns_dir =3D batadv_debugfs_ns_get(net);
> +		if (!debugfs_ns_dir)
> +			goto out;
> +	}
> +
> +	bat_priv->debug_dir =3D debugfs_create_dir(dev->name, debugfs_ns_dir)=
;
>  	if (!bat_priv->debug_dir)
>  		goto out;
> =20
> @@ -572,6 +680,8 @@ int batadv_debugfs_add_meshif(struct net_device *de=
v)
>  rem_attr:
>  	debugfs_remove_recursive(bat_priv->debug_dir);
>  	bat_priv->debug_dir =3D NULL;
> +	if (net !=3D &init_net)
> +		batadv_debugfs_ns_put(net);
>  out:
>  	return -ENOMEM;
>  }
> @@ -579,6 +689,7 @@ out:
>  void batadv_debugfs_del_meshif(struct net_device *dev)
>  {
>  	struct batadv_priv *bat_priv =3D netdev_priv(dev);
> +	struct net *net =3D dev_net(dev);
> =20
>  	batadv_debug_log_cleanup(bat_priv);
> =20
> @@ -586,4 +697,6 @@ void batadv_debugfs_del_meshif(struct net_device *d=
ev)
>  		debugfs_remove_recursive(bat_priv->debug_dir);
>  		bat_priv->debug_dir =3D NULL;
>  	}
> +	if (net !=3D &init_net)
> +		batadv_debugfs_ns_put(net);
>  }
>=20



--RgNqlbQAD6qrkBK7jdcJI38UxaRKIEaX0--

--7CeoplDsdIcWLxPAPlMF76p1owSm9E0I8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJW3Y5TAAoJEBbvP2TLIB2c64MQAKjhowjImAcYyok1MJhjW/Aj
jnk22pHUPkZKD36pVDnh43+0oAbFtWoyODWzL1gQxT0hY6f6vzOf0Uy/uOPPwZbM
gBr34XKbxdpFSptAex8u6qZydKfmbC2rEInqsfokywqIEkSWFh1bb9Dd3XD61WKO
c/hJp+7Uqqr6BvhuK1uXkNFsERSkCEVvePJ8MrqUK6DLzKdk1U7Cmc0vvSnMXVP6
9+ZRmUbHL1/pOsgvhbY7f8bCI2oI7BspHVROleRyBEPC7Mk4L6kc2oKk79RaWyZA
u6soDlmPdBuhiBC2vck3mDbqv44lfVVOB3qVRuKWt7eKsGedzSCOBrHYGlwhlkAc
L+B8yMqTdVFq+YVypdueO5YpiLguQBQPIo4BMfHtGYPsxKx1f01gxxawlh7gRxdy
JLNj87k4R1qQWKPQxoGOOa8fTYgFED1UN2aBs3biN2cfPZ8MyMgPrJbn3NI+P1r3
Y0LMzFd1GkfpvsHI218To/9Vt7hqJ/WzSABw61UkeMi2qUymkOP064NfdIH5x+S9
CsEHH4xAtaipRtW9+htvhDEpGGXmnTHn8acRJuINuqgBevURFInIgjZA3HZPgTAG
OdT4GX32/USvUh+LYqA0mvBxjZgYWqAHS2ir4jVSUc1cBCjpHGfb32eW/FrZlPql
ckaSE6IvdHGmBqXbxQmE
=I3YL
-----END PGP SIGNATURE-----

--7CeoplDsdIcWLxPAPlMF76p1owSm9E0I8--
