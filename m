Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 21 Jul 2010 00:25:22 +0200
Message-Id: <1279664722-27500-4-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1279664722-27500-1-git-send-email-sven.eckelmann@gmx.de>
References: <1279664722-27500-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] Staging: batman-adv: Update TODO with
	new points from review
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

David S. Miller provided some new ideas and found problems in his review
20100719.212625.255369607.davem@davemloft.net. These issues must be
resolved before it can be merged into net.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/TODO |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/batman-adv/TODO b/drivers/staging/batman-adv/TODO
index 518db7f..9c5aea2 100644
--- a/drivers/staging/batman-adv/TODO
+++ b/drivers/staging/batman-adv/TODO
@@ -1,6 +1,9 @@
-Request a review.
-Process the comments from the review.
-Move into mainline proper.
+ * Use hweight* for hamming weight calculation
+ * Save/cache packets direktly as skb instead of using a normal memory region
+   and copying it in a skb using send_raw_packet and similar functions
+ * Request a new review
+ * Process the comments from the review
+ * Move into mainline proper
 
 Please send all patches to:
 	Marek Lindner <lindner_marek@yahoo.de>
-- 
1.7.1

