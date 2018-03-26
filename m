Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 26 Mar 2018 14:47:53 +0200
Message-Id: <20180326124754.5897-2-sw@simonwunderlich.de>
In-Reply-To: <20180326124754.5897-1-sw@simonwunderlich.de>
References: <20180326124754.5897-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: fix multicast-via-unicast
 transmission with AP isolation
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Linus Lüssing <linus.luessing@c0d3.blue>

For multicast frames AP isolation is only supposed to be checked on
the receiving nodes and never on the originating one.

Furthermore, the isolation or wifi flag bits should only be intepreted
as such for unicast and never multicast TT entries.

By injecting flags to the multicast TT entry claimed by a single
target node it was verified in tests that this multicast address
becomes unreachable, leading to packet loss.

Omitting the "src" parameter to the batadv_transtable_search() call
successfully skipped the AP isolation check and made the target
reachable again.

Fixes: 1d8ab8d3c176 ("batman-adv: Modified forwarding behaviour for multicast packets")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index d70640135e3a..ee56af5c43e0 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -814,8 +814,8 @@ static struct batadv_orig_node *
 batadv_mcast_forw_tt_node_get(struct batadv_priv *bat_priv,
 			      struct ethhdr *ethhdr)
 {
-	return batadv_transtable_search(bat_priv, ethhdr->h_source,
-					ethhdr->h_dest, BATADV_NO_FLAGS);
+	return batadv_transtable_search(bat_priv, NULL, ethhdr->h_dest,
+					BATADV_NO_FLAGS);
 }
 
 /**
-- 
2.11.0

