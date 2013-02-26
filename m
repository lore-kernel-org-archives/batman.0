Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 26 Feb 2013 22:28:13 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130226212813.GA8249@pandem0nium>
References: <20130220144025.GP3523@ritirata.org>
 <1361372251-27623-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <1361372251-27623-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: add compat support for the
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


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey guys,

As requested, just did a quick test again:
* batctl if add $iface && some OGMS here && batctl if del $iface
 --> still works fine
 * batctl link add dev bat0 type batadv
 --> creates the bat0 interface
 * ip link set dev eth0 master bat0
 --> no output, no effect
 * ip link del dev bat0
 --> deletes the bat0 interface

Used: Debian stable (squeeze) with original kernel (linux-iamge-2.6.32-5-68=
6, version 2.6.32-46)
batctl (2012.1.0-1) and iproute (20120521-3) from wheezy=20

So no difference noticed here. :)

I've checked back with iproute package from squeeze (20120521-3):
 * "ip link add dev bat0 type batadv" still works
 * "ip link set dev eth0 master bat0" throws an error and does nothing:
Error: either "dev" is duplicate, or "master" is a garbage.

so to summarize: it compiles again, batctl works, and ip at least allows to=
 add the bat0
interface but adding interfaces into a softiface using ip doesn't.

Hope that helps!
Cheers,
	Simon

Tested-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

On Wed, Feb 20, 2013 at 03:57:31PM +0100, Antonio Quartulli wrote:
> This patches enable the new rtnl ops to compile on kernels starting from =
2.6.32
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>=20
> v2:
>  - do not handle ioctl. just return EOPNOTSUPP
>=20
>  compat.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/compat.h b/compat.h
> index 425b3d9..23ced4a 100644
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
> @@ -132,6 +135,24 @@ static inline int batadv_param_set_copystring(const =
char *val,
>  #define kstrtoul strict_strtoul
>  #define kstrtol  strict_strtol
> =20
> +#define batadv_softif_slave_add(x, y) \
> +batadv_softif_slave_add(struct net_device *dev, struct ifreq *rq, int cm=
d)\
> +{\
> +	return -EOPNOTSUPP;\
> +}\
> +static int __attribute__((unused)) __batadv_softif_slave_add(x, y)
> +
> +#define batadv_softif_slave_del(x, y) \
> +__batadv_softif_slave_del(struct net_device *dev, struct net_device *sla=
ve_dev);\
> +static int batadv_softif_slave_del(struct net_device *dev, struct ifreq =
*rq, int cmd)\
> +{\
> +	return -EOPNOTSUPP;\
> +}\
> +static int __attribute__((unused)) __batadv_softif_slave_del(x, y)
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

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlEtKO0ACgkQrzg/fFk7axaKygCfRH1gRMXJJLtMIUs4h7+lsdxK
aX0An2kpC7yt+E31jlShjLyc5/EdHWCs
=RrX1
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
