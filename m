Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 19 Oct 2010 11:59:11 +0200
Message-Id: <1287482355-16319-4-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1287482355-16319-1-git-send-email-sven.eckelmann@gmx.de>
References: <1287482355-16319-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 3/7] Staging: batman-adv: Fix resizing of
	broadcast seqno buffers on if deletion
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

From: Linus Lüssing <linus.luessing@web.de>

Not only the entries of the deleted interface got erased, but also all
ones with a lower if_num. This commit fixes this issue by setting the
destination appropriately.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/originator.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index c530df1..865211d 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -456,7 +456,7 @@ static int orig_node_del_if(struct orig_node *orig_node,
 	memcpy(data_ptr, orig_node->bcast_own, del_if_num * chunk_size);
 
 	/* copy second part */
-	memcpy(data_ptr,
+	memcpy(data_ptr + del_if_num * chunk_size,
 	       orig_node->bcast_own + ((del_if_num + 1) * chunk_size),
 	       (max_if_num - del_if_num) * chunk_size);
 
@@ -476,7 +476,7 @@ free_bcast_own:
 	memcpy(data_ptr, orig_node->bcast_own_sum,
 	       del_if_num * sizeof(uint8_t));
 
-	memcpy(data_ptr,
+	memcpy(data_ptr + del_if_num * sizeof(uint8_t),
 	       orig_node->bcast_own_sum + ((del_if_num + 1) * sizeof(uint8_t)),
 	       (max_if_num - del_if_num) * sizeof(uint8_t));
 
-- 
1.7.2.3

