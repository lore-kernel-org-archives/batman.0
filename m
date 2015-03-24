Return-Path: <mpa@pengutronix.de>
Date: Tue, 24 Mar 2015 12:35:24 +0100
From: Markus Pargmann <mpa@pengutronix.de>
Message-ID: <20150324113524.GC28604@pengutronix.de>
References: <1427035879-24616-1-git-send-email-sven@narfation.org>
 <1427035879-24616-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Content-Disposition: inline
In-Reply-To: <1427035879-24616-2-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Add required to includes
	to all files
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sven,

On Sun, Mar 22, 2015 at 03:51:17PM +0100, Sven Eckelmann wrote:
> The source and header files could not be build indepdent from each other.=
 This
> is happened because headers didn't include all includes for anything they=
've
> used. This was problematic because the success of a build required to kno=
w the
> right order of local includes.
>=20
> Also source files were not including everything they've used explicitly.
> Instead it required that transient includes are always stable. This is
> problematic because some transient includes are not obvious, depent on co=
nfig
> settings and may not be stable in the future.
>=20
> The order for include blocks are:
>=20
>  * primary headers (main.h and the *.h file of a *.c file)
>  * global linux headers
>  * required local headers
>  * extra forward declarations for pointers in function/struct declarations

Thanks for your work. This patch looks really good.

Best Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVEUv8AAoJEEpcgKtcEGQQQhsP/2bLnltiGORPhEAfek4lDJmS
FnAwDaghzeg6xZDikizX7Q2r6mexU7gMklzO7WqznD7FiQ5sb++POqKrtFSV3QjI
3L5Iw0i18IjVvWATqnse4IO2JwkjUF65mV4WnMrM5LIm5ELZqAOafrElSXnVGPok
3EFVYNlXP1SvF8sNossfv/6kdLQJIuy58GfVi53ytFigQVR1dM/degZvoVLExF5c
z76ho1Df8jC8JWlJWG+aqR+mQOT5bazqnY7lyKqf7P9IkNkFjkZpRX6GrvllYubX
+co5H26kXMEX2YsRkCRZlcJn+JvamfkU3YnI+PeXtjY9f9IniIQ07G77MkUzCr28
anClX0mlyKvmBvLOA8D43XBdPktkG0+aW05n/4qzr9WnZmqmtX3o9Oqc3D8GcXBw
dNzpYAOMvHWLdXKDwVBKAhV4ZoVIdbJtpnlfaea6WoBJgorDwMPRV1oaOkd1AAkk
5h03pDtPZ1qu0jwQ2DYAkRsmXPr1UGHt7VuoFpPmgno7Db+Cq43bzHESIrJdbWiZ
TsJL8Pg1HOtpiQt2CCdJo4WMMIv8QJRlUGvyEYeeSJJ2rauJwen14rByOAku3/SZ
XDNxGFOFJJ9UMCMmflS2LBheNUH9j24Baz9b4xHdCVtMiEpBs8IXcv2ZJ4tTXySm
VHPf7jJKQ6gEUA05sVBA
=InzW
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--
