Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 19 Feb 2013 00:49:04 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130218234904.GA24241@pandem0nium>
References: <1361112184-9927-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <1361112184-9927-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add compat support for the
 new netlink ops
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


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Antonio,

I've tested this (just test, no code review) in my 2.6.32 qemu (Debian sque=
eze, iproute from wheezy).
It generally loads and batctl if add/del seems to work, but there is someth=
ing weird going on with
bridge interaction. After calling the following 3 commands:

brctl addbr br0
batctl if add eth0
ip link set dev eth0 master br0

I would expect that eth0 moved from bat0 to br0 (or some error is reported)=
=2E But what I see is:

root@debian:~# batctl if
eth0: active
br0: not in use
root@debian:~# brctl show
bridge name     bridge id               STP enabled     interfaces
br0             8000.000000000000       no

Even more weird, after doing batctl if del eth0 or batctl if del br0, I don=
't get any output, but
both devices remain in bat0 (according to batctl if). But I do get some out=
put that it's trying
to remove eth0:

[  102.788930] batman_adv: bat0: Interface deactivated: eth0               =
   =20
[  102.788935] batman_adv: bat0: Removing interface: eth0                  =
 =20

Note that I don't have this behaviour on my host machine (3.2.0, Debian uns=
table kernel).

So I can't ack this now, although I don't know if the problem is in this pa=
tch, in the
current batman-adv/netlink implementation or somewhere in 2.6.32 kernel rel=
ease.

Cheers,
	Simon


On Sun, Feb 17, 2013 at 03:43:04PM +0100, Antonio Quartulli wrote:
> This patches enable the new rtnl ops to compile on kernels starting from =
2.6.32
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>=20
> Could not be uglier.
> *Compile tested only* because linux-2.6.32 does not compile on my laptop
>=20
>=20
>=20
>  compat.h | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/compat.h b/compat.h
> index 885e551..de22e2b 100644
> --- a/compat.h
> +++ b/compat.h
> @@ -71,6 +71,9 @@ static inline void batadv_this_cpu_add(uint64_t *count_=
ptr, size_t count)
>  	put_cpu();
>  }
> =20
> +#define batadv_softif_destroy_netlink(dev, head) batadv_softif_destroy_n=
etlink(dev)
> +#define unregister_netdevice_queue(dev, head) unregister_netdevice(dev)
> +
>  #endif /* < KERNEL_VERSION(2, 6, 33) */
> =20
> =20
> @@ -132,6 +135,43 @@ static inline int batadv_param_set_copystring(const =
char *val,
>  #define kstrtoul strict_strtoul
>  #define kstrtol  strict_strtol
> =20
> +#define batadv_softif_slave_add(x, y) \
> +batadv_softif_slave_add(struct net_device *dev, struct ifreq *rq, int cm=
d)\
> +{\
> +	return 0;\
> +}\
> +static int __batadv_softif_slave_add(x, y)
> +
> +#define batadv_softif_slave_del(x, y) \
> +__batadv_softif_slave_del(struct net_device *dev, struct net_device *sla=
ve_dev);\
> +static int batadv_softif_slave_del(struct net_device *dev, struct ifreq =
*rq, int cmd)\
> +{\
> +	struct batadv_priv *bat_priv =3D netdev_priv(dev);\
> +	struct net_device *slave_dev;\
> +	int ret;\
> +	if (!capable(CAP_NET_ADMIN))\
> +		return -EPERM;\
> +	slave_dev =3D dev_get_by_index(&init_net, rq->ifr_ifindex);\
> +	if (!dev)\
> +		return -EINVAL;\
> +	switch(cmd) {\
> +	case SIOCBRADDIF:\
> +		ret =3D __batadv_softif_slave_add(bat_priv->soft_iface, slave_dev);\
> +	case SIOCBRDELIF:\
> +		ret =3D __batadv_softif_slave_del(bat_priv->soft_iface, slave_dev);\
> +	default:\
> +		pr_debug("batman-adv does not support ioctl 0x%x\n", cmd);\
> +		return -EOPNOTSUPP;\
> +	}\
> +\
> +	dev_put(slave_dev);\
> +	return ret;\
> +}\
> +static int __batadv_softif_slave_del(x, y)
> +
> +#define ndo_add_slave ndo_do_ioctl
> +#define ndo_del_slave ndo_do_ioctl
> +
>  #endif /* < KERNEL_VERSION(2, 6, 39) */
> =20
> =20
> --=20
> 1.8.1.2
>=20

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlEive4ACgkQrzg/fFk7axZJ0ACg3e1G5n4uoR6vdW4baVcRFwvH
RJ0An0QKjQYMMkJT/9C5y13cLZaYgOxP
=K+1D
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
