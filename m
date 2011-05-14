Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 14 May 2011 23:14:49 +0200
Message-Id: <1305407694-16789-4-git-send-email-sven@narfation.org>
In-Reply-To: <1305407694-16789-1-git-send-email-sven@narfation.org>
References: <1305407694-16789-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/9] batman-adv: Don't do pointer arithmetic
	with void*
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

The size of void is currently set by gcc to 1, but is not well defined
in general. Therefore it is more advisable to cast it to char* before
doing pointer arithmetic.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 originator.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/originator.c b/originator.c
index 080ec88..9843b68 100644
--- a/originator.c
+++ b/originator.c
@@ -567,7 +567,7 @@ static int orig_node_del_if(struct orig_node *orig_node,
 	memcpy(data_ptr, orig_node->bcast_own, del_if_num * chunk_size);
 
 	/* copy second part */
-	memcpy(data_ptr + del_if_num * chunk_size,
+	memcpy((char *)data_ptr + del_if_num * chunk_size,
 	       orig_node->bcast_own + ((del_if_num + 1) * chunk_size),
 	       (max_if_num - del_if_num) * chunk_size);
 
@@ -587,7 +587,7 @@ free_bcast_own:
 	memcpy(data_ptr, orig_node->bcast_own_sum,
 	       del_if_num * sizeof(uint8_t));
 
-	memcpy(data_ptr + del_if_num * sizeof(uint8_t),
+	memcpy((char *)data_ptr + del_if_num * sizeof(uint8_t),
 	       orig_node->bcast_own_sum + ((del_if_num + 1) * sizeof(uint8_t)),
 	       (max_if_num - del_if_num) * sizeof(uint8_t));
 
-- 
1.7.5.1

