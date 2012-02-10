Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 10 Feb 2012 12:21:55 +0100
Message-Id: <1328872915-31086-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix daily check regression in
	blaII
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

9fd6b0615b5499b270d39a92b8790e206cf75833 introduced some regressions in the
daily checks on open-mesh.org. Those were only visible when
CONFIG_BATMAN_ADV_BLA was disabled. The reason was the usage of defines to
replace the calls for not available functions. The actual c compiler is not
able to distinguish between the used and unused variables because it doesn't
see the function call anymore. The second problem was the use of simple
subscopes where "do {} while(0)" whould have been necessary.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bridge_loop_avoidance.h |    5 +++--
 soft-interface.c        |    4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/bridge_loop_avoidance.h b/bridge_loop_avoidance.h
index 24d7f16..2758b8c 100644
--- a/bridge_loop_avoidance.h
+++ b/bridge_loop_avoidance.h
@@ -46,9 +46,10 @@ void bla_free(struct bat_priv *bat_priv);
 #define bla_claim_table_seq_print_text		(0)
 #define bla_is_backbone_gw_orig(...)		(0)
 #define bla_check_bcast_duplist(...)		(0)
-#define bla_update_orig_address(...)		{}
+#define bla_update_orig_address(...)		do {} while (0)
 #define bla_init(...)				(1)
-#define bla_free(...)				{}
+#define bla_free(...)				do {} while (0)
+
 
 #endif /* ifdef CONFIG_BATMAN_ADV_BLA */
 
diff --git a/soft-interface.c b/soft-interface.c
index 8de8779..579f509 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -132,7 +132,7 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	uint8_t stp_addr[ETH_ALEN] = {0x01, 0x80, 0xC2, 0x00, 0x00, 0x00};
 	unsigned int header_len = 0;
 	int data_len = skb->len, ret;
-	short vid = -1;
+	short vid __maybe_unused = -1;
 	bool do_bcast = false;
 
 	if (atomic_read(&bat_priv->mesh_state) != MESH_ACTIVE)
@@ -253,7 +253,7 @@ void interface_rx(struct net_device *soft_iface,
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	struct ethhdr *ethhdr;
 	struct vlan_ethhdr *vhdr;
-	short vid = -1;
+	short vid __maybe_unused = -1;
 
 	/* check if enough space is available for pulling, and pull */
 	if (!pskb_may_pull(skb, hdr_size))
-- 
1.7.9

