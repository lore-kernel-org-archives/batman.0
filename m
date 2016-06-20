Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 20 Jun 2016 17:18:34 +0800
Message-ID: <1656954.q6VqPMNhCm@voltaire>
In-Reply-To: <1465575241-1754-1-git-send-email-sven@narfation.org>
References: <1465575241-1754-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1518497.DkdDhklQk1";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: Avoid skb free for
	batadv_send_skb_to_orig < -1
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

--nextPart1518497.DkdDhklQk1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, June 10, 2016 18:14:00 Sven Eckelmann wrote:
> The tp_meter code frees the skb when the batadv_send_skb_to_orig returns <
> 0. But the batadv_send_skb_to_orig only defines -1 as return code for
> failed submits with still valid skbs.
> 
> Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Interesting because a patch was submitted to net next to remove
> NET_XMIT_POLICED and return -EINPROGRESS instead.
> 
> I will maybe later send more patches because the current way of handling
> DROPPED/free'd skb/not-freed skb is quite confusing.
> 
>  net/batman-adv/tp_meter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 1aaa327.

Thanks,
Marek

--nextPart1518497.DkdDhklQk1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXZ7TqAAoJEFNVTo/uthzArW8H/jTCh/CbAsI43P2gquzqrhlb
/f1Lu9lSJ74OPguFoh9U54kdZVK/5sCJZwFGOg+xMDgpCH+otjNZ0otShagtP+en
jTm2GgWJhbeuU+pLRIP/El4+JjsDgK8V8pqjpUKyGhuW55bCMX7EPntmlEEJRH7s
Ei/t2exo3NdW6bCyry0aZUPRySsR8ObQ130yv6nkv6tRf5xJHdstgTN7pw/50OPc
Nobg83/dtYrQ4e0muNlimWTqyKND3DQzmcO0D3XsoueQVxaeI+74/TJt5O7b7X0+
janTyIVhlRN6ovPu0tVlzb3DVm4g3PxlZU9Dmh56K8oq2UtYt3MDMXrLzFAw3Qs=
=KrPz
-----END PGP SIGNATURE-----

--nextPart1518497.DkdDhklQk1--

