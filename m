Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 15 Jan 2011 15:52:53 +0100
Message-Id: <1295103173-7036-1-git-send-email-lindner_marek@yahoo.de>
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
 batman-adv/hard-interface.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 4f95777..52b2b72 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -398,7 +398,6 @@ void hardif_disable_interface(struct batman_if *batman_if)
 
 	kfree(batman_if->packet_buff);
 	batman_if->packet_buff = NULL;
-	batman_if->if_status = IF_NOT_IN_USE;
 
 	/* delete all references to this batman_if */
 	purge_orig_ref(bat_priv);
@@ -410,6 +409,7 @@ void hardif_disable_interface(struct batman_if *batman_if)
 		softif_destroy(batman_if->soft_iface);
 
 	batman_if->soft_iface = NULL;
+	batman_if->if_status = IF_NOT_IN_USE;
 }
 
 static struct batman_if *hardif_add_interface(struct net_device *net_dev)
-- 
1.7.2.3

