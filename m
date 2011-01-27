Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 27 Jan 2011 14:56:09 +0100
Message-Id: <1296136571-13226-3-git-send-email-sven@narfation.org>
In-Reply-To: <1296136571-13226-1-git-send-email-sven@narfation.org>
References: <1296136571-13226-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Remove unused definitions
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batman-adv/main.h |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/batman-adv/main.h b/batman-adv/main.h
index c239c97..b07968d 100644
--- a/batman-adv/main.h
+++ b/batman-adv/main.h
@@ -22,9 +22,6 @@
 #ifndef _NET_BATMAN_ADV_MAIN_H_
 #define _NET_BATMAN_ADV_MAIN_H_
 
-/* Kernel Programming */
-#define LINUX
-
 #define DRIVER_AUTHOR "Marek Lindner <lindner_marek@yahoo.de>, " \
 		      "Simon Wunderlich <siwu@hrz.tu-chemnitz.de>"
 #define DRIVER_DESC   "B.A.T.M.A.N. advanced"
@@ -54,7 +51,6 @@
 
 #define NUM_WORDS (TQ_LOCAL_WINDOW_SIZE / WORD_BIT_SIZE)
 
-#define PACKBUFF_SIZE 2000
 #define LOG_BUF_LEN 8192	  /* has to be a power of 2 */
 
 #define VIS_INTERVAL 5000	/* 5 seconds */
@@ -96,15 +92,11 @@
 #define DBG_ROUTES 2	/* route or hna added / changed / deleted */
 #define DBG_ALL 3
 
-#define LOG_BUF_LEN 8192          /* has to be a power of 2 */
-
 
 /*
  *  Vis
  */
 
-/* #define VIS_SUBCLUSTERS_DISABLED */
-
 /*
  * Kernel headers
  */
@@ -160,13 +152,6 @@ static inline void bat_dbg(char type __always_unused,
 }
 #endif
 
-#define bat_warning(net_dev, fmt, arg...)				\
-	do {								\
-		struct net_device *_netdev = (net_dev);                 \
-		struct bat_priv *_batpriv = netdev_priv(_netdev);       \
-		bat_dbg(DBG_ALL, _batpriv, fmt, ## arg);		\
-		pr_warning("%s: " fmt, _netdev->name, ## arg);		\
-	} while (0)
 #define bat_info(net_dev, fmt, arg...)					\
 	do {								\
 		struct net_device *_netdev = (net_dev);                 \
-- 
1.7.2.3

