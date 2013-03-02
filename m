Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 2 Mar 2013 15:01:14 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130302140113.GA26567@pandem0nium>
References: <1362174287-15561-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <1362174287-15561-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] batman-adv: remove interfacing
 enslaving loop private check
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I've tested this for compatibility on 2.6.32 (Debian stable) in my virtual =
machine.
Marek suggested to use:

batctl if add eth0
vconfig add bat0 5
batctl if add bat0.5

and the last command fails with:
Error - can't write to file '/sys/class/net/bat0.5/batman_adv/mesh_iface': =
Operation not permitted

which looks good and expected to me.

Without the patch, the directory /sys/class/net/bat0.5/batman_adv does not =
even exist - probably
because the check was removed in this patch.

Another thing I have tried, which behaves bad with and without this patch:
batctl if add eth0
brctl addbr br0
brctl addif br0 bat0
batctl if add br0
(wait a few seconds)
rmmod batman-adv

First, enslaving br0 into bat0 does not fail, but it makes no sense to ensl=
ave bat0 through br0 into bat0
again - we should probably prevent this too. Removing the module crashes th=
e kernel, not always, but pretty
reliably (I have the feeling it happens more often after applying this patc=
h, but not sure).
Unfortunately I couldn't get any useful backtraces so far, if it fails it u=
sually instantly reboots
or hangs without output (this is in kvm with -curses). I've succeeded to ge=
t some trace part, it's
probably not useful but i've attached it to the bottom anyway [1].

Any thoughts on that? :)

Cheers,
	Simon

[1]
[  130.688334]  [<c1270aaf>] ? do_page_fault+0x0/0x307                     =
  =20
[  130.688334]  [<c101bb73>] ? bad_area_nosemaphore+0xa/0xc                =
    =20
[  130.688334]  [<c126f303>] ? error_code+0x73/0x78                        =
  =20
[  130.688334]  [<c8c60f89>] ? br_nf_pre_routing+0x28/0x4a8 [bridge]       =
   =20
[  130.688334]  [<c11d007b>] ? sock_rmalloc+0x1e/0x68                      =
  =20
[  130.688334]  [<c11d9bee>] ? netif_receive_skb+0x2dd/0x3d6               =
  =20
[  130.688334]  [<c8c60f89>] ? br_nf_pre_routing+0x28/0x4a8 [bridge]       =
  =20
[  130.688334]  [<c11d9bee>] ? netif_receive_skb+0x2dd/0x3d6               =
    =20
[  130.688334]  [<c8c5d5b2>] ? br_handle_frame_finish+0xd2/0xff [bridge]   =
  =20
[  130.688334]  [<c8c5d760>] ? br_handle_frame+0x181/0x195 [bridge]        =
   =20
[  130.688334]  [<c11d9bee>] ? netif_receive_skb+0x2dd/0x3d6               =
  =20
[  130.688334]  [<c8c5d5b2>] ? br_handle_frame_finish+0xd2/0xff [bridge]   =
  =20
[  130.688334]  [<c8c5d760>] ? br_handle_frame+0x181/0x195 [bridge]        =
  =20
[  130.688334]  [<c11d9bee>] ? netif_receive_skb+0x2dd/0x3d6               =
    =20
[  130.688334]  [<c8c5d5b2>] ? br_handle_frame_finish+0xd2/0xff [bridge]   =
  =20
[  130.688334]  [<c8c5d760>] ? br_handle_frame+0x181/0x195 [bridge]        =
   =20
[  130.688334]  [<c11d9bee>] ? netif_receive_skb+0x2dd/0x3d6               =
  =20
[  130.688334]  [<c8c5d5b2>] ? br_handle_frame_finish+0xd2/0xff [bridge]   =
  =20
[  130.688334]  [<c8c5d760>] ? br_handle_frame+0x181/0x195 [bridge]        =
  =20
[  130.688334]  [<c11d9bee>] ? netif_receive_skb+0x2dd/0x3d6               =
    =20
[  130.688334]  [<c8c5d5b2>] ? br_handle_frame_finish+0xd2/0xff [bridge]   =
    =20
[  130.688334]  [<c8c5d760>] ? br_handle_frame+0x181/0x195 [bridge]        =
   =20
[  130.688334]  [<c11d9bee>] ? netif_receive_skb+0x2dd/0x3d6               =
    =20
[  130.688334]  [<c8c5d5b2>] ? br_handle_frame_finish+0xd2/0xff [bridge]


On Fri, Mar 01, 2013 at 10:44:47PM +0100, Antonio Quartulli wrote:
> Now that the new dev_upper API is used, the private check for enslaving l=
oops is
> not needed anymore as this is performed by the new API itself.
>=20
> Reported-by: Marek Lindner <lindner_marek@yahoo.de>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>=20
> v2, v3, v4:
>  - no change to this patch
>=20
> v4:
>  - added compat code
>=20
>  compat.c         | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
>  compat.h         |  5 ++++-
>  hard-interface.c | 43 -------------------------------------------
>  3 files changed, 57 insertions(+), 44 deletions(-)
>=20
> diff --git a/compat.c b/compat.c
> index 764878f..da63ea6 100644
> --- a/compat.c
> +++ b/compat.c
> @@ -24,6 +24,7 @@
>  #include <linux/in.h>
>  #include <linux/version.h>
>  #include "main.h"
> +#include "soft-interface.h"
> =20
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
> =20
> @@ -85,3 +86,55 @@ void batadv_free_rcu_nc_path(struct rcu_head *rcu)
>  #endif
> =20
>  #endif /* < KERNEL_VERSION(3, 0, 0) */
> +
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
> +
> +/**
> + * batadv_is_on_batman_iface - check if a device is a batman iface desce=
ndant
> + * @net_dev: the device to check
> + *
> + * If the user creates any virtual device on top of a batman-adv interfa=
ce, it
> + * is important to prevent this new interface to be used to create a new=
 mesh
> + * network (this behaviour would lead to a batman-over-batman configurat=
ion).
> + * This function recursively checks all the fathers of the device passed=
 as
> + * argument looking for a batman-adv soft interface.
> + *
> + * Returns true if the device is descendant of a batman-adv mesh interfa=
ce (or
> + * if it is a batman-adv interface itself), false otherwise
> + */
> +static bool batadv_is_on_batman_iface(const struct net_device *net_dev)
> +{
> +	struct net_device *parent_dev;
> +	bool ret;
> +
> +	/* check if this is a batman-adv mesh interface */
> +	if (batadv_softif_is_valid(net_dev))
> +		return true;
> +
> +	/* no more parents..stop recursion */
> +	if (net_dev->iflink =3D=3D net_dev->ifindex)
> +		return false;
> +
> +	/* recurse over the parent device */
> +	parent_dev =3D dev_get_by_index(&init_net, net_dev->iflink);
> +	/* if we got a NULL parent_dev there is something broken.. */
> +	if (WARN(!parent_dev, "Cannot find parent device"))
> +		return false;
> +
> +	ret =3D batadv_is_on_batman_iface(parent_dev);
> +
> +	if (parent_dev)
> +		dev_put(parent_dev);
> +	return ret;
> +}
> +
> +int batadv_netdev_set_master(struct net_device *slave,
> +			     struct net_device *master)
> +{
> +	if (batadv_is_on_batman_iface(slave))
> +		return -1;
> +
> +	return netdev_set_master(slave, master);
> +}
> +
> +#endif /* < KERNEL_VERSION(3, 9, 0) */
> diff --git a/compat.h b/compat.h
> index 69c3dc2..79d4217 100644
> --- a/compat.h
> +++ b/compat.h
> @@ -229,7 +229,10 @@ static int batadv_interface_set_mac_addr(struct net_=
device *dev, void *p) \
>  }\
>  static int __batadv_interface_set_mac_addr(x, y)
> =20
> -#define netdev_master_upper_dev_link netdev_set_master
> +int batadv_netdev_set_master(struct net_device *slave,
> +			     struct net_device *master);
> +
> +#define netdev_master_upper_dev_link batadv_netdev_set_master
>  #define netdev_upper_dev_unlink(slave, master) netdev_set_master(slave, =
NULL)
>  #define netdev_master_upper_dev_get(dev) \
>  ({\
> diff --git a/hard-interface.c b/hard-interface.c
> index fd99e42..b96f819 100644
> --- a/hard-interface.c
> +++ b/hard-interface.c
> @@ -60,45 +60,6 @@ out:
>  	return hard_iface;
>  }
> =20
> -/**
> - * batadv_is_on_batman_iface - check if a device is a batman iface desce=
ndant
> - * @net_dev: the device to check
> - *
> - * If the user creates any virtual device on top of a batman-adv interfa=
ce, it
> - * is important to prevent this new interface to be used to create a new=
 mesh
> - * network (this behaviour would lead to a batman-over-batman configurat=
ion).
> - * This function recursively checks all the fathers of the device passed=
 as
> - * argument looking for a batman-adv soft interface.
> - *
> - * Returns true if the device is descendant of a batman-adv mesh interfa=
ce (or
> - * if it is a batman-adv interface itself), false otherwise
> - */
> -static bool batadv_is_on_batman_iface(const struct net_device *net_dev)
> -{
> -	struct net_device *parent_dev;
> -	bool ret;
> -
> -	/* check if this is a batman-adv mesh interface */
> -	if (batadv_softif_is_valid(net_dev))
> -		return true;
> -
> -	/* no more parents..stop recursion */
> -	if (net_dev->iflink =3D=3D net_dev->ifindex)
> -		return false;
> -
> -	/* recurse over the parent device */
> -	parent_dev =3D dev_get_by_index(&init_net, net_dev->iflink);
> -	/* if we got a NULL parent_dev there is something broken.. */
> -	if (WARN(!parent_dev, "Cannot find parent device"))
> -		return false;
> -
> -	ret =3D batadv_is_on_batman_iface(parent_dev);
> -
> -	if (parent_dev)
> -		dev_put(parent_dev);
> -	return ret;
> -}
> -
>  static int batadv_is_valid_iface(const struct net_device *net_dev)
>  {
>  	if (net_dev->flags & IFF_LOOPBACK)
> @@ -110,10 +71,6 @@ static int batadv_is_valid_iface(const struct net_dev=
ice *net_dev)
>  	if (net_dev->addr_len !=3D ETH_ALEN)
>  		return 0;
> =20
> -	/* no batman over batman */
> -	if (batadv_is_on_batman_iface(net_dev))
> -		return 0;
> -
>  	return 1;
>  }
> =20
> --=20
> 1.8.1.4
>=20

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlEyBikACgkQrzg/fFk7axYGxgCguHNgumwRBLVZh9QyRVSIcJra
NvAAn25T15WmWqWrR6OONFn3w9vpw5pJ
=G/1O
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
