Return-Path: <a@unstable.cc>
Date: Sun, 28 Feb 2016 17:08:38 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160228090838.GK28478@prodigo>
References: <1456607048-24975-1-git-send-email-a@unstable.cc>
 <1456644694-8497-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cW+P/jduATWpL925"
Content-Disposition: inline
In-Reply-To: <1456644694-8497-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC next v2] batman-adv: ELP - use new
 ethtool_link_get_ksettings API
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


--cW+P/jduATWpL925
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 28, 2016 at 08:31:34AM +0100, Sven Eckelmann wrote:
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 6, 0)
> +
> +#define ethtool_link_ksettings batadv_ethtool_link_ksettings
> +
> +struct batadv_ethtool_link_ksettings {
> +	struct {
> +		__u32	speed;
> +		__u8	duplex;
> +	} base;
> +};
> +
> +#define __ethtool_get_link_ksettings(__dev, __link_settings) \
> +	batadv_ethtool_get_link_ksettings(__dev, __link_settings)
> +
> +static inline int
> +batadv_ethtool_get_link_ksettings(struct net_device *dev,
> +				  struct ethtool_link_ksettings *link_ksettings)
> +{
> +	struct ethtool_cmd cmd;
> +	int ret;
> +
> +	memset(&cmd, 0, sizeof(cmd));
> +	ret =3D __ethtool_get_settings(dev, &cmd);
> +
> +	if (ret !=3D 0)
> +		return ret;
> +
> +	link_ksettings->base.duplex =3D cmd.duplex;
> +	link_ksettings->base.speed =3D ethtool_cmd_speed(&cmd);
> +
> +	return 0;
> +}
> +
> +#endif /* < KERNEL_VERSION(4, 6, 0) */

Hi Sven,

I really like this approach! thanks a lot!
By the way, you should have added your name to the list of contributor of t=
his
file though :)


How about re-sending this RFC as PATCH (with your sign-off as well) ?


Cheers,

--=20
Antonio Quartulli

--cW+P/jduATWpL925
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW0rkWAAoJENpFlCjNi1MRLcQP/2YRpmh8FL1ihDpIID2ro0x/
Dozp7TxhMu53XBflVWp2YH7H/IgrnrwgNjhGsBvbAonCMLbAb3h60AaOKjXXp83W
KHn2BROuLeC2RGOSrmfrYaVw18Udpe58K1epLZYacNf/AAnCLq9D2ZzaA5X1GL8b
XfYW6758jtX1qE8kjvw+kNUWAQeIt0Y00VC3F+OilKPJY2XvuS0dsDxiFh/oyDZM
Y6msLuo735EiUfeekjPYHjMILsW7J4VFSQumwAcj2xpA0Cpk98wMSmXY9znqtalR
FcshVrx1DSGK/e/NocuWq4Rv/vPLj5FohzYMhEeOdFL7av03cCH5NNlFAW+sA1Of
/zeSViA0GKKKlOQU1DrE1ga+qNPVWjfzRDsWCV8xDWvxIPwqJ4aQQ/PpREk8OrXj
34ShVsemGkLlY/dO3h5JIME5nqWVAwN4sbmhbLUzYoyAvzUuaYmtxf7HE27ufFUp
0UOHr1XHxstuZFBhB1l4/Tvmhvj43eCuU1XnruTaycH0rDiSelL7zHSJtblcwClh
9KfMy4kuUCBPoWM6UYqULW4Uwh3hKB55aTah3in8C1UQ80b/L4H6R9gSha1xVZiy
A518Ww/h64UF65DNr8Qbu3x+2fBFxC2MY0c+d9IAA01x0LNkT7yDHi+lQaIH6z4k
msU4Y1q9q6Czvrkq986f
=agEK
-----END PGP SIGNATURE-----

--cW+P/jduATWpL925--
