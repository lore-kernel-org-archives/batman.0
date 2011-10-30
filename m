Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 30 Oct 2011 16:36:20 +0100
Message-Id: <1319988980-3548-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix style changes reported
	by cppcheck
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

cppcheck reported some style issues this patch fixes.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 bat_iv_ogm.c     |    2 +-
 routing.c        |    2 +-
 soft-interface.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 3512e25..17b6dfa 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -990,7 +990,6 @@ static void bat_ogm_process(const struct ethhdr *ethhdr,
 
 	if (is_my_orig) {
 		unsigned long *word;
-		int offset;
 
 		orig_neigh_node = get_orig_node(bat_priv, ethhdr->h_source);
 		if (!orig_neigh_node)
@@ -1002,6 +1001,7 @@ static void bat_ogm_process(const struct ethhdr *ethhdr,
 		if (has_directlink_flag &&
 		    compare_eth(if_incoming->net_dev->dev_addr,
 				batman_ogm_packet->orig)) {
+			int offset;
 			offset = if_incoming->if_num * NUM_WORDS;
 
 			spin_lock_bh(&orig_neigh_node->ogm_cnt_lock);
diff --git a/routing.c b/routing.c
index ef24a72..3e97c2c 100644
--- a/routing.c
+++ b/routing.c
@@ -977,7 +977,6 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	struct unicast_frag_packet *unicast_packet;
 	int hdr_size = sizeof(*unicast_packet);
 	struct sk_buff *new_skb = NULL;
-	int ret;
 
 	if (check_unicast_packet(skb, hdr_size) < 0)
 		return NET_RX_DROP;
@@ -989,6 +988,7 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 
 	/* packet for me */
 	if (is_my_mac(unicast_packet->dest)) {
+		int ret;
 
 		ret = frag_reassemble_skb(skb, bat_priv, &new_skb);
 
diff --git a/soft-interface.c b/soft-interface.c
index 45297c8..3ed6781 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -692,7 +692,6 @@ void interface_rx(struct net_device *soft_iface,
 	struct vlan_ethhdr *vhdr;
 	struct softif_neigh *curr_softif_neigh = NULL;
 	short vid = -1;
-	int ret;
 
 	/* check if enough space is available for pulling, and pull */
 	if (!pskb_may_pull(skb, hdr_size))
@@ -722,6 +721,7 @@ void interface_rx(struct net_device *soft_iface,
 	 */
 	curr_softif_neigh = softif_neigh_vid_get_selected(bat_priv, vid);
 	if (curr_softif_neigh) {
+		int ret;
 		skb_push(skb, hdr_size);
 		unicast_packet = (struct unicast_packet *)skb->data;
 
-- 
1.7.7.1

