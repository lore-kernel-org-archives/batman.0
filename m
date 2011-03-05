Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  5 Mar 2011 13:28:19 +0100
Message-Id: <1299328122-21468-6-git-send-email-sven@narfation.org>
In-Reply-To: <1299328122-21468-1-git-send-email-sven@narfation.org>
References: <1299328122-21468-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 05/28] batman-adv: free neighbors when an
	interface is deactivated
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

hardif_disable_interface() calls purge_orig_ref() to immediately free
all neighbors associated with the interface that is going down.
purge_orig_neighbors() checked if the interface status is IF_INACTIVE
which is set to IF_NOT_IN_USE shortly before calling purge_orig_ref().

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/originator.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 6cb9af3..899d494 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -224,10 +224,15 @@ static bool purge_orig_neighbors(struct bat_priv *bat_priv,
 		if ((time_after(jiffies,
 			neigh_node->last_valid + PURGE_TIMEOUT * HZ)) ||
 		    (neigh_node->if_incoming->if_status == IF_INACTIVE) ||
+		    (neigh_node->if_incoming->if_status == IF_NOT_IN_USE) ||
 		    (neigh_node->if_incoming->if_status == IF_TO_BE_REMOVED)) {
 
-			if (neigh_node->if_incoming->if_status ==
-							IF_TO_BE_REMOVED)
+			if ((neigh_node->if_incoming->if_status ==
+								IF_INACTIVE) ||
+			    (neigh_node->if_incoming->if_status ==
+							IF_NOT_IN_USE) ||
+			    (neigh_node->if_incoming->if_status ==
+							IF_TO_BE_REMOVED))
 				bat_dbg(DBG_BATMAN, bat_priv,
 					"neighbor purge: originator %pM, "
 					"neighbor: %pM, iface: %s\n",
-- 
1.7.2.3

