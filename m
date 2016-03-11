Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 11 Mar 2016 16:25 +0100
Message-ID: <2174915.lOId8kMdZA@bentobox>
In-Reply-To: <1383809091-3887-1-git-send-email-antonio@meshcoding.com>
References: <1383809091-3887-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1476395.4exdWFMgGo";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use static string for table
	headers
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

--nextPart1476395.4exdWFMgGo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 07 November 2013 08:24:51 Antonio Quartulli wrote:
> Use a static string when showing table headers rather then
> a nonsense parametric one with fixed arguments.
> 
> It is easier to grep and it does not need to be recomputed
> at runtime each time.
> 
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  bat_iv_ogm.c            | 5 ++---
>  bridge_loop_avoidance.c | 7 +++----
>  distributed-arp-table.c | 4 ++--
>  translation-table.c     | 9 ++++-----
>  4 files changed, 11 insertions(+), 14 deletions(-)
> 

It looks that there now one more table in net/batman-adv/bat_iv_ogm.c and
two in net/batman-adv/bat_v.c

    $ git grep seq_printf|grep '%-'
    net/batman-adv/bat_iv_ogm.c:    seq_printf(seq, "  %-15s %s (%s/%i) %17s [%10s]: %20s ...\n",
    net/batman-adv/bat_iv_ogm.c:    seq_printf(seq, "   %10s        %-13s %s\n",
    net/batman-adv/bat_v.c: seq_printf(seq, "  %-15s %s (%11s) [%10s]\n", "Neighbor",
    net/batman-adv/bat_v.c: seq_printf(seq, "  %-15s %s (%11s) %17s [%10s]: %20s ...\n",
    net/batman-adv/bridge_loop_avoidance.c: seq_printf(seq, "   %-17s    %-5s    %-17s [o] (%-6s)\n",
    net/batman-adv/bridge_loop_avoidance.c: seq_printf(seq, "   %-17s    %-5s %-9s (%-6s)\n",
    net/batman-adv/distributed-arp-table.c: seq_printf(seq, "          %-7s          %-9s %4s %11s\n", "IPv4",
    net/batman-adv/translation-table.c:     seq_printf(seq, "       %-13s  %s %-8s %-9s (%-10s)\n", "Client", "VID",
    net/batman-adv/translation-table.c:     seq_printf(seq, "       %-13s  %s  %s       %-15s %s (%-10s) %s\n",

But I can update these parts myself and send a fresh version to the
mailing list.

Kind regards,
	Sve
--nextPart1476395.4exdWFMgGo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAABCgAGBQJW4uNMAAoJEF2HCgfBJntGYDIP92CagPSsryFmsxMjWLbvam+1
5g2olHs1dGZF1Mr1tHnJ3o7mgGQ9jMox/PaR54jJW0xMy/sjyv61wLGxMZ56Cg2P
QiWe9OFCoc04mC5a295OlZd/gy607KDRD+8rxj1gC6JuH597Kj8OcOm/QTFnbb20
ue7RDDqK5QnlKihddGe7Tzv6k9MlrbwC8FCQeQiMMghtk2bPaTINJMl6o5ku0g22
CggS04eHa1lWny7gdKjvnorh6qkp7k1xOxzNgpapBVkE3fxwirCJDhtOUljBVk6A
2RRBXehr91RWkGX5xjxwrzXPBUOE5GxenfQJ9yi+YQ0B0BM/PbFkwWQnKRR0qvkI
BO7vyOrq7HF9fyln2pBMjraxjfRK2Gms19T4lJngmlLQYnkZnhF1xLb4EIUn1o0Z
tLQSErFyLn4fgc24NsTdQAfTKgjfmKPsqs5OspKJAlvNUSqyyE4VuocwVvv/euxc
XXdv9+nzjtYLrTtaGBGfdm0AiETAjvTUYWYQCOrk5BOYv7OuVkc5EiFO7TThXfL8
LnqAfGbKmLWa5eRC/GkqeJRdysLkUH9hXHkvB/fjCfC7ADH4zfhe0+Q1+4CAXo7b
ZT5bS0qfiGK5rfQmKO7vFxxVtheCUIdnA/r0pB7Z9DG8B4qifNhvqjMQlhnryo2+
8am1pj8zZTpQ0LZB7Bs=
=1L3v
-----END PGP SIGNATURE-----

--nextPart1476395.4exdWFMgGo--

