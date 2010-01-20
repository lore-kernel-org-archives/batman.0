Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 20 Jan 2010 19:05:19 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100120180519.GA25218@pandem0nium>
References: <20091231105246.GI8143@lunn.ch>
	<20100101160502.GA16855@pandem0nium>
	<201001200920.34384.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <201001200920.34384.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [Patch 1/1] Staging: batman-adv:
	Use?printk	(%pM) for MAC addresses
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Whoops ... added in r1559.

On Wed, Jan 20, 2010 at 09:20:34AM +0800, Marek Lindner wrote:
>=20
> Hey,
>=20
> > thank you for the patch, it is committed now in r1526. I've added some
> > changes to your patch to allow compatibility for all currently suported
> > kernels again. This includes:
> >=20
> >  * removing ipv4/ipv6 printing support in bat_printk
> >  * pack_hex_byte() (used in bat_printk()) was missing in older kernels
> >  * various stuff in compat.h to avoid regressions from my skb patch
> >  * skb->dev->stats was not available in older kernels
>=20
> it seems you forgot to upload the bat_printk.c file ...  :)
>=20
> Cheers,
> Marek
>=20

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktXRd8ACgkQrzg/fFk7axZWfgCdG44yDeHEuKgCywpfY4UfnOzB
x50AoIG8vqtJE93H8swKwRtZ4W6GGLGf
=sl+g
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
