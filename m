Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 Feb 2018 12:03:37 +0100
Message-Id: <20180224110337.11985-2-sven@narfation.org>
In-Reply-To: <20180224110337.11985-1-sven@narfation.org>
References: <20180224110337.11985-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: Fix netlink dumping of
 BLA backbones
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

The function batadv_bla_backbone_dump_bucket must be able to handle
non-complete dumps of a single bucket. It tries to do that by saving the
latest dumped index in *idx_skip to inform the caller about the current
state.

But the caller only assumes that buckets were not completely dumped when
the return code is non-zero. This function must therefore also return a
non-zero index when the dumping of an entry failed. Otherwise the caller
will just skip all remaining buckets.

And the function must also reset *idx_skip back to zero when it finished a
bucket. Otherwise it will skip the same number of entries in the next
bucket as the previous one had.

Fixes: 7f609cab5123 ("batman-adv: add backbone table netlink support")
Reported-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 60ce119e..422ee16b 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -2394,22 +2394,25 @@ batadv_bla_backbone_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
 	int idx = 0;
+	int ret = 0;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
 		if (idx++ < *idx_skip)
 			continue;
-		if (batadv_bla_backbone_dump_entry(msg, portid, seq,
-						   primary_if, backbone_gw)) {
+
+		ret = batadv_bla_backbone_dump_entry(msg, portid, seq,
+						     primary_if, backbone_gw);
+		if (ret) {
 			*idx_skip = idx - 1;
 			goto unlock;
 		}
 	}
 
-	*idx_skip = idx;
+	*idx_skip = 0;
 unlock:
 	rcu_read_unlock();
-	return 0;
+	return ret;
 }
 
 /**
-- 
2.16.1

