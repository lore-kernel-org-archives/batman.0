Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:55:41 +0100
Message-Id: <1290383767-32602-4-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 03/29] Staging: batman-adv: Add new sysfs
	files to README
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/README |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/batman-adv/README b/drivers/staging/batman-adv/README
index 7c878bb..77f0cdd 100644
--- a/drivers/staging/batman-adv/README
+++ b/drivers/staging/batman-adv/README
@@ -1,4 +1,4 @@
-[state: 04-09-2010]
+[state: 21-11-2010]
 
 BATMAN-ADV
 ----------
@@ -67,7 +67,8 @@ All  mesh  wide  settings  can be found in batman's own interface
 folder:
 
 #  ls  /sys/class/net/bat0/mesh/
-#  aggregated_ogms  bonding  orig_interval  vis_mode
+#  aggregated_ogms  bonding  fragmentation  orig_interval
+#  vis_mode
 
 
 There is a special folder for debugging informations:
@@ -237,4 +238,3 @@ You can also contact the Authors:
 
 Marek  Lindner  <lindner_marek@yahoo.de>
 Simon  Wunderlich  <siwu@hrz.tu-chemnitz.de>
-
-- 
1.7.2.3

