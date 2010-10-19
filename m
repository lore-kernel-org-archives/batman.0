Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 19 Oct 2010 11:59:09 +0200
Message-Id: <1287482355-16319-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1287482355-16319-1-git-send-email-sven.eckelmann@gmx.de>
References: <1287482355-16319-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/7] Staging: batman-adv: Add hash
	recommendations to TODO
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

David Miller <davem@davemloft.net> recommended in
20100924.134334.28812338.davem@davemloft.net that we must make the hash
abstraction helper more efficient and may remove it completely.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/TODO |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/batman-adv/TODO b/drivers/staging/batman-adv/TODO
index 5913731..11c384f 100644
--- a/drivers/staging/batman-adv/TODO
+++ b/drivers/staging/batman-adv/TODO
@@ -1,3 +1,7 @@
+ * remove own list functionality from hash
+ * use hlist_head, hlist_node in hash
+ * don't use callbacks for compare+choose in hash
+ * think about more efficient ways instead of abstraction of hash
  * Request a new review
  * Process the comments from the review
  * Move into mainline proper
-- 
1.7.2.3

