Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Thu,  7 Jan 2016 15:26:27 +0800
Message-Id: <1452151587-25547-2-git-send-email-a@unstable.cc>
In-Reply-To: <1452151587-25547-1-git-send-email-a@unstable.cc>
References: <1452151587-25547-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix invalid read while copying
	bat_iv.bcast_own
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

batadv_iv_ogm_orig_del_if removes a part of the bcast_own which previously
belonged to the now removed interface. This is done by copying all data
which comes before the removed interface and then appending all the data
which comes after the removed interface.

The address calculation for the position of the data which comes after the
removed interface assumed that the bat_iv.bcast_own is a pointer to a
single byte datatype. But it is a pointer to unsigned long and thus the
calculated position was wrong off factor sizeof(unsigned long).

Fixes: 83a8342678a0 ("more basic routing code added (forwarding packets /
bitarray added)")

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/bat_iv_ogm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 912d9c3..aa94b4e 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -185,7 +185,8 @@ unlock:
 static int batadv_iv_ogm_orig_del_if(struct batadv_orig_node *orig_node,
 				     int max_if_num, int del_if_num)
 {
-	int chunk_size,  ret = -ENOMEM, if_offset;
+	int ret = -ENOMEM;
+	size_t chunk_size, if_offset;
 	void *data_ptr = NULL;
 
 	spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
@@ -203,8 +204,9 @@ static int batadv_iv_ogm_orig_del_if(struct batadv_orig_node *orig_node,
 	memcpy(data_ptr, orig_node->bat_iv.bcast_own, del_if_num * chunk_size);
 
 	/* copy second part */
+	if_offset = (del_if_num + 1) * chunk_size;
 	memcpy((char *)data_ptr + del_if_num * chunk_size,
-	       orig_node->bat_iv.bcast_own + ((del_if_num + 1) * chunk_size),
+	       (uint8_t *)orig_node->bat_iv.bcast_own + if_offset,
 	       (max_if_num - del_if_num) * chunk_size);
 
 free_bcast_own:
-- 
2.7.0

