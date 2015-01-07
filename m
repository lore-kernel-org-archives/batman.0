Return-Path: <antonio@meshcoding.com>
Message-ID: <54ADA227.1040806@meshcoding.com>
Date: Wed, 07 Jan 2015 22:16:23 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1417284466-32016-1-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1417284466-32016-1-git-send-email-mpa@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oeEaKrNSNKesLVoUedGbG5s43B8itNEd9"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Kconfig,
 Add missing DEBUG_FS dependency
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
To: "mpa@pengutronix.de >> Markus Pargmann" <mpa@pengutronix.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oeEaKrNSNKesLVoUedGbG5s43B8itNEd9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 29/11/14 19:07, Markus Pargmann wrote:
> BATMAN_ADV_DEBUG is using debugfs files for the debugging log. So it
> depends on DEBUG_FS which is missing as dependency in the Kconfig file.=

>=20
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Applied to my tree and queued for being sent upstream.
Thanks!


--=20
Antonio Quartulli


--oeEaKrNSNKesLVoUedGbG5s43B8itNEd9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAEBCAAGBQJUraIsAAoJEJgn97Bh2u9ewgIP9jg6Zs/vPr+qpqRoZU6qMWVk
qDqDTP32F7L8hVo02S3iAQArEJEl5UjktV/RUmK5lHDv/1HRQfwglhTvJE/KUt/6
wcFBpXXvZl1rAyYi0nVk7/T19tmLibnBRJAVlFZF7bxRdPpTJPTpg5NvYjLFU5NI
asimvyKWk519nljbyMn18ydMGNlOO5UldyC8o3Duj+QJsVtw9Hb4tdOkBoK5Xgo9
iNqZWwHPH+rXndHTEws2mg+K5gtaE1y9GxojWLvyxaVtZZ8ZGiolnv6CJHRNVmHE
ZcgCt2be3gl2tcQTqqNuQmPCVo4R6937rGdK4Xvv+Lbfspr0Vm7bpbZ4E9ohRGlQ
RYiijU2w+3XMByLdYFtiewkEWhAck+U4LGcJldgtexVSOehgt+dEwPwB/cfs52Ck
CvY+MolLoWklTuVhbinduoPZNs+u+xBo9zEUbkDSzROQFePpqTt66gQxg8+A8eZf
xN6hq8VjqEeFNyaQpX+ew8AHWnQ547v6thi5QI+ag7SHEGlLF99FOD8iMjhiLc7h
wjJ3UsBa179/jcYXA1o2C9gcRZgnc1H1ByLic4mZL6Q7MeBZeCvLzvq7QKM81LSp
wt0QUF2buiKeHLBjvdai5uSyCpiYfMAPPZxLaEuW2Cr8GUbuY4e3YPbKfRgl0E17
RS64YIqrdfPMfx78/14=
=uzFj
-----END PGP SIGNATURE-----

--oeEaKrNSNKesLVoUedGbG5s43B8itNEd9--
