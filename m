Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 10 Oct 2013 23:59:10 +0200
Message-Id: <1381442351-20066-3-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1381442351-20066-1-git-send-email-sw@simonwunderlich.de>
References: <1381442351-20066-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: update email address for Simon
	Wunderlich
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

My university will stop email service for alumni in january 2014, please
use my new e-mail address instead.

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 README               |    2 +-
 main.h               |    2 +-
 sysfs-class-net-mesh |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/README b/README
index 897d1f4..89ace66 100644
--- a/README
+++ b/README
@@ -200,4 +200,4 @@ Mailing-list:   b.a.t.m.a.n@open-mesh.org (optional  subscription
 You can also contact the Authors:
 
 Marek  Lindner  <lindner_marek@yahoo.de>
-Simon  Wunderlich  <siwu@hrz.tu-chemnitz.de>
+Simon  Wunderlich  <sw@simonwunderlich.de>
diff --git a/main.h b/main.h
index 42f293d..ff39e46 100644
--- a/main.h
+++ b/main.h
@@ -21,7 +21,7 @@
 #define _NET_BATMAN_ADV_MAIN_H_
 
 #define BATADV_DRIVER_AUTHOR "Marek Lindner <lindner_marek@yahoo.de>, " \
-			     "Simon Wunderlich <siwu@hrz.tu-chemnitz.de>"
+			     "Simon Wunderlich <sw@simonwunderlich.de>"
 #define BATADV_DRIVER_DESC   "B.A.T.M.A.N. advanced"
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
diff --git a/sysfs-class-net-mesh b/sysfs-class-net-mesh
index ee4a479..ba826f9 100644
--- a/sysfs-class-net-mesh
+++ b/sysfs-class-net-mesh
@@ -17,7 +17,7 @@ Description:
 
 What:           /sys/class/net/<mesh_iface>/mesh/bonding
 Date:           June 2010
-Contact:        Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
+Contact:        Simon Wunderlich <sw@simonwunderlich.de>
 Description:
                 Indicates whether the data traffic going through the
                 mesh will be sent using multiple interfaces at the
@@ -25,7 +25,7 @@ Description:
 
 What:           /sys/class/net/<mesh_iface>/mesh/bridge_loop_avoidance
 Date:           November 2011
-Contact:        Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
+Contact:        Simon Wunderlich <sw@simonwunderlich.de>
 Description:
                 Indicates whether the bridge loop avoidance feature
                 is enabled. This feature detects and avoids loops
-- 
1.7.10.4

