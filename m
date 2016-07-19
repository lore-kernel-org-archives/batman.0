Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 16:00:41 +0800
Message-ID: <6225691.OLhm6SdWFZ@voltaire>
In-Reply-To: <1467545508-7333-16-git-send-email-sven@narfation.org>
References: <1467545508-7333-1-git-send-email-sven@narfation.org>
 <1467545508-7333-16-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1522090.OzTStLAti6";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v10 15/16] batman-adv: add backbone table
	netlink support
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

--nextPart1522090.OzTStLAti6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 03, 2016 13:31:47 Sven Eckelmann wrote:
> From: Simon Wunderlich <sw@simonwunderlich.de>
> 
> Dump the list of bridge loop avoidance backbones via the netlink socket.
> 
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  include/uapi/linux/batman_adv.h        |   2 +
>  net/batman-adv/bridge_loop_avoidance.c | 164
> +++++++++++++++++++++++++++++++++ net/batman-adv/bridge_loop_avoidance.h
> |   7 ++
>  net/batman-adv/netlink.c               |   7 ++
>  4 files changed, 180 insertions(+)

Applied in revision 7f609ca.

Thanks,
Marek

--nextPart1522090.OzTStLAti6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjd4pAAoJEFNVTo/uthzA+f8H/is5k601BtOEMcz4MKCwijD5
6b/pYWZ9lNamgZbeZ3xx+8uamBXiBRTaYVnS+0sLBIYN7GDyW/aUpf6wAgV3oXun
cveuTRDtqQhB5fjpdy9s2ZmS0TM0WAErELT0awYTZ4x1MKw1yrPDxP7I/4nvvnSw
0ycNMa8HJPnr/z3wP2Z5GSGWo6YorxewiJnmA46GP5blv0Hr1fnkUi6Kf7YjW0rE
94aN27OZkstl6mQ3M2UVtEOMX5ytmr28jiaYHIA4rXR26wfOaStf0pb5BCYsd9FU
xKt4JEb1aEVoWORCcr6TPOrSKnw63bhkAuT+k1bM1N+fBngpOK2ygP4AzgUiEVg=
=O1x6
-----END PGP SIGNATURE-----

--nextPart1522090.OzTStLAti6--

