Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 24 Jan 2014 22:16:25 +0100
Message-Id: <1390598185-7221-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix a few kerneldoc
	inconsistencies
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

Reported-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 types.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/types.h b/types.h
index 78370ab..9f52517 100644
--- a/types.h
+++ b/types.h
@@ -163,7 +163,7 @@ struct batadv_vlan_tt {
 };
 
 /**
- * batadv_orig_node_vlan - VLAN specific data per orig_node
+ * struct batadv_orig_node_vlan - VLAN specific data per orig_node
  * @vid: the VLAN identifier
  * @tt: VLAN specific TT attributes
  * @list: list node for orig_node::vlan_list
@@ -334,7 +334,7 @@ struct batadv_neigh_node {
 };
 
 /**
- * struct batadv_neigh_node_bat_iv - neighbor information per outgoing
+ * struct batadv_neigh_ifinfo_bat_iv - neighbor information per outgoing
  *  interface for BATMAN IV
  * @tq_recv: ring buffer of received TQ values from this neigh node
  * @tq_index: ring buffer index
@@ -544,7 +544,7 @@ struct batadv_priv_bla {
 #endif
 
 /**
- * struct batadv_debug_log - debug logging data
+ * struct batadv_priv_debug_log - debug logging data
  * @log_buff: buffer holding the logs (ring bufer)
  * @log_start: index of next character to read
  * @log_end: index of next character to write
@@ -1004,8 +1004,8 @@ struct batadv_nc_packet {
 };
 
 /**
- * batadv_skb_cb - control buffer structure used to store private data relevant
- *  to batman-adv in the skb->cb buffer in skbs.
+ * struct batadv_skb_cb - control buffer structure used to store private data
+ *  relevant to batman-adv in the skb->cb buffer in skbs.
  * @decoded: Marks a skb as decoded, which is checked when searching for coding
  *  opportunities in network-coding.c
  */
-- 
1.7.10.4

