Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 17 Apr 2012 12:24:52 +0200
Message-Id: <1334658294-2413-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: drop useless argument for
	arp_change_timeout()
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

The net_device structure already has a "name" field therefore we don't need to
pass the name by using another parameter.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 distributed-arp-table.c |    4 ++--
 distributed-arp-table.h |    2 +-
 soft-interface.c        |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index b43bece..5386af0 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -562,12 +562,12 @@ bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
 	return false;
 }
 
-void arp_change_timeout(struct net_device *soft_iface, const char *name)
+void arp_change_timeout(struct net_device *soft_iface)
 {
 	struct in_device *in_dev = in_dev_get(soft_iface);
 	if (!in_dev) {
 		pr_err("Unable to set ARP parameters for the batman interface '%s'\n",
-		       name);
+		       soft_iface->name);
 		return;
 	}
 
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 26b98c0..c16aa1b 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -49,7 +49,7 @@ bool dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
 				  struct sk_buff *skb, int hdr_size);
 bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
 			       struct forw_packet *forw_packet);
-void arp_change_timeout(struct net_device *soft_iface, const char *name);
+void arp_change_timeout(struct net_device *soft_iface);
 
 /* hash function to choose an entry in a hash table of given size */
 /* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
diff --git a/soft-interface.c b/soft-interface.c
index b56dafd..de0ceb2 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -381,7 +381,7 @@ struct net_device *softif_create(const char *name)
 		goto free_soft_iface;
 	}
 
-	arp_change_timeout(soft_iface, name);
+	arp_change_timeout(soft_iface);
 
 	bat_priv = netdev_priv(soft_iface);
 
-- 
1.7.9.4

