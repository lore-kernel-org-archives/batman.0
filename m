Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 10 Dec 2009 19:50:43 +0100
Message-Id: <1260471043-25687-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <200912101749.11482.sven.eckelmann@gmx.de>
References: <200912101749.11482.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] [batman-adv] Remove whitespace style errors
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
To: b.a.t.m.a.n@lists.open-mesh.net

checkpatch.pl found different smaller errors regarding trailing
whitespaces or trailing extra newlines before EOF. These should be
removed to follow linux-2.6 CodingStyle.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/CHANGELOG    |    2 +-
 batman-adv-kernelland/originator.c |    2 --
 batman-adv-kernelland/originator.h |    1 -
 batman-adv-kernelland/proc.c       |    2 --
 batman-adv-kernelland/routing.c    |    1 -
 batman-adv-kernelland/routing.h    |    6 +++---
 batman-adv-kernelland/vis.c        |    1 -
 7 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/batman-adv-kernelland/CHANGELOG b/batman-adv-kernelland/CHANGELOG
index 18d82f5..8a18163 100644
--- a/batman-adv-kernelland/CHANGELOG
+++ b/batman-adv-kernelland/CHANGELOG
@@ -19,7 +19,7 @@ batman-adv 0.1:
 * support latest kernels (2.6.20 - 2.6.28)
 * LOTS of cleanup: locking, stack usage, memory leaks
 * Change Ethertype from 0x0842 to 0x4305
-  unregistered at IEEE, if you want to sponsor an official Ethertype ($2500) 
+  unregistered at IEEE, if you want to sponsor an official Ethertype ($2500)
   please contact us
 
  -- Sun, 28 Dec 2008 00:44:31 +0100
diff --git a/batman-adv-kernelland/originator.c b/batman-adv-kernelland/originator.c
index 9962af7..80106f7 100644
--- a/batman-adv-kernelland/originator.c
+++ b/batman-adv-kernelland/originator.c
@@ -239,5 +239,3 @@ void purge_orig(struct work_struct *work)
 
 	start_purge_timer();
 }
-
-
diff --git a/batman-adv-kernelland/originator.h b/batman-adv-kernelland/originator.h
index 6ef7a05..c1a9c2d 100644
--- a/batman-adv-kernelland/originator.h
+++ b/batman-adv-kernelland/originator.h
@@ -28,4 +28,3 @@ struct orig_node *get_orig_node(uint8_t *addr);
 struct neigh_node *
 create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 		uint8_t *neigh, struct batman_if *if_incoming);
-
diff --git a/batman-adv-kernelland/proc.c b/batman-adv-kernelland/proc.c
index ed4c734..f476d9c 100644
--- a/batman-adv-kernelland/proc.c
+++ b/batman-adv-kernelland/proc.c
@@ -827,5 +827,3 @@ int setup_procfs(void)
 
 	return 0;
 }
-
-
diff --git a/batman-adv-kernelland/routing.c b/batman-adv-kernelland/routing.c
index f4be6be..2873468 100644
--- a/batman-adv-kernelland/routing.c
+++ b/batman-adv-kernelland/routing.c
@@ -1063,4 +1063,3 @@ void batman_data_ready(struct sock *sk, int len)
 	atomic_set(&data_ready_cond, 1);
 	wake_up_interruptible(&thread_wait);
 }
-
diff --git a/batman-adv-kernelland/routing.h b/batman-adv-kernelland/routing.h
index 985728f..890a4f5 100644
--- a/batman-adv-kernelland/routing.h
+++ b/batman-adv-kernelland/routing.h
@@ -27,9 +27,9 @@ extern atomic_t exit_cond;
 void slide_own_bcast_window(struct batman_if *batman_if);
 void batman_data_ready(struct sock *sk, int len);
 int packet_recv_thread(void *data);
-void receive_bat_packet(struct ethhdr *ethhdr, 
-				struct batman_packet *batman_packet, 
-				unsigned char *hna_buff, int hna_buff_len, 
+void receive_bat_packet(struct ethhdr *ethhdr,
+				struct batman_packet *batman_packet,
+				unsigned char *hna_buff, int hna_buff_len,
 				struct batman_if *if_incoming);
 void update_routes(struct orig_node *orig_node,
 				struct neigh_node *neigh_node,
diff --git a/batman-adv-kernelland/vis.c b/batman-adv-kernelland/vis.c
index cdb8aab..c26d48c 100644
--- a/batman-adv-kernelland/vis.c
+++ b/batman-adv-kernelland/vis.c
@@ -559,4 +559,3 @@ static void start_vis_timer(void)
 	queue_delayed_work(bat_event_workqueue, &vis_timer_wq,
 			   (atomic_read(&vis_interval)/1000) * HZ);
 }
-
-- 
1.6.5.4

