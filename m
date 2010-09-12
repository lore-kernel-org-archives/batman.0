Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 12 Sep 2010 23:21:54 +0200
Message-Id: <1284326516-30540-4-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284326516-30540-1-git-send-email-sven.eckelmann@gmx.de>
References: <1284326516-30540-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/5] Staging: batman-adv: Add rcu TODO
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
Cc: b.a.t.m.a.n@lists.open-mesh.net

Paul E. McKenney informed us that rcu is misused by leaking pointers to
rcu related elements outside read-side protected critical sections.

He also recommended that it should be checked against the rcu checklist.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/TODO |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/batman-adv/TODO b/drivers/staging/batman-adv/TODO
index 1457c7f..3af8028 100644
--- a/drivers/staging/batman-adv/TODO
+++ b/drivers/staging/batman-adv/TODO
@@ -1,3 +1,8 @@
+ * Rework usage of RCU
+    - don't leak pointers from rcu out of rcu critical area which may
+      get freed
+    - check were synchronize_rcu must be used
+    - go through Documentation/RCU/checklist.txt
  * Request a new review
  * Process the comments from the review
  * Move into mainline proper
-- 
1.7.2.3

