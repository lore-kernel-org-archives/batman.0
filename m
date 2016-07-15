Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 15 Jul 2016 17:39:24 +0200
Message-Id: <1468597173-25378-9-git-send-email-sven@narfation.org>
In-Reply-To: <1468597173-25378-1-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 09/18] batman-adv: Place kref_get for
	bla_claim near use
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

It is hard to understand why the refcnt is increased when it isn't done
near the actual place the new reference is used. So using kref_get right
before the place which requires the reference and in the same function
helps to avoid accidental problems causedy incorrect reference counting.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - split patch based on type

 net/batman-adv/bridge_loop_avoidance.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index c75ef64..21bc3d0 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -711,12 +711,13 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 		claim->lasttime = jiffies;
 		kref_get(&backbone_gw->refcount);
 		claim->backbone_gw = backbone_gw;
-
 		kref_init(&claim->refcount);
-		kref_get(&claim->refcount);
+
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "bla_add_claim(): adding new entry %pM, vid %d to hash ...\n",
 			   mac, BATADV_PRINT_VID(vid));
+
+		kref_get(&claim->refcount);
 		hash_added = batadv_hash_add(bat_priv->bla.claim_hash,
 					     batadv_compare_claim,
 					     batadv_choose_claim, claim,
-- 
2.8.1

