Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 29 May 2013 02:59:29 +0200
Message-Id: <1369789186-3600-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1369789186-3600-1-git-send-email-ordex@autistici.org>
References: <1369789186-3600-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 04/21] batman-adv: drop useless argument
	seqno in neighbor creation
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

the sequence number is not stored in struct neigh_node,
therefore there is no need to pass such value to the
neigh_node creation procedure.

At the moment the value is only used by a debug message, but
given the fact that the seqno is not related to the neighbor
object, it is better to print it elsewhere.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/bat_iv_ogm.c | 11 ++++-------
 net/batman-adv/originator.c |  5 ++---
 net/batman-adv/originator.h |  2 +-
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 071f288..da239c5 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -33,12 +33,11 @@ static struct batadv_neigh_node *
 batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 			const uint8_t *neigh_addr,
 			struct batadv_orig_node *orig_node,
-			struct batadv_orig_node *orig_neigh, __be32 seqno)
+			struct batadv_orig_node *orig_neigh)
 {
 	struct batadv_neigh_node *neigh_node;
 
-	neigh_node = batadv_neigh_node_new(hard_iface, neigh_addr,
-					   ntohl(seqno));
+	neigh_node = batadv_neigh_node_new(hard_iface, neigh_addr);
 	if (!neigh_node)
 		goto out;
 
@@ -696,8 +695,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 
 		neigh_node = batadv_iv_ogm_neigh_new(if_incoming,
 						     ethhdr->h_source,
-						     orig_node, orig_tmp,
-						     batadv_ogm_packet->seqno);
+						     orig_node, orig_tmp);
 
 		batadv_orig_node_free_ref(orig_tmp);
 		if (!neigh_node)
@@ -829,8 +827,7 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 		neigh_node = batadv_iv_ogm_neigh_new(if_incoming,
 						     orig_neigh_node->orig,
 						     orig_neigh_node,
-						     orig_neigh_node,
-						     batadv_ogm_packet->seqno);
+						     orig_neigh_node);
 
 	if (!neigh_node)
 		goto out;
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index fad1a20..ddf5634 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -92,7 +92,7 @@ batadv_orig_node_get_router(struct batadv_orig_node *orig_node)
 
 struct batadv_neigh_node *
 batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
-		      const uint8_t *neigh_addr, uint32_t seqno)
+		      const uint8_t *neigh_addr)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct batadv_neigh_node *neigh_node;
@@ -110,8 +110,7 @@ batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
 	atomic_set(&neigh_node->refcount, 2);
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-		   "Creating new neighbor %pM, initial seqno %d\n",
-		   neigh_addr, seqno);
+		   "Creating new neighbor %pM\n", neigh_addr);
 
 out:
 	return neigh_node;
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 734e5a3..7887b84 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -31,7 +31,7 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 					      const uint8_t *addr);
 struct batadv_neigh_node *
 batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
-		      const uint8_t *neigh_addr, uint32_t seqno);
+		      const uint8_t *neigh_addr);
 void batadv_neigh_node_free_ref(struct batadv_neigh_node *neigh_node);
 struct batadv_neigh_node *
 batadv_orig_node_get_router(struct batadv_orig_node *orig_node);
-- 
1.8.1.5

