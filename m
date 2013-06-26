Return-Path: <ordex@autistici.org>
Date: Wed, 26 Jun 2013 20:02:17 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130626180217.GC2120@ritirata.org>
References: <CAKON4Ox2+uFUWR5ZBQ8yHdWZWW0zrxAgkd8iv-QG3DtTnVKJWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Content-Disposition: inline
In-Reply-To: <CAKON4Ox2+uFUWR5ZBQ8yHdWZWW0zrxAgkd8iv-QG3DtTnVKJWQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] single radio routers and ap/adhoc interfaces
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


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2013 at 01:30:18PM -0400, jonsmirl@gmail.com wrote:
> I'd like to setup batman up on single radio routers. I've installed
> openwrt on three different chipsets now (RT3050, RT5350, AR9331) and
> none of these wireless drivers implements support for simultaneous
> adhoc and ap mode on virtual interfaces.
>=20
> Yet when I google around I see lots of examples of people using single
> radio routers with dual adhoc and ap mode virtual interfaces.  So
> which radios support simultaneous adhoc/ap mode?
>=20
> From AR9331...
> valid interface combinations:
> * #{ managed, WDS, P2P-client } <=3D 2048, #{ AP, mesh point, P2P-GO }
> <=3D 8, #{ IBSS } <=3D 1,
>   total <=3D 2048, #channels <=3D 1, STA/AP BI must match
> * #{ AP } <=3D 1,
>   total <=3D 1, #channels <=3D 1, STA/AP BI must match, radar detect
> widths: { 20 MHz (no HT), 20 MHz }

Am I wrong or AR9331 is handled by the ath5k driver?

However in openwrt you will find some patches that are editing these interf=
ace
combinations in order to allow IBSS + AP for some drivers (e.g. ath5k or
ath9k..).

This behaviour is not supported upstream for several reasons, therefore if =
you
look in the kernel source you will never find a combination allowing the
aforementioned schema.


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRyyypAAoJEADl0hg6qKeOYTIP/iwYVisUOf4rYuawqzAFXL1n
pldfyx/Uhw19SYZGmN/ny9TIffLtfZ5qOe9bpvIwa20f3MKgujAceZIj+f7gVnlw
LXiIVREl0YqHmKHXw/uE9+Jm8Yw2lm8cT3L1NOisPRNr5GNc76sC7yo8/yZc8UIH
KXMeAclFpA59IDlP4jFF85UGxpC+eueWPmZ/Bg8NuN+G+HPL5kiQWzp85TAnSAM9
mdEz5W5p2qS8/JO1y//HvmXds5SWcUkynubUIVpji26UUYUmlQCQiTb7gXlxCvj8
KH8BwHlJ7RIsmAEkU571DC7aOC9ffYI0Vuh6rGtgeSPfaZ2edQrFmCM33J0Dj+kk
ttdbApkT6TY9eGs6ATQPJwAnsSBaY+tIaBa82fuUwU3IzqQtIgr5Mz5yTNbbgbJx
I2TAGjQZpPF05r1Y2srA9mkis7uE6S2ragWbPa6tSiJwsY1c75obSoRwya+dveAG
LsfaIFMXz+AIsd3Cw14Dzul+qUUpqK9jI8zqvuIqxliMR0ImORRvpq3LUtlEo0FZ
rD5kaSq9QZ+WXJiuFl6F9XbXbq0G3pCCaYo91qKPd0+3cYHr4zd8vpROR0ZBHLjo
WT/sSiuMl7E4USOwpvl2QwuaIxNMS3lFq973uUygTJQ5G6If75Z9hUmlhh6FIA5D
SH8V9i4OvD+4Rdy7GvPe
=m5jo
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
