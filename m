Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 20 Mar 2018 03:13:27 +0100
Message-Id: <20180320021327.30877-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix multicast-via-unicast
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
To: b.a.t.m.a.n@lists.open-mesh.org

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

Fixes: 405cc1e5a81e ("batman-adv: Modified forwarding behaviour for multicast packets")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

---

This issue currently cannot appear in the wild. See explanation here:

https://www.open-mesh.org/issues/335#note-16

However if we were to legitimately start using these flags for
multicast's own purposes then we would start to see issues in AP
isolation setups. Therefore, and because the fix is tiny and "obvious",
I think it would still make sense to send it through stable@.
---
 net/batman-adv/multicast.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index de3a055f..a11d3d89 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -869,8 +869,8 @@ static struct batadv_orig_node *
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

