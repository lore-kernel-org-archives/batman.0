Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 16 Jan 2011 11:27:52 +0100
Message-Id: <1295173672-16895-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1295103173-7036-1-git-send-email-lindner_marek@yahoo.de>
References: <1295103173-7036-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: free neighbors when an interface
	is deactivated
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

hardif_disable_interface() calls purge_orig_ref() to immediately free
all neighbors associated with the interface that is going down.
purge_orig_neighbors() checked if the interface status is IF_INACTIVE
which is set to IF_NOT_IN_USE shortly before calling purge_orig_ref().

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---

Note: The previous patch created a new problem when cleaning up pending
OGMs, therefore this different approach.

 batman-adv/originator.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index c043bf8..1840f3a 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
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

