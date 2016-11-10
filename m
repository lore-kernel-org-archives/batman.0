Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 Nov 2016 08:12:20 +0100
Message-ID: <5564857.CHgeU219yd@bentobox>
In-Reply-To: <20161108175905.29961-1-sven@narfation.org>
References: <20161108175905.29961-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1856573.Gv1uEjmQDk";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Consume dropped packets with
	kfree_skb
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

--nextPart1856573.Gv1uEjmQDk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 8. November 2016 18:59:05 CET Sven Eckelmann wrote:
> The dropped skbs were previously free'd using kfree_skb in
> batadv_batman_skb_recv with kfree_skb. This has to be done again directly
> in the functions which also consume the skb on success.
> 
> Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
> Fixes: 83fef820ecdb ("batman-adv: Consume skb in receive handlers")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bat_iv_ogm.c | 5 ++++-
>  net/batman-adv/bat_v_elp.c  | 7 +++++--
>  net/batman-adv/bat_v_ogm.c  | 5 ++++-
>  net/batman-adv/routing.c    | 2 +-
>  4 files changed, 14 insertions(+), 5 deletions(-)


Applied in 7c21738fdfbdb50996e518cbf6bb4b30d8c04519 [1]

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/7c21738fdfbdb50996e518cbf6bb4b30d8c04519

--nextPart1856573.Gv1uEjmQDk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYJB3UAAoJEF2HCgfBJntGuxcQANP/kQbSegL6HSqsnRGYKP9c
Yw/B5gs4wO3p1aWlrkEwtYWB50ZUwjRthgH0IohVnVKxB/G3OnrZswIP2/nypwRu
GSWbOTQkEi2OgR0oDMcIis2c0Q2YvM2NSBfZqthnq30SUCquNK/NNBikSsfYbCkX
wb9dghtPW6BjVL4VsldRkvcdFteZlpq1FX611cyzmMRQV4U85ANjKl7VT2HnPX/s
8BbX3HVCKoOPxhKAce3Tnlv4parI3cs3yBHihPUPqk4Q3SDViorCCI2TBIU78wVS
ix9twlsmvEiommmg/Mi6KNcnG7KwZxIgObRTPdK8jvKEw+Q1WK4EQDJkFAxlXs8x
265eXyZoAtivjw/+lgoZ5FICma7cg8HhoiRMzBqvGdtCn1zOnqhqwuTnSxxNT2mn
l2JeqMdHpixNBjnsFFlSPt3BCS/Lzlbwnjl2+4QbmLCjAv2Hq0aseKsgxAlPnJw1
STOyHPxEge98eRfrgLR2jTwMCkupMgP9ztZS5eMNUmPslRWjrgJboV2+mxVvtpwm
g2yxXm1PWjMYeW3zH+cfxusuC3pltJY4Tj4pBCvNlpY6q04dKETdPQCj+GWcQ2+7
2iK4gxKsK9Q4wPOJVZqX/ZW1SULJ/4IFc9dppr1bJtfCTIg0ljdJhZIJWp8b2KWw
NzFS/yz9Ubj4h3qwUuBM
=u6Yu
-----END PGP SIGNATURE-----

--nextPart1856573.Gv1uEjmQDk--

