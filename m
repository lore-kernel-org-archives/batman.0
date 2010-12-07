Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Tue,  7 Dec 2010 23:32:16 +0100
Message-Id: <1291761150-29818-6-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <20101207221351.GA19474@Sellars>
References: <20101207221351.GA19474@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 06/20] batman-adv: Buffer other originator's
	received MCA entries
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>

We need to memorize the MCA information attached to the OGMs to be able
to prepare the tracker packets with them later.

Signed-off-by: Linus Lüssing <linus.luessing@saxnet.de>
---
 originator.c |    7 ++++++-
 routing.c    |   40 +++++++++++++++++++++++++++++++++++++---
 routing.h    |    2 +-
 types.h      |    2 ++
 4 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/originator.c b/originator.c
index 89ec021..900d5fc 100644
--- a/originator.c
+++ b/originator.c
@@ -101,6 +101,8 @@ static void free_orig_node(void *data, void *arg)
 	frag_list_free(&orig_node->frag_list);
 	hna_global_del_orig(bat_priv, orig_node, "originator timed out");
 
+	kfree(orig_node->mca_buff);
+
 	kfree(orig_node->bcast_own);
 	kfree(orig_node->bcast_own_sum);
 	kfree(orig_node);
@@ -147,6 +149,8 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	memcpy(orig_node->orig, addr, ETH_ALEN);
 	orig_node->router = NULL;
 	orig_node->hna_buff = NULL;
+	orig_node->mca_buff = NULL;
+	orig_node->num_mca = 0;
 	orig_node->bcast_seqno_reset = jiffies - 1
 					- msecs_to_jiffies(RESET_PROTECTION_MS);
 	orig_node->batman_seqno_reset = jiffies - 1
@@ -256,7 +260,8 @@ static bool purge_orig_node(struct bat_priv *bat_priv,
 			update_routes(bat_priv, orig_node,
 				      best_neigh_node,
 				      orig_node->hna_buff,
-				      orig_node->hna_buff_len);
+				      orig_node->hna_buff_len,
+				      orig_node->mca_buff, orig_node->num_mca);
 			/* update bonding candidates, we could have lost
 			 * some candidates. */
 			update_bonding_candidates(bat_priv, orig_node);
diff --git a/routing.c b/routing.c
index d8b0c5a..cf145b7 100644
--- a/routing.c
+++ b/routing.c
@@ -77,6 +77,34 @@ static void update_HNA(struct bat_priv *bat_priv, struct orig_node *orig_node,
 	}
 }
 
+/* Copy the mca buffer again if something has changed */
+static void update_MCA(struct orig_node *orig_node,
+		       unsigned char *mca_buff, int num_mca)
+{
+	/* numbers differ? then reallocate buffer */
+	if (num_mca != orig_node->num_mca) {
+		kfree(orig_node->mca_buff);
+		if (num_mca > 0) {
+			orig_node->mca_buff =
+				kmalloc(num_mca * ETH_ALEN, GFP_ATOMIC);
+			if (orig_node->mca_buff)
+				goto update;
+		}
+		orig_node->mca_buff = NULL;
+		orig_node->num_mca = 0;
+	/* size ok, just update? */
+	} else if (num_mca > 0 &&
+		 memcmp(orig_node->mca_buff, mca_buff, num_mca * ETH_ALEN))
+		goto update;
+
+	/* it's the same, leave it like that */
+	return;
+
+update:
+	memcpy(orig_node->mca_buff, mca_buff, num_mca * ETH_ALEN);
+	orig_node->num_mca = num_mca;
+}
+
 static void update_route(struct bat_priv *bat_priv,
 			 struct orig_node *orig_node,
 			 struct neigh_node *neigh_node,
@@ -114,7 +142,7 @@ static void update_route(struct bat_priv *bat_priv,
 
 void update_routes(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		   struct neigh_node *neigh_node, unsigned char *hna_buff,
-		   int hna_buff_len)
+		   int hna_buff_len, unsigned char *mca_buff, int num_mca)
 {
 
 	if (orig_node == NULL)
@@ -126,6 +154,8 @@ void update_routes(struct bat_priv *bat_priv, struct orig_node *orig_node,
 	/* may be just HNA changed */
 	else
 		update_HNA(bat_priv, orig_node, hna_buff, hna_buff_len);
+
+	update_MCA(orig_node, mca_buff, num_mca);
 }
 
 static int is_bidirectional_neigh(struct orig_node *orig_node,
@@ -247,6 +277,7 @@ static void update_orig(struct bat_priv *bat_priv,
 {
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	int tmp_hna_buff_len;
+	unsigned char *mca_buff;
 
 	bat_dbg(DBG_BATMAN, bat_priv, "update_originator(): "
 		"Searching and updating originator entry of received packet\n");
@@ -297,6 +328,7 @@ static void update_orig(struct bat_priv *bat_priv,
 
 	tmp_hna_buff_len = (hna_buff_len > batman_packet->num_hna * ETH_ALEN ?
 			    batman_packet->num_hna * ETH_ALEN : hna_buff_len);
+	mca_buff = (char *)batman_packet + BAT_PACKET_LEN + tmp_hna_buff_len;
 
 	/* if this neighbor already is our next hop there is nothing
 	 * to change */
@@ -317,12 +349,14 @@ static void update_orig(struct bat_priv *bat_priv,
 		goto update_hna;
 
 	update_routes(bat_priv, orig_node, neigh_node,
-		      hna_buff, tmp_hna_buff_len);
+		      hna_buff, tmp_hna_buff_len, mca_buff,
+		      batman_packet->num_mca);
 	goto update_gw;
 
 update_hna:
 	update_routes(bat_priv, orig_node, orig_node->router,
-		      hna_buff, tmp_hna_buff_len);
+		      hna_buff, tmp_hna_buff_len, mca_buff,
+		      batman_packet->num_mca);
 
 update_gw:
 	if (orig_node->gw_flags != batman_packet->gw_flags)
diff --git a/routing.h b/routing.h
index f108f23..d44b540 100644
--- a/routing.h
+++ b/routing.h
@@ -31,7 +31,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 				struct batman_if *if_incoming);
 void update_routes(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		   struct neigh_node *neigh_node, unsigned char *hna_buff,
-		   int hna_buff_len);
+		   int hna_buff_len, unsigned char *mca_buff, int num_mca);
 int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 			 int hdr_size);
 int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if);
diff --git a/types.h b/types.h
index 41eabfe..0129b1f 100644
--- a/types.h
+++ b/types.h
@@ -79,6 +79,8 @@ struct orig_node {
 	uint8_t flags;
 	unsigned char *hna_buff;
 	int16_t hna_buff_len;
+	unsigned char *mca_buff;
+	uint8_t num_mca;
 	uint32_t last_real_seqno;
 	uint8_t last_ttl;
 	TYPE_OF_WORD bcast_bits[NUM_WORDS];
-- 
1.7.1

