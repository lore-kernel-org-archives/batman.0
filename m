Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue,  7 Feb 2012 17:19:58 +0800
Message-Id: <1328606405-2490-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201202071719.22804.lindner_marek@yahoo.de>
References: <201202071719.22804.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/8] batman-adv: move ogm initialization into
	the proper function
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

Signed-of-by: Marek Lindner <lindner_marek@yahoo.de>
---
 hard-interface.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index 612f2c8..e16c996 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -337,7 +337,6 @@ int hardif_enable_interface(struct hard_iface *hard_iface,
 	hard_iface->batman_adv_ptype.dev = hard_iface->net_dev;
 	dev_add_pack(&hard_iface->batman_adv_ptype);
 
-	atomic_set(&hard_iface->seqno, 1);
 	atomic_set(&hard_iface->frag_seqno, 1);
 	bat_info(hard_iface->soft_iface, "Adding interface: %s\n",
 		 hard_iface->net_dev->name);
@@ -463,6 +462,13 @@ static struct hard_iface *hardif_add_interface(struct net_device *net_dev)
 	check_known_mac_addr(hard_iface->net_dev);
 	list_add_tail_rcu(&hard_iface->list, &hardif_list);
 
+	/**
+	 * This can't be called via a bat_priv callback because
+	 * we have no bat_priv yet.
+	 */
+	atomic_set(&hard_iface->seqno, 1);
+	hard_iface->packet_buff = NULL;
+
 	return hard_iface;
 
 free_if:
-- 
1.7.5.4

