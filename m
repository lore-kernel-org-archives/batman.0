Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat,  7 Nov 2009 13:51:37 +0100
Message-Id: <1257598297-20037-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Mark local symbols as static
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


Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/aggregation.c       |    2 +-
 batman-adv-kernelland/hard-interface.c    |    6 +++---
 batman-adv-kernelland/proc.c              |    2 +-
 batman-adv-kernelland/routing.c           |    4 ++--
 batman-adv-kernelland/soft-interface.c    |    2 +-
 batman-adv-kernelland/translation-table.c |    2 +-
 batman-adv-kernelland/vis.c               |    2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/batman-adv-kernelland/aggregation.c b/batman-adv-kernelland/aggregation.c
index 5a31e94..9c6e681 100644
--- a/batman-adv-kernelland/aggregation.c
+++ b/batman-adv-kernelland/aggregation.c
@@ -88,7 +88,7 @@ static bool can_aggregate_with(struct batman_packet *new_batman_packet,
 }
 
 /* create a new aggregated packet and add this packet to it */
-void new_aggregated_packet(unsigned char *packet_buff,
+static void new_aggregated_packet(unsigned char *packet_buff,
 			   int packet_len,
 			   unsigned long send_time,
 			   bool direct_link,
diff --git a/batman-adv-kernelland/hard-interface.c b/batman-adv-kernelland/hard-interface.c
index e0d0342..8d8dff5 100644
--- a/batman-adv-kernelland/hard-interface.c
+++ b/batman-adv-kernelland/hard-interface.c
@@ -72,7 +72,7 @@ int hardif_min_mtu(void)
 	return min_mtu;
 }
 
-void check_known_mac_addr(uint8_t *addr)
+static void check_known_mac_addr(uint8_t *addr)
 {
 	struct batman_if *batman_if;
 	char mac_string[ETH_STR_LEN];
@@ -105,7 +105,7 @@ void update_min_mtu(void)
 }
 
 /* checks if the interface is up. (returns 1 if it is) */
-int hardif_is_interface_up(char *dev)
+static int hardif_is_interface_up(char *dev)
 {
 	struct net_device *net_dev;
 
@@ -176,7 +176,7 @@ void hardif_deactivate_interface(struct batman_if *batman_if)
 }
 
 /* (re)activate given interface. */
-void hardif_activate_interface(struct batman_if *batman_if)
+static void hardif_activate_interface(struct batman_if *batman_if)
 {
 	struct sockaddr_ll bind_addr;
 	int retval;
diff --git a/batman-adv-kernelland/proc.c b/batman-adv-kernelland/proc.c
index b3eb69d..792a006 100644
--- a/batman-adv-kernelland/proc.c
+++ b/batman-adv-kernelland/proc.c
@@ -30,7 +30,7 @@
 #include "vis.h"
 #include "compat.h"
 
-uint8_t vis_format = DOT_DRAW;
+static uint8_t vis_format = DOT_DRAW;
 
 static struct proc_dir_entry *proc_batman_dir, *proc_interface_file;
 static struct proc_dir_entry *proc_orig_interval_file, *proc_originators_file;
diff --git a/batman-adv-kernelland/routing.c b/batman-adv-kernelland/routing.c
index 220dbf7..b33cef9 100644
--- a/batman-adv-kernelland/routing.c
+++ b/batman-adv-kernelland/routing.c
@@ -46,7 +46,7 @@ static DECLARE_DELAYED_WORK(purge_orig_wq, purge_orig);
 static atomic_t data_ready_cond;
 atomic_t exit_cond;
 
-void start_purge_timer(void)
+static void start_purge_timer(void)
 {
 	queue_delayed_work(bat_event_workqueue, &purge_orig_wq, 1 * HZ);
 }
@@ -618,7 +618,7 @@ void purge_orig(struct work_struct *work)
 	start_purge_timer();
 }
 
-int receive_raw_packet(struct socket *raw_sock, unsigned char *packet_buff, int packet_buff_len)
+static int receive_raw_packet(struct socket *raw_sock, unsigned char *packet_buff, int packet_buff_len)
 {
 	struct kvec iov;
 	struct msghdr msg;
diff --git a/batman-adv-kernelland/soft-interface.c b/batman-adv-kernelland/soft-interface.c
index 18e5e8f..d543f50 100644
--- a/batman-adv-kernelland/soft-interface.c
+++ b/batman-adv-kernelland/soft-interface.c
@@ -68,7 +68,7 @@ int main_if_was_up(void)
 	return (memcmp(mainIfAddr, mainIfAddr_default, ETH_ALEN) != 0 ? 1 : 0);
 }
 
-int my_skb_push(struct sk_buff *skb, unsigned int len)
+static int my_skb_push(struct sk_buff *skb, unsigned int len)
 {
 	int result = 0;
 
diff --git a/batman-adv-kernelland/translation-table.c b/batman-adv-kernelland/translation-table.c
index 9936bc2..c2190e1 100644
--- a/batman-adv-kernelland/translation-table.c
+++ b/batman-adv-kernelland/translation-table.c
@@ -32,7 +32,7 @@ static struct hashtable_t *hna_global_hash;
 atomic_t hna_local_changed;
 
 DEFINE_SPINLOCK(hna_local_hash_lock);
-DEFINE_SPINLOCK(hna_global_hash_lock);
+static DEFINE_SPINLOCK(hna_global_hash_lock);
 
 static DECLARE_DELAYED_WORK(hna_local_purge_wq, hna_local_purge);
 
diff --git a/batman-adv-kernelland/vis.c b/batman-adv-kernelland/vis.c
index 22235ad..f6c9acb 100644
--- a/batman-adv-kernelland/vis.c
+++ b/batman-adv-kernelland/vis.c
@@ -369,7 +369,7 @@ static int generate_vis_packet(void)
 	return 0;
 }
 
-void purge_vis_packets(void)
+static void purge_vis_packets(void)
 {
 	struct hash_it_t *hashit = NULL;
 	struct vis_info *info;
-- 
1.6.5.2

