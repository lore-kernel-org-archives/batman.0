Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 20 Mar 2016 18:01:59 +0800
Message-ID: <1587097.Jr0CeR2il1@voltaire>
In-Reply-To: <1456655932-22746-3-git-send-email-sven@narfation.org>
References: <3805562.RtX9XxSZnx@sven-edge>
 <1456655932-22746-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10140328.ZJ2jUQugrX";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Remove hdr_size skb size
	check in batadv_interface_rx
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

--nextPart10140328.ZJ2jUQugrX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, February 28, 2016 11:38:52 Sven Eckelmann wrote:
> The callers of batadv_interface_rx have to make sure that enough data can
> be pulled from the skb when they read the batman-adv header. The only two
> functions using it are either calling pskb_may_pull with hdr_size directly
> (batadv_recv_bcast_packet) or indirectly via batadv_check_unicast_packet
> (batadv_recv_unicast_packet).
> 
> Reported-by: Marek Lindner <mareklindner@neomailbox.ch>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/soft-interface.c | 4 ----
>  1 file changed, 4 deletions(-)

Applied in revision d1c596a.

Thanks,
Marek

--nextPart10140328.ZJ2jUQugrX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW7nUXAAoJEFNVTo/uthzAqNoH/2wwytgUAjQvyWSmsQb3734U
GeFq4YX58P5Oa5/58We1ZmYCL2Qp76BjgPqGDxePsYTKQflcPktsB3lESLO7mO7i
wWTCVPv8N7cE415PwbdPnvQ9RcZUarzs8VrR05fB7JIiiRgUi/9UzmmrhaR3v3Gd
AfilEoKZFALa9S3WTcCGiZcOMJDDe96A/4QY/BYI9SWffuyh4BegQGYjLcukLLRB
8Fkugob0EfueLoxp/IHC0st9liptbjZq4tRYoy63lMAYyz5HjyAVoq6VjFD8WiSS
KSrmPywEvd6I4xQzNDCAwdhdjWmGLUAXymz04/UNrDrpdcbOOJZRgdGmtn/NehM=
=9eU2
-----END PGP SIGNATURE-----

--nextPart10140328.ZJ2jUQugrX--

