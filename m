Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed,  9 Dec 2009 21:09:32 +0100
Message-Id: <1260389373-1071-10-git-send-email-andrew@lunn.ch>
In-Reply-To: <1260389373-1071-9-git-send-email-andrew@lunn.ch>
References: <1260389373-1071-1-git-send-email-andrew@lunn.ch>
	<1260389373-1071-2-git-send-email-andrew@lunn.ch>
	<1260389373-1071-3-git-send-email-andrew@lunn.ch>
	<1260389373-1071-4-git-send-email-andrew@lunn.ch>
	<1260389373-1071-5-git-send-email-andrew@lunn.ch>
	<1260389373-1071-6-git-send-email-andrew@lunn.ch>
	<1260389373-1071-7-git-send-email-andrew@lunn.ch>
	<1260389373-1071-8-git-send-email-andrew@lunn.ch>
	<1260389373-1071-9-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 09/10] staging:batman-adv:correctly name the
	configuration option for debugging
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
To: gregkh@suse.de
Cc: devel@driverdev.osuosl.org, b.a.t.m.a.n@lists.open-mesh.net, Marek Lindner <lindner_marek@yahoo.de>

From: marek <marek@45894c77-fb22-0410-b583-ff6e7d5dbf6c>

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>

git-svn-id: http://downloads.open-mesh.net/svn/batman/trunk/batman-adv-kernelland@1491 45894c77-fb22-0410-b583-ff6e7d5dbf6c
---
 Makefile.kbuild |    2 +-
 README          |    2 +-
 main.c          |    2 +-
 main.h          |    4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile.kbuild b/Makefile.kbuild
index cff1185..07e176b 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -25,7 +25,7 @@ ifeq ($(MAKING_MODULES),1)
 -include $(TOPDIR)/Rules.make
 endif
 
-# EXTRA_CFLAGS += -DCONFIG_BATMAN_DEBUG
+# EXTRA_CFLAGS += -DCONFIG_BATMAN_ADV_DEBUG
 
 ifneq ($(REVISION),)
 EXTRA_CFLAGS += -DREVISION_VERSION=\"r$(REVISION)\"
diff --git a/README b/README
index 6c62482..a6a419d 100644
--- a/README
+++ b/README
@@ -115,7 +115,7 @@ kernel, use "make menuconfig" and enable the option
 "B.A.T.M.A.N. debugging". When compiling outside of the kernel tree it
 is necessary to edit the file Makefile.kbuild and uncomment the line
 
-#EXTRA_CFLAGS += -DCONFIG_BATMAN_DEBUG
+#EXTRA_CFLAGS += -DCONFIG_BATMAN_ADV_DEBUG
 
 The additional debug output is by default disabled. It can be enabled
 either at kernel modules load time or during run time. To enable debug
diff --git a/main.c b/main.c
index a74bfbe..434c600 100644
--- a/main.c
+++ b/main.c
@@ -57,7 +57,7 @@ atomic_t module_state;
 
 struct workqueue_struct *bat_event_workqueue;
 
-#ifdef CONFIG_BATMAN_DEBUG
+#ifdef CONFIG_BATMAN_ADV_DEBUG
 int debug;
 
 module_param(debug, int, 0644);
diff --git a/main.h b/main.h
index 6907cac..eb6a702 100644
--- a/main.h
+++ b/main.h
@@ -76,7 +76,7 @@
 			 * broadcasting / etc */
 #define DBG_ROUTES 2	/* route or hna added / changed / deleted */
 
-#ifdef CONFIG_BATMAN_DEBUG
+#ifdef CONFIG_BATMAN_ADV_DEBUG
 extern int debug;
 
 extern int bat_debug_type(int type);
@@ -85,7 +85,7 @@ extern int bat_debug_type(int type);
 			printk(KERN_DEBUG "batman-adv:" fmt, ## arg);	\
 	}								\
 	while (0)
-#else /* !CONFIG_BATMAN_DEBUG */
+#else /* !CONFIG_BATMAN_ADV_DEBUG */
 #define bat_dbg(type, fmt, arg...) do {		\
 	}					\
 	while (0)
-- 
1.6.5.4

