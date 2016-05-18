Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Wed, 18 May 2016 13:04:48 +0800
Message-Id: <1463547892-11290-5-git-send-email-a@unstable.cc>
In-Reply-To: <1463547892-11290-1-git-send-email-a@unstable.cc>
References: <1463547892-11290-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 4/8] batman-adv: Fix unexpected free of
	bcast_own on add_if error
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

The function batadv_iv_ogm_orig_add_if allocates new buffers for bcast_own
and bcast_own_sum. It is expected that these buffers are unchanged in case
either bcast_own or bcast_own_sum couldn't be resized.

But the error handling of this function frees the already resized buffer
for bcast_own when the allocation of the new bcast_own_sum buffer failed.
This will lead to an invalid memory access when some code will try to
access bcast_own.

Instead the resized new bcast_own buffer has to be kept. This will not lead
to problems because the size of the buffer was only increased and therefore
no user of the buffer will try to access bytes outside of the new buffer.

Fixes: d0015fdd3d2c ("batman-adv: provide orig_node routing API")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/bat_iv_ogm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 7f98a9d39883..1b5bbafc0fa3 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -157,10 +157,8 @@ static int batadv_iv_ogm_orig_add_if(struct batadv_orig_node *orig_node,
 	orig_node->bat_iv.bcast_own = data_ptr;
 
 	data_ptr = kmalloc_array(max_if_num, sizeof(u8), GFP_ATOMIC);
-	if (!data_ptr) {
-		kfree(orig_node->bat_iv.bcast_own);
+	if (!data_ptr)
 		goto unlock;
-	}
 
 	memcpy(data_ptr, orig_node->bat_iv.bcast_own_sum,
 	       (max_if_num - 1) * sizeof(u8));
-- 
2.8.2

