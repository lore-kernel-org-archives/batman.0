Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 22 Oct 2009 01:21:51 +0800
References: <200910211400.55696.sven.eckelmann@gmx.de>
	<1256138761-12940-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1256138761-12940-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200910220121.51879.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [batman-adv] Start to send originator messages
	when interface gets active
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


Please try this revised patch - it should avoid a race condition in which 
we may end up with 2 schedule_own_packet() running at the same time.

The module gets in a inactive state when all interfaces are down. This
stops the sending of new packets. When a interface gets activated again
it must reactivate the module and then start the sending of new
originator messages.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
diff --git a/batman-adv-kernelland/hard-interface.c b/batman-adv-kernelland/hard-interface.c
index f04d2db..960e86c 100644
--- a/batman-adv-kernelland/hard-interface.c
+++ b/batman-adv-kernelland/hard-interface.c
@@ -425,6 +425,10 @@ static int hard_if_event(struct notifier_block *this,
 		break;
 	case NETDEV_UP:
 		hardif_activate_interface(batman_if);
+		if ((atomic_read(&module_state) == MODULE_INACTIVE) &&
+		    (hardif_get_active_if_num() > 0)) {
+			activate_module();
+		}
 		break;
 	/* NETDEV_CHANGEADDR - mac address change - what are we doing here ? */
 	default:
diff --git a/batman-adv-kernelland/main.c b/batman-adv-kernelland/main.c
index 8fbefc2..4e70c95 100644
--- a/batman-adv-kernelland/main.c
+++ b/batman-adv-kernelland/main.c
@@ -173,7 +173,7 @@ end:
 /* shuts down the whole module.*/
 void shutdown_module(void)
 {
-	atomic_set(&module_state, MODULE_INACTIVE);
+	atomic_set(&module_state, MODULE_DEACTIVATING);
 
 	purge_outstanding_packets();
 	flush_workqueue(bat_event_workqueue);
@@ -199,6 +199,7 @@ void shutdown_module(void)
 
 	hardif_remove_interfaces();
 	synchronize_rcu();
+	atomic_set(&module_state, MODULE_INACTIVE);
 }
 
 void inc_module_count(void)
diff --git a/batman-adv-kernelland/main.h b/batman-adv-kernelland/main.h
index 21d3919..9493f96 100644
--- a/batman-adv-kernelland/main.h
+++ b/batman-adv-kernelland/main.h
@@ -63,7 +63,7 @@
 
 #define MODULE_INACTIVE 0
 #define MODULE_ACTIVE 1
-/* #define MODULE_WAITING 2 -- not needed anymore */
+#define MODULE_DEACTIVATING 2
 
 
 /*
diff --git a/batman-adv-kernelland/send.c b/batman-adv-kernelland/send.c
index 73fe371..01396b4 100644
--- a/batman-adv-kernelland/send.c
+++ b/batman-adv-kernelland/send.c
@@ -399,7 +399,7 @@ void send_outstanding_bcast_packet(struct work_struct *work)
 	/* if we still have some more bcasts to send and we are not shutting
 	 * down */
 	if ((forw_packet->num_packets < 3) &&
-	    (atomic_read(&module_state) != MODULE_INACTIVE))
+	    (atomic_read(&module_state) != MODULE_DEACTIVATING))
 		_add_bcast_packet_to_list(forw_packet, ((5 * HZ) / 1000));
 	else
 		forw_packet_free(forw_packet);
@@ -424,7 +424,7 @@ void send_outstanding_bat_packet(struct work_struct *work)
 	 * shutting down
 	 */
 	if ((forw_packet->own) &&
-	    (atomic_read(&module_state) != MODULE_INACTIVE))
+	    (atomic_read(&module_state) != MODULE_DEACTIVATING))
 		schedule_own_packet(forw_packet->if_incoming);
 
 	forw_packet_free(forw_packet);
