Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat,  2 Jan 2010 11:30:47 +0100
Message-Id: <1262428252-26439-12-git-send-email-andrew@lunn.ch>
In-Reply-To: <1262428252-26439-11-git-send-email-andrew@lunn.ch>
References: <1262428252-26439-1-git-send-email-andrew@lunn.ch>
	<1262428252-26439-2-git-send-email-andrew@lunn.ch>
	<1262428252-26439-3-git-send-email-andrew@lunn.ch>
	<1262428252-26439-4-git-send-email-andrew@lunn.ch>
	<1262428252-26439-5-git-send-email-andrew@lunn.ch>
	<1262428252-26439-6-git-send-email-andrew@lunn.ch>
	<1262428252-26439-7-git-send-email-andrew@lunn.ch>
	<1262428252-26439-8-git-send-email-andrew@lunn.ch>
	<1262428252-26439-9-git-send-email-andrew@lunn.ch>
	<1262428252-26439-10-git-send-email-andrew@lunn.ch>
	<1262428252-26439-11-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 12/17] Staging: batman-adv: check all
	kmalloc()s
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: gregkh@suse.de
Cc: b.a.t.m.a.n@lists.open-mesh.net, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

From: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

there are some kmallocs left which are not checked whether they succeeds or
not, which might lead to corrupted data structures if the system memory is
full. This patch should clean up the remaining unchecked kmalloc()s.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/originator.c        |   22 ++++++++++++++++++-
 drivers/staging/batman-adv/routing.c           |   27 +++++++++++++++++++----
 drivers/staging/batman-adv/translation-table.c |   18 ++++++++-------
 3 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index f2b295b..849e480 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -77,6 +77,9 @@ create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 	bat_dbg(DBG_BATMAN, "Creating new last-hop neighbor of originator\n");
 
 	neigh_node = kmalloc(sizeof(struct neigh_node), GFP_ATOMIC);
+	if (!neigh_node)
+		return NULL;
+
 	memset(neigh_node, 0, sizeof(struct neigh_node));
 	INIT_LIST_HEAD(&neigh_node->list);
 
@@ -127,6 +130,9 @@ struct orig_node *get_orig_node(uint8_t *addr)
 	bat_dbg(DBG_BATMAN, "Creating new originator: %s \n", orig_str);
 
 	orig_node = kmalloc(sizeof(struct orig_node), GFP_ATOMIC);
+	if (!orig_node)
+		return NULL;
+
 	memset(orig_node, 0, sizeof(struct orig_node));
 	INIT_LIST_HEAD(&orig_node->neigh_list);
 
@@ -138,13 +144,20 @@ struct orig_node *get_orig_node(uint8_t *addr)
 	size = num_ifs * sizeof(TYPE_OF_WORD) * NUM_WORDS;
 
 	orig_node->bcast_own = kmalloc(size, GFP_ATOMIC);
+	if (!orig_node->bcast_own)
+		goto free_orig_node;
+
 	memset(orig_node->bcast_own, 0, size);
 
 	size = num_ifs * sizeof(uint8_t);
 	orig_node->bcast_own_sum = kmalloc(size, GFP_ATOMIC);
+	if (!orig_node->bcast_own_sum)
+		goto free_bcast_own;
+
 	memset(orig_node->bcast_own_sum, 0, size);
 
-	hash_add(orig_hash, orig_node);
+	if (hash_add(orig_hash, orig_node) < 0)
+		goto free_bcast_own_sum;
 
 	if (orig_hash->elements * 4 > orig_hash->size) {
 		swaphash = hash_resize(orig_hash, orig_hash->size * 2);
@@ -157,6 +170,13 @@ struct orig_node *get_orig_node(uint8_t *addr)
 	}
 
 	return orig_node;
+free_bcast_own_sum:
+	kfree(orig_node->bcast_own_sum);
+free_bcast_own:
+	kfree(orig_node->bcast_own);
+free_orig_node:
+	kfree(orig_node);
+	return NULL;
 }
 
 static bool purge_orig_neighbors(struct orig_node *orig_node,
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index adde460..25a1424 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -154,11 +154,14 @@ static int isBidirectionalNeigh(struct orig_node *orig_node,
 				neigh_node = tmp_neigh_node;
 		}
 
-		if (neigh_node == NULL)
+		if (!neigh_node)
 			neigh_node = create_neighbor(orig_node,
 						     orig_neigh_node,
 						     orig_neigh_node->orig,
 						     if_incoming);
+		/* create_neighbor failed, return 0 */
+		if (!neigh_node)
+			return 0;
 
 		neigh_node->last_valid = jiffies;
 	} else {
@@ -172,11 +175,14 @@ static int isBidirectionalNeigh(struct orig_node *orig_node,
 				neigh_node = tmp_neigh_node;
 		}
 
-		if (neigh_node == NULL)
+		if (!neigh_node)
 			neigh_node = create_neighbor(orig_neigh_node,
 						     orig_neigh_node,
 						     orig_neigh_node->orig,
 						     if_incoming);
+		/* create_neighbor failed, return 0 */
+		if (!neigh_node)
+			return 0;
 	}
 
 	orig_node->last_valid = jiffies;
@@ -260,11 +266,19 @@ static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr,
 			ring_buffer_avg(tmp_neigh_node->tq_recv);
 	}
 
-	if (neigh_node == NULL)
+	if (!neigh_node) {
+		struct orig_node *orig_tmp;
+
+		orig_tmp = get_orig_node(ethhdr->h_source);
+		if (!orig_tmp)
+			return;
+
 		neigh_node = create_neighbor(orig_node,
-					     get_orig_node(ethhdr->h_source),
+					     orig_tmp,
 					     ethhdr->h_source, if_incoming);
-	else
+		if (!neigh_node)
+			return;
+	} else
 		bat_dbg(DBG_BATMAN,
 			"Updating existing last-hop neighbor of originator\n");
 
@@ -444,6 +458,9 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 
 		orig_neigh_node = get_orig_node(ethhdr->h_source);
 
+		if (!orig_neigh_node)
+			return;
+
 		/* neighbor has to indicate direct link and it has to
 		 * come via the corresponding interface */
 		/* if received seqno equals last send seqno save new
diff --git a/drivers/staging/batman-adv/translation-table.c b/drivers/staging/batman-adv/translation-table.c
index 088715b..8c8136b 100644
--- a/drivers/staging/batman-adv/translation-table.c
+++ b/drivers/staging/batman-adv/translation-table.c
@@ -317,14 +317,16 @@ void hna_global_add_orig(struct orig_node *orig_node,
 		hna_buff_count++;
 	}
 
-	orig_node->hna_buff_len = hna_buff_len;
-
-	if (orig_node->hna_buff_len > 0) {
-		orig_node->hna_buff = kmalloc(orig_node->hna_buff_len,
-					      GFP_ATOMIC);
-		memcpy(orig_node->hna_buff, hna_buff, orig_node->hna_buff_len);
-	} else {
-		orig_node->hna_buff = NULL;
+	/* initialize, and overwrite if malloc succeeds */
+	orig_node->hna_buff = NULL;
+	orig_node->hna_buff_len = 0;
+
+	if (hna_buff_len > 0) {
+		orig_node->hna_buff = kmalloc(hna_buff_len, GFP_ATOMIC);
+		if (orig_node->hna_buff) {
+			memcpy(orig_node->hna_buff, hna_buff, hna_buff_len);
+			orig_node->hna_buff_len = hna_buff_len;
+		}
 	}
 
 	spin_lock_irqsave(&hna_global_hash_lock, flags);
-- 
1.6.5.7

