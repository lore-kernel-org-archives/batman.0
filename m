Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 16 Nov 2013 23:02:51 +0100
Message-Id: <1384639371-630-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: remove returns at the end of
	void functions
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Return at the end of void functions is not needed.

Since most of the void functions in the code do not do so,
make all the others consistent by removing the useless
returns. Actually all the functions to be "fixed" are in
network-coding.h only.

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 network-coding.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/network-coding.h b/network-coding.h
index 6b1a5d7..b16639f 100644
--- a/network-coding.h
+++ b/network-coding.h
@@ -59,7 +59,6 @@ static inline int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
 
 static inline void batadv_nc_mesh_free(struct batadv_priv *bat_priv)
 {
-	return;
 }
 
 static inline void
@@ -69,7 +68,6 @@ batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
 			 struct batadv_ogm_packet *ogm_packet,
 			 int is_single_hop_neigh)
 {
-	return;
 }
 
 static inline void
@@ -78,17 +76,14 @@ batadv_nc_purge_orig(struct batadv_priv *bat_priv,
 		     bool (*to_purge)(struct batadv_priv *,
 				      struct batadv_nc_node *))
 {
-	return;
 }
 
 static inline void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv)
 {
-	return;
 }
 
 static inline void batadv_nc_init_orig(struct batadv_orig_node *orig_node)
 {
-	return;
 }
 
 static inline bool batadv_nc_skb_forward(struct sk_buff *skb,
@@ -101,14 +96,12 @@ static inline void
 batadv_nc_skb_store_for_decoding(struct batadv_priv *bat_priv,
 				 struct sk_buff *skb)
 {
-	return;
 }
 
 static inline void
 batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
 				    struct sk_buff *skb)
 {
-	return;
 }
 
 static inline int batadv_nc_nodes_seq_print_text(struct seq_file *seq,
-- 
1.8.4.3

