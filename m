Return-Path: <daniele.furlan@gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Date: Thu, 17 Nov 2011 16:53:50 +0100
Message-Id: <1321545233-32676-2-git-send-email-daniele.furlan@gmail.com>
In-Reply-To: <1321545233-32676-1-git-send-email-daniele.furlan@gmail.com>
References: <1321545233-32676-1-git-send-email-daniele.furlan@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH 2/5] Introduce sequence number recording of
	ogm received from neighbours.
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

 The introduction of sequence number recording of ogm received from neighbours allows
 to introduce a control on ogm seqence number gap to identify broken paths
 substituing the method based on global window.

Signed-off-by: Daniele Furlan <daniele.furlan@gmail.com>
---
 bat_iv_ogm.c |    5 +++++
 types.h      |    2 ++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index d39938c..bdb4f1a 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -865,6 +865,11 @@ static int bat_ogm_update_seqnos(const struct ethhdr *ethhdr,
 		else
 			set_mark = 0;
 
+		/* update last originator seqno received from this neighbour */
+		if ((set_mark) && 
+			(batman_ogm_packet->seqno > tmp_neigh_node->last_seqno))
+			tmp_neigh_node->last_seqno = batman_ogm_packet->seqno;
+
 		/* if the window moved, set the update flag. */
 		need_update |= bit_get_packet(bat_priv,
 					      tmp_neigh_node->real_bits,
diff --git a/types.h b/types.h
index 84b9c59..910ce85 100644
--- a/types.h
+++ b/types.h
@@ -120,6 +120,7 @@ struct gw_node {
 /**
  *	neigh_node
  *	@last_valid: when last packet via this neighbor was received
+ *	@last_seqno: last originator seqno received via this neighbor
  */
 struct neigh_node {
 	struct hlist_node list;
@@ -128,6 +129,7 @@ struct neigh_node {
 	uint8_t tq_recv[TQ_GLOBAL_WINDOW_SIZE];
 	uint8_t tq_index;
 	uint8_t tq;
+	uint32_t last_seqno;
 	uint8_t last_ttl;
 	struct list_head bonding_list;
 	unsigned long last_valid;
-- 
1.7.1

