Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 13:28:08 +0200
Message-ID: <1848201.Rvlg2gJ3J4@bentobox>
In-Reply-To: <1469143811-15498-2-git-send-email-sven@narfation.org>
References: <1469143811-15498-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3510028.vOjm60GLg5";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [2/3] batman-adv: Move batadv_sum_counter to
	soft-interface.c
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

--nextPart3510028.vOjm60GLg5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 22. Juli 2016 01:30:10 CEST Sven Eckelmann wrote:
> The function batadv_sum_counter is only used in soft-interface.c and has no
> special relevance for main.h.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/main.h           | 21 ---------------------
>  net/batman-adv/soft-interface.c | 21 +++++++++++++++++++++
>  2 files changed, 21 insertions(+), 21 deletions(-)

Applied in 173408336c72f5d1ce049b3adeba8d1ce9a3a2b8 [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/173408336c72f5d1ce049b3adeba8d1ce9a3a2b8
--nextPart3510028.vOjm60GLg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBgdIAAoJEF2HCgfBJntGjDgQAKcrrVppTynw5Dcf/PO5LdFj
fZXX260uVBOOJCHQrJ+p6S3wQyZem//h7bkLKy+38GnQCfOgXAAWtczrFByUgo3J
wLT82Z+48NNwOJ3RNchxJL4+rnaSNCe9+6ZYyxuoMHj9FLt/jEEn13m6z9+fHatc
TkLcznYLkNsvodkP4T/OGyFq/5nkvO7VyddtNBWAyqMW3e9xGVq7QdhB5wn355hK
CpXvuLM1N6f+xOHru2FaW2E2N5OXdN23ts91iPtiS5icF6nTQqzVnXe41TbQ0H3x
q4+8BkRx5lNB6+zNoPTRRWcaVBggftg9F8lQiuJr7WYQ+CkmTxlk+XOR0vkPgRj1
313L0dFnNq6mSVI0hAR0ZMPua6io+jX6Yc1bGQ3AVkeYv7V3VtdvA7YBsoC6jreE
E3fpJC+vkUsKDPjBVs0t9StyOupHXL514UUqHX/keQrcDgnbUkABus1BlPa+BTTd
D1XeKapI5Szmci3qnMklPN3nFZDeMbfg0ptBvvDlp/KBT4L+BDS4RoLshXsmvDJ2
thWrrt4S7jILpAgCuz+JqPYbsfC8qRqGWAs4jHx3gsOt0ASB+d+ytTGNWJZjTbxI
HlgOFZ14nvqSucMmyBqu6x7pphhdg4eQg3CxFQmICzC5NwlXMP5d1/A6qMketSxu
ylxwb9Oc1Lxmpp8NTxVq
=rWoi
-----END PGP SIGNATURE-----

--nextPart3510028.vOjm60GLg5--

