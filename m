Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue,  5 Jul 2011 15:43:58 +0200
Message-Id: <1309873440-11704-5-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1309873440-11704-1-git-send-email-lindner_marek@yahoo.de>
References: <1309873440-11704-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/6] batman-adv: broadcast primary OGM on all
	active hard-interfaces
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

The primary interface OGM has to be broadcasted on all hard-interfaces
even if the primary interface is not the first interface (if_num = 0).
Therefore the code has to compare the originating interface with the
primary interface instead of checking the if_num.

Reported-by: Linus Luessing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/send.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 2f62b2e..4b8e11b 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -163,6 +163,7 @@ static void send_packet(struct forw_packet *forw_packet)
 	struct hard_iface *hard_iface;
 	struct net_device *soft_iface;
 	struct bat_priv *bat_priv;
+	struct hard_iface *primary_if = NULL;
 	struct batman_packet *batman_packet =
 		(struct batman_packet *)(forw_packet->skb->data);
 	int directlink = (batman_packet->flags & DIRECTLINK ? 1 : 0);
@@ -170,19 +171,23 @@ static void send_packet(struct forw_packet *forw_packet)
 	if (!forw_packet->if_incoming) {
 		pr_err("Error - can't forward packet: incoming iface not "
 		       "specified\n");
-		return;
+		goto out;
 	}
 
 	soft_iface = forw_packet->if_incoming->soft_iface;
 	bat_priv = netdev_priv(soft_iface);
 
 	if (forw_packet->if_incoming->if_status != IF_ACTIVE)
-		return;
+		goto out;
+
+	primary_if = primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		goto out;
 
 	/* multihomed peer assumed */
 	/* non-primary OGMs are only broadcasted on their interface */
 	if ((directlink && (batman_packet->ttl == 1)) ||
-	    (forw_packet->own && (forw_packet->if_incoming->if_num > 0))) {
+	    (forw_packet->own && (forw_packet->if_incoming != primary_if))) {
 
 		/* FIXME: what about aggregated packets ? */
 		bat_dbg(DBG_BATMAN, bat_priv,
@@ -199,7 +204,7 @@ static void send_packet(struct forw_packet *forw_packet)
 				broadcast_addr);
 		forw_packet->skb = NULL;
 
-		return;
+		goto out;
 	}
 
 	/* broadcast on every interface */
@@ -211,6 +216,10 @@ static void send_packet(struct forw_packet *forw_packet)
 		send_packet_to_if(forw_packet, hard_iface);
 	}
 	rcu_read_unlock();
+
+out:
+	if (primary_if)
+		hardif_free_ref(primary_if);
 }
 
 static void realloc_packet_buffer(struct hard_iface *hard_iface,
-- 
1.7.5.3

