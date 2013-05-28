Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Tue, 28 May 2013 08:23:22 +0200
Message-Id: <1369722202-19422-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix possible memleak in
	fragmentation
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

Use a variable for return value in batadv_frag_insert_packet() to free
the allocated struct batadv_frag_list_entry in all cases where it is not
inserted into a chain.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 fragmentation.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fragmentation.c b/fragmentation.c
index 6054ff6..ab85e75 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -129,10 +129,11 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 				      struct hlist_head *chain_out)
 {
 	struct batadv_frag_table_entry *chain;
-	struct batadv_frag_list_entry *frag_entry_new, *frag_entry_curr;
+	struct batadv_frag_list_entry *frag_entry_new = NULL, *frag_entry_curr;
 	struct batadv_frag_packet *frag_packet;
 	uint8_t bucket;
 	uint16_t seqno, hdr_size = sizeof(struct batadv_frag_packet);
+	bool ret = false;
 
 	/* Linearize packet to avoid linearizing 16 packets in a row when doing
 	 * the later merge. Non-linear merge should be added to remove this
@@ -162,6 +163,7 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 		hlist_add_head(&frag_entry_new->list, &chain->head);
 		chain->size = skb->len - hdr_size;
 		chain->timestamp = jiffies;
+		ret = true;
 		goto out;
 	}
 
@@ -177,6 +179,7 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 					 &frag_entry_curr->list);
 			chain->size += skb->len - hdr_size;
 			chain->timestamp = jiffies;
+			ret = true;
 			goto out;
 		}
 	}
@@ -186,6 +189,7 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 		hlist_add_after(&frag_entry_curr->list, &frag_entry_new->list);
 		chain->size += skb->len - hdr_size;
 		chain->timestamp = jiffies;
+		ret = true;
 	}
 
 out:
@@ -202,14 +206,14 @@ out:
 		chain->size = 0;
 	}
 
-	spin_unlock_bh(&chain->lock);
-	return true;
-
 err_unlock:
 	spin_unlock_bh(&chain->lock);
-	kfree(frag_entry_new);
+
 err:
-	return false;
+	if (!ret)
+		kfree(frag_entry_new);
+
+	return ret;
 }
 
 /**
-- 
1.8.3

