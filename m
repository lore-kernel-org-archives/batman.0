Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 25 Dec 2012 17:03:19 +0800
Message-Id: <1356426206-8667-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/8] batman-adv: align kernel doc properly
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 types.h |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/types.h b/types.h
index d8061ac..dffbdff 100644
--- a/types.h
+++ b/types.h
@@ -66,19 +66,18 @@ struct batadv_hard_iface {
 };
 
 /**
- *	struct batadv_orig_node - structure for orig_list maintaining nodes of mesh
- *	@primary_addr: hosts primary interface address
- *	@last_seen: when last packet from this node was received
- *	@bcast_seqno_reset: time when the broadcast seqno window was reset
- *	@batman_seqno_reset: time when the batman seqno window was reset
- *	@gw_flags: flags related to gateway class
- *	@flags: for now only VIS_SERVER flag
- *	@last_real_seqno: last and best known sequence number
- *	@last_ttl: ttl of last received packet
- *	@last_bcast_seqno: last broadcast sequence number received by this host
- *
- *	@candidates: how many candidates are available
- *	@selected: next bonding candidate
+ * struct batadv_orig_node - structure for orig_list maintaining nodes of mesh
+ * @primary_addr: hosts primary interface address
+ * @last_seen: when last packet from this node was received
+ * @bcast_seqno_reset: time when the broadcast seqno window was reset
+ * @batman_seqno_reset: time when the batman seqno window was reset
+ * @gw_flags: flags related to gateway class
+ * @flags: for now only VIS_SERVER flag
+ * @last_real_seqno: last and best known sequence number
+ * @last_ttl: ttl of last received packet
+ * @last_bcast_seqno: last broadcast sequence number received by this host
+ * @candidates: how many candidates are available
+ * @selected: next bonding candidate
  */
 struct batadv_orig_node {
 	uint8_t orig[ETH_ALEN];
-- 
1.7.10.4

