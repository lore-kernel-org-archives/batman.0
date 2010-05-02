Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon,  3 May 2010 00:14:18 +0200
Message-Id: <1272838458-13899-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201005030012.18621.sven.eckelmann@gmx.de>
References: <201005030012.18621.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Synchronize formating with
	maint
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

Some changes in "batman-adv: Reduce max characters on a line to 80" for
trunk and maint branch were made slightly different and should be
synchronized for easier tracking of changes between them.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/originator.c |    3 ++-
 batman-adv-kernelland/routing.c    |    4 ++--
 batman-adv-kernelland/send.c       |    8 +++-----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/batman-adv-kernelland/originator.c b/batman-adv-kernelland/originator.c
index 13f69bf..8f82bf6 100644
--- a/batman-adv-kernelland/originator.c
+++ b/batman-adv-kernelland/originator.c
@@ -250,6 +250,7 @@ static bool purge_orig_node(struct orig_node *orig_node)
 			update_bonding_candidates(bat_priv, orig_node);
 		}
 	}
+
 	return false;
 }
 
@@ -310,7 +311,7 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
 			       "BATMAN mesh %s "
 			       "disabled - primary interface not active\n",
 			       net_dev->name);
-	else if (bat_priv->primary_if->if_status)
+	else if (bat_priv->primary_if->if_status != IF_ACTIVE)
 		return 0;
 
 	rcu_read_lock();
diff --git a/batman-adv-kernelland/routing.c b/batman-adv-kernelland/routing.c
index 5456b0a..a93ed46 100644
--- a/batman-adv-kernelland/routing.c
+++ b/batman-adv-kernelland/routing.c
@@ -641,8 +641,8 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 
 	if (is_my_oldorig) {
 		bat_dbg(DBG_BATMAN,
-			"Drop packet: ignoring all rebroadcast echos "
-			"(sender: %pM)\n", ethhdr->h_source);
+			"Drop packet: ignoring all rebroadcast echos (sender: "
+			"%pM)\n", ethhdr->h_source);
 		return;
 	}
 
diff --git a/batman-adv-kernelland/send.c b/batman-adv-kernelland/send.c
index 8993493..99d11fe 100644
--- a/batman-adv-kernelland/send.c
+++ b/batman-adv-kernelland/send.c
@@ -152,11 +152,9 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 							    "Sending own" :
 							    "Forwarding"));
 		bat_dbg(DBG_BATMAN,
-			"%s %spacket "
-			"(originator %pM, seqno %d, TQ %d, TTL %d, IDF %s) "
-			"on interface %s [%s]\n",
-			fwd_str,
-			(packet_num > 0 ? "aggregated " : ""),
+			"%s %spacket (originator %pM, seqno %d, TQ %d, TTL %d,"
+			" IDF %s) on interface %s [%s]\n",
+			fwd_str, (packet_num > 0 ? "aggregated " : ""),
 			batman_packet->orig, ntohl(batman_packet->seqno),
 			batman_packet->tq, batman_packet->ttl,
 			(batman_packet->flags & DIRECTLINK ?
-- 
1.7.1

