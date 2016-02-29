Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 29 Feb 2016 08:51:07 +0100
Message-Id: <1456732267-7560-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Add missing headers for bool type
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Fixes: d58a13597ec2 ("batman-adv: Use bool as return type for boolean functions")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bitarray.h       | 1 +
 net/batman-adv/soft-interface.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/batman-adv/bitarray.h b/net/batman-adv/bitarray.h
index f93cbc7..0e6e9d0 100644
--- a/net/batman-adv/bitarray.h
+++ b/net/batman-adv/bitarray.h
@@ -22,6 +22,7 @@
 
 #include <linux/bitops.h>
 #include <linux/compiler.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 
 /**
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index 417d30a..0c5ab40 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -20,6 +20,7 @@
 
 #include "main.h"
 
+#include <linux/types.h>
 #include <net/rtnetlink.h>
 
 struct net_device;
