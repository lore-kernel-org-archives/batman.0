Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 19 Jun 2010 02:51:49 +0200
Message-Id: <1276908713-28365-5-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1276908713-28365-1-git-send-email-sven.eckelmann@gmx.de>
References: <1276908713-28365-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/8] Staging: batman-adv: Add release
	information for version 2010.0.0
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
To: Greg KH <greg@kroah.com>
Cc: b.a.t.m.a.n@lists.open-mesh.net, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

From: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/CHANGELOG |   12 ++++++++++++
 drivers/staging/batman-adv/README    |    2 +-
 drivers/staging/batman-adv/main.h    |    2 +-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/batman-adv/CHANGELOG b/drivers/staging/batman-adv/CHANGELOG
index c8f9d9e..86450b4 100644
--- a/drivers/staging/batman-adv/CHANGELOG
+++ b/drivers/staging/batman-adv/CHANGELOG
@@ -1,3 +1,15 @@
+batman-adv 2010.0.0:
+
+* support latest kernels (2.6.21 - 2.6.35)
+* further code refactoring and cleaning for coding style
+* move from procfs based configuration to sysfs
+* reorganized sequence number handling
+* limit queue lengths for batman and broadcast packets
+* many bugs (endless loop and rogue packets on shutdown, wrong tcpdump output,
+  missing frees in error situations, sleeps in atomic contexts) squashed
+
+ -- Fri, 18 Jun 2010 21:34:26 +0200
+
 batman-adv 0.2.1:
 
 * support latest kernels (2.6.20 - 2.6.33)
diff --git a/drivers/staging/batman-adv/README b/drivers/staging/batman-adv/README
index 14244a2..7192b7f 100644
--- a/drivers/staging/batman-adv/README
+++ b/drivers/staging/batman-adv/README
@@ -1,4 +1,4 @@
-[state: 03-05-2010]
+[state: 12-06-2010]
 
 BATMAN-ADV
 ----------
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index 7cb0b18..f70d99a 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -27,7 +27,7 @@
 #define DRIVER_DESC   "B.A.T.M.A.N. advanced"
 #define DRIVER_DEVICE "batman-adv"
 
-#define SOURCE_VERSION "0.2.2-beta"
+#define SOURCE_VERSION "2010.0.0"
 
 
 /* B.A.T.M.A.N. parameters */
-- 
1.7.1

