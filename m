Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat,  7 Apr 2012 23:06:09 +0200
Message-Id: <1333832769-28493-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1333832769-28493-1-git-send-email-ordex@autistici.org>
References: <1333832769-28493-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: use static inline functions
	to fake not compiled-in routines
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

In case of not compiled-in components, we need to fake some functions in order
to let the rest of the code correctly build. But instead of using something
like:

We have to use:

static inline bla_init(struct bat_priv *bat_priv)
{
	return 1;
}

In this way the compiler can correctly check the type and the number of the
arguments passed to the function, even if the related component (bla in this
case) is not compiled.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 bridge_loop_avoidance.h |   60 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 9 deletions(-)

diff --git a/bridge_loop_avoidance.h b/bridge_loop_avoidance.h
index e1a2966..e39f93a 100644
--- a/bridge_loop_avoidance.h
+++ b/bridge_loop_avoidance.h
@@ -40,16 +40,58 @@ void bla_free(struct bat_priv *bat_priv);
 #define BLA_CRC_INIT	0
 #else /* ifdef CONFIG_BATMAN_ADV_BLA */
 
-#define bla_rx(...)				(0)
-#define bla_tx(...)				(0)
-#define bla_is_backbone_gw(...)			(0)
-#define bla_claim_table_seq_print_text		(0)
-#define bla_is_backbone_gw_orig(...)		(0)
-#define bla_check_bcast_duplist(...)		(0)
-#define bla_update_orig_address(...)		do {} while (0)
-#define bla_init(...)				(1)
-#define bla_free(...)				do {} while (0)
+static inline int bla_rx(struct bat_priv *bat_priv, struct sk_buff *skb,
+			 short vid)
+{
+	return 0;
+}
 
+static inline int bla_tx(struct bat_priv *bat_priv, struct sk_buff *skb,
+			 short vid)
+{
+	return 0;
+}
+
+static inline int bla_is_backbone_gw(struct sk_buff *skb,
+				     struct orig_node *orig_node,
+				     int hdr_size)
+{
+	return 0;
+}
+
+static inline int bla_claim_table_seq_print_text(struct seq_file *seq,
+						 void *offset)
+{
+	return 0;
+}
+
+static inline int bla_is_backbone_gw_orig(struct bat_priv *bat_priv,
+					  uint8_t *orig)
+{
+	return 0;
+}
+
+static inline int bla_check_bcast_duplist(struct bat_priv *bat_priv,
+					  struct bcast_packet *bcast_packet,
+					  int hdr_size)
+{
+	return 0;
+}
+
+static inline void bla_update_orig_address(struct bat_priv *bat_priv,
+					   struct hard_iface *primary_if,
+					   struct hard_iface *oldif)
+{
+}
+
+static inline int bla_init(struct bat_priv *bat_priv)
+{
+	return 1;
+}
+
+static inline void bla_free(struct bat_priv *bat_priv)
+{
+}
 
 #endif /* ifdef CONFIG_BATMAN_ADV_BLA */
 
-- 
1.7.9.4

