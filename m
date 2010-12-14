Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Tue, 14 Dec 2010 10:58:09 +0100
Message-Id: <1292320696-11983-4-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1292320696-11983-1-git-send-email-linus.luessing@ascom.ch>
References: <1292320696-11983-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 03/10] batman-adv: Adding workqueue for new
	ndp packets
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

The new neighbor discovery packets will later need their own interval
per interface. For instance on a wifi interface which has regularly
changing link qualities the ndp interval should be faster than on a
static cable link where we would need some probes from time to time
only.

This patch adds a workqueue per interface used by batman-adv. When an
interface is active, a ndp_send() with the according batman_if structure
will be called every second now.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 Makefile.kbuild  |    1 +
 hard-interface.c |    6 ++++++
 ndp.c            |   44 ++++++++++++++++++++++++++++++++++++++++++++
 ndp.h            |    6 ++++++
 types.h          |    2 ++
 5 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100644 ndp.c
 create mode 100644 ndp.h

diff --git a/Makefile.kbuild b/Makefile.kbuild
index e99c198..094eb31 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -42,6 +42,7 @@ batman-adv-y += hard-interface.o
 batman-adv-y += hash.o
 batman-adv-y += icmp_socket.o
 batman-adv-y += main.o
+batman-adv-y += ndp.o
 batman-adv-y += originator.o
 batman-adv-y += ring_buffer.o
 batman-adv-y += routing.o
diff --git a/hard-interface.c b/hard-interface.c
index da7b9a9..cb81c13 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -26,6 +26,7 @@
 #include "translation-table.h"
 #include "routing.h"
 #include "bat_sysfs.h"
+#include "ndp.h"
 #include "originator.h"
 #include "hash.h"
 
@@ -260,6 +261,7 @@ static void hardif_activate_interface(struct batman_if *batman_if)
 		 batman_if->net_dev->name);
 
 	update_min_mtu(batman_if->soft_iface);
+	start_ndp_timer(batman_if);
 	return;
 }
 
@@ -274,6 +276,7 @@ static void hardif_deactivate_interface(struct batman_if *batman_if)
 	bat_info(batman_if->soft_iface, "Interface deactivated: %s\n",
 		 batman_if->net_dev->name);
 
+	stop_ndp_timer(batman_if);
 	update_min_mtu(batman_if->soft_iface);
 }
 
@@ -328,6 +331,8 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 
 	atomic_set(&batman_if->seqno, 1);
 	atomic_set(&batman_if->frag_seqno, 1);
+	ndp_init(batman_if);
+
 	bat_info(batman_if->soft_iface, "Adding interface: %s\n",
 		 batman_if->net_dev->name);
 
@@ -381,6 +386,7 @@ void hardif_disable_interface(struct batman_if *batman_if)
 
 	bat_info(batman_if->soft_iface, "Removing interface: %s\n",
 		 batman_if->net_dev->name);
+	ndp_free(batman_if);
 	dev_remove_pack(&batman_if->batman_adv_ptype);
 	kref_put(&batman_if->refcount, hardif_free_ref);
 
diff --git a/ndp.c b/ndp.c
new file mode 100644
index 0000000..2dfb06d
--- /dev/null
+++ b/ndp.c
@@ -0,0 +1,44 @@
+#include "main.h"
+#include "send.h"
+#include "ndp.h"
+
+void start_ndp_timer(struct batman_if *batman_if)
+{
+	// adding some jitter
+	unsigned long ndp_interval = own_ndp_send_time(batman_if);
+	queue_delayed_work(bat_event_workqueue, &batman_if->ndp_wq,
+			   ndp_interval - jiffies);
+}
+
+void stop_ndp_timer(struct batman_if *batman_if)
+{
+	cancel_delayed_work_sync(&batman_if->ndp_wq);
+}
+
+static void ndp_send(struct work_struct *work)
+{
+	struct batman_if *batman_if = container_of(work, struct batman_if,
+							ndp_wq.work);
+	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
+
+	bat_dbg(DBG_BATMAN, bat_priv,
+		"batman-adv:Sending ndp packet on interface %s, seqno %d\n",
+		batman_if->net_dev, atomic_read(&batman_if->ndp_seqno));
+
+	atomic_inc(&batman_if->ndp_seqno);
+	start_ndp_timer(batman_if);
+}
+
+int ndp_init(struct batman_if *batman_if)
+{
+	atomic_set(&batman_if->ndp_interval, 500);
+	atomic_set(&batman_if->ndp_seqno, 0);
+	INIT_DELAYED_WORK(&batman_if->ndp_wq, ndp_send);
+
+	return 0;
+}
+
+void ndp_free(struct batman_if *batman_if)
+{
+	stop_ndp_timer(batman_if);
+}
diff --git a/ndp.h b/ndp.h
new file mode 100644
index 0000000..de85910
--- /dev/null
+++ b/ndp.h
@@ -0,0 +1,6 @@
+
+void start_ndp_timer(struct batman_if *batman_if);
+void stop_ndp_timer(struct batman_if *batman_if);
+
+int ndp_init(struct batman_if *batman_if);
+void ndp_free(struct batman_if *batman_if);
diff --git a/types.h b/types.h
index 8921e20..e8dfdf6 100644
--- a/types.h
+++ b/types.h
@@ -48,6 +48,8 @@ struct batman_if {
 	struct net_device *soft_iface;
 	struct rcu_head rcu;
 	atomic_t ndp_interval;
+	atomic_t ndp_seqno;
+	struct delayed_work ndp_wq;
 };
 
 /**
-- 
1.7.1

