Return-Path: <antonio@meshcoding.com>
Message-ID: <5534EB7E.2060809@meshcoding.com>
Date: Mon, 20 Apr 2015 14:05:18 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <13114664.Eg4ODy7KEo@bentobox> <6809018.15Hlry5Imp@voltaire>
 <7856073.VVMjEpdh4f@sven-edge> <28031511.vQmOOoKVTs@voltaire>
In-Reply-To: <28031511.vQmOOoKVTs@voltaire>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gDqHN8LexIH6T6JTPR4rITxbPcGwQutjs"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next 0/6] Patches for batman-adv 2015.0
 release
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gDqHN8LexIH6T6JTPR4rITxbPcGwQutjs
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 20/04/15 08:30, Marek Lindner wrote:
> I hope Antonio is going to shed some light on the question whether that=
 patch=20
> made it upstream or not. Depending on that question we can pick the=20
> appropriate solution.

This patch was never sent upstream, probably because it looked like some
change made for "compat.* only" and therefore it got accidentally discard=
ed.

By the way, when I created this patch I thought that the name of the
function was supposed to match the type of the object to free because I
observed a compilation failure - this is why I created this change.

But if this is not really required then I am ok with Sven's patch.


Cheers,

--=20
Antonio Quartulli


--gDqHN8LexIH6T6JTPR4rITxbPcGwQutjs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVNOuCAAoJEJgn97Bh2u9ew4gQAJlqZK70x469ATIvNFJilTBS
mhzSPSJoLktjttdIJh2uuJiEOtLbxNdhnKLyXOOv6QzG+4UqwosrDKFpj+CBbtn7
ipej7j73flB5W3SurvmLXuMGYfdenIVe40BczmR4HTSr5fUiqCk1r1lczGclhg0A
HcypRuxcvqQQ79TlTSLZ+9AW/aYMJiuzPblqQti4Or57thbd1ERmU3y2bpZ4bPkk
xf6Cgyr1XhLn/snZksxFRBN0xv/gFvoSaV27NJniaXJr57CPvNWYEtEk79Vc2EUz
Jghp2rfgg8gHNvoG4kC80X4wr+uePxTzr6fXZFVnmYWc6HvgblLVa4BChgXRMm1K
qlk6wo8rsOQPLI9b5fTg94Q4YW5RwNCbLIaeoFAkRo1gLxDQAN0pI+gYmRxGjf0x
kVG1wxvTEpd4lsUhoixvgBLDavtXhfM5GAFFu2fKIiAZEMyIu1uciSl5Nou5qZCw
YcYc9IV2jnwXH3sjaTX3Qo8e234HPrfP1W86dRIzbnYjtrtD/ZOQZC60d2+BisN4
4zCXCEqCDCz7yKYm8Tz7r79cP4MOZdy1xvPzoy0cSOAk46KM2dSfHopRHSp4iYiG
4Qp0guiQYNscpKe0XqmL7hc5Co+/E7npbdQ8lU6I0lLXG7tHNZzNwsrOsHOhcZCl
Rpb7xdJ4IPXbIkKpPbC4
=zJRM
-----END PGP SIGNATURE-----

--gDqHN8LexIH6T6JTPR4rITxbPcGwQutjs--
