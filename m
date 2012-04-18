Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 18 Apr 2012 12:00:00 +0200
Message-Id: <1334743210-12338-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1334743210-12338-1-git-send-email-ordex@autistici.org>
References: <1334743210-12338-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 03/13] batman-adv: move ogm initialization
	into the proper function
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

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/hard-interface.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 8c4b790..f152007 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -332,7 +332,6 @@ int hardif_enable_interface(struct hard_iface *hard_iface,
 	hard_iface->batman_adv_ptype.dev = hard_iface->net_dev;
 	dev_add_pack(&hard_iface->batman_adv_ptype);
 
-	atomic_set(&hard_iface->seqno, 1);
 	atomic_set(&hard_iface->frag_seqno, 1);
 	bat_info(hard_iface->soft_iface, "Adding interface: %s\n",
 		 hard_iface->net_dev->name);
@@ -451,6 +450,13 @@ static struct hard_iface *hardif_add_interface(struct net_device *net_dev)
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
1.7.9.4

