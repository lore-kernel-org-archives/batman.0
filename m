Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 10 May 2012 12:54:04 +0800
Message-Id: <1336625644-29442-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1336625644-29442-1-git-send-email-lindner_marek@yahoo.de>
References: <1336625644-29442-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: change comment style for
	David
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Should be merged with f76d019194e0a88c57371df169ecc979690a04c2

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_iv_ogm.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 96ce556..837c8a6 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -518,13 +518,12 @@ static void bat_iv_ogm_forward(struct orig_node *orig_node,
 	}
 
 	if (!is_from_best_next_hop) {
-		/**
-		* Mark the forwarded packet when it is not coming from our best
-		* next hop. We still need to forward the packet for our neighbor
-		* link quality detection to work in case the packet originated
-		* from a single hop neighbor. Otherwise we can simply drop the
-		* ogm.
-		*/
+		/* Mark the forwarded packet when it is not coming from our best
+		 * next hop. We still need to forward the packet for our neighbor
+		 * link quality detection to work in case the packet originated
+		 * from a single hop neighbor. Otherwise we can simply drop the
+		 * ogm.
+		 */
 		if (is_single_hop_neigh)
 			batman_ogm_packet->flags |= NOT_BEST_NEXT_HOP;
 		else
-- 
1.7.9.1

