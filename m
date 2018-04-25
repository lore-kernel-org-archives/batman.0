Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 25 Apr 2018 19:20:47 +0200
Message-ID: <5487149.BXJuGhpdTS@sven-edge>
In-Reply-To: <20180419181420.3167-1-sven@narfation.org>
References: <20180419181420.3167-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14663054.7NeuDppGTY";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Don't translate multicast and
 zero mac addresses
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

--nextPart14663054.7NeuDppGTY
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 19. April 2018 20:14:20 CEST Sven Eckelmann wrote:
> Instead of disabling multicast optimizations mesh-wide once a node with
> no multicast optimizations capabilities joins the mesh, do the
> following:
>=20
> Just insert such nodes into the WANT_ALL_IPV4/IPV6 lists. This is
> sufficient to avoid multicast packet loss to such unsupportive nodes.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  net/batman-adv/multicast.c      | 29 ++++++-----------------------
>  net/batman-adv/soft-interface.c |  1 -
>  net/batman-adv/types.h          |  3 ---
>  3 files changed, 6 insertions(+), 27 deletions(-)

Patch added as 70968bb67d4d [1]

Kind regards,
	Sven

[1] https://git.open-mesh.org/batctl.git/commit/70968bb67d4da6f3c9349697a70=
2dda4d2a8a166
--nextPart14663054.7NeuDppGTY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrguO8ACgkQXYcKB8Em
e0Ywhw/9GVBUPbl/tyuNboyLmNOsiBOpvSgmI38Ru5ISrhazH9JtxF827z8SPqE7
VX69dKi4QOABNyukRUfhZT/kXjnK6+L791lf/ByT1p3rrIjyb9pvdA0CSdhA1D5q
1Qrssic8A1U21t9u2u5iog/GbF//PPEYjOWyjwNYgPBAj5EQjmk9W62LLVcaJbJ9
MOHCVa2wTw5mkwzK9tuhJTjm2bMBlxAlV9STY63NyxlXkkkqQv6BNJyhyQWG4GUd
1M752saJARbYO5BqkcTxc2FcwcawrDdvhImN9aoltgP9ttbFLUPdhPRVk1O5h0GS
gTomhR6poIl053sf4j0eToDfl+e7MpPebBG2V0RYZ9+AgwTzgvRsQDqTPg3smXEc
fkBgLFICb4Yp4HpBwHK3lJntij4lkkAxzveObpH/g/zZLtx1w1pkSavaG+B1ARqs
gwZIUnovZDELiLAg1R5yiSDxzrPMM/8HAg3rvRUFRHTcKk88G+GR0SMm6wHg8DjR
IoTpTDzJ3zspgy0+AUIqeplj4Qj8k1C1UFF0pTvyVrD3qQLzvrb1BCu2dd06pE69
iixzxIUPNR3fu1NHDmVBY++MD/Fp7Ri65R8z0bOpKEcdKw/jOKycPZxNcITkFfxb
So1PNfRUNmt8k+hf0yJtocCZ8AMn8DeVOlxme1Uwvq9XJTGxcQg=
=mxaH
-----END PGP SIGNATURE-----

--nextPart14663054.7NeuDppGTY--



