Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri, 17 Feb 2017 13:07:04 +0100
Message-Id: <20170217120705.21823-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] RFC: batman-adv: BATMAN V: Make route
	switching more opportunistic
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

Increase route switching likelikood with every seqno we missed from our
currently selected router.

This is safe to do without causing any loops at any time because the
sequence number is strictly larger than the one we last got from our
selected router.

---
Another idea to improve route convergence time. Simpler than the
"Rest-In-Peace" protocol idea, but they should be combinable.

Idea is a little inspired from once again potentially having missed a
bus: Should I stick to the plan of taking the bus and wait a few more
minutes (maybe it is just late?) or should I walk instead?

(Here in Lübeck buses usually arrive about every 30min. - or not all
between 00:30 and 04:30 - so it often makes sense to just use
the slower alternative of walking if you have missed it :-) )

Also inspired by the asymmetric link penalty.

Potential cons:

* might potentially increase route flappiness if the route has
  a certain amount of packet loss / length
  -> Maybe additional to broadcasting OGMs to neighbors, distribute it
     to a few, good/promising ones via unicast, too?

PS: Please disregard the patch style, it's just an RFC for the
concept/idea for now :-)
---
 net/batman-adv/bat_v_ogm.c | 51 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 03a35c9..08a79a9 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -492,6 +492,53 @@ out:
 }
 
 /**
+ * batadv_v_ogm_seq_tx - penalize router throughput
+ * @router_throughput: the router throughput to penalize
+ * @seq_diff: seqno diff between OGM and current router
+ */
+static u32 batadv_v_ogm_seq_tx(u32 router_throughput, u32 seq_diff)
+{
+	const u32 m = BATADV_OGM_MAX_ORIGDIFF;
+	const u32 r = router_throughput;
+	const u32 d = seq_diff;
+	u64 ret;
+
+	if (s <= 1)
+		return r;
+	else if (s >= d)
+		return 0;
+
+	/* f(x) = [ - 1/(m-1)^2 * (d-1)^2 + 1 ] * r */
+	ret = r * (m-1) * (m-1) - r * (d-1) * (d-1)
+	return (u32)(ret / ( (m-1) * (m-1) ));
+
+	/**
+	 * For BATADV_OGM_MAX_ORIGDIFF == 5 equivalent to:
+	 */
+	switch(seq_diff) {
+		case 0:
+			/* fallthrough */
+		case 1:
+			/* no penalty for seq-diff == 1 either,
+			 * maybe the best route has just a little more
+			 * latency
+			 */
+			return router_throughput;
+		case 2:
+			/* 15/16 */
+			return 0.9375 * router_throughput;
+		case 3:
+			/* 3/4 */
+			return 0.75 * router_throughput;
+		case 4:
+			/* 7/16 */
+			return 0.4375 * router_throughput;
+		default:
+			return 0;
+	}
+}
+
+/**
  * batadv_v_ogm_route_update - update routes based on OGM
  * @bat_priv: the bat priv with all the soft interface information
  * @ethhdr: the Ethernet header of the OGM2
@@ -570,8 +617,8 @@ static bool batadv_v_ogm_route_update(struct batadv_priv *bat_priv,
 		router_throughput = router_ifinfo->bat_v.throughput;
 		neigh_throughput = neigh_ifinfo->bat_v.throughput;
 
-		if ((neigh_seq_diff < BATADV_OGM_MAX_ORIGDIFF) &&
-		    (router_throughput >= neigh_throughput))
+		if (batadv_v_ogm_seq_tx(router_throughput, neigh_seq_diff)
+		    >= neigh_throughput)
 			goto out;
 	}
 
-- 
2.1.4

