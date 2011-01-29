Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Jan 2011 22:47:40 +0100
Message-Id: <1296337660-12376-14-git-send-email-sven@narfation.org>
In-Reply-To: <1296337660-12376-1-git-send-email-sven@narfation.org>
References: <1296337660-12376-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 13/13] batman-adv: Merge README of v2011.0.0
	release
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Documentation/networking/batman-adv.txt |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/batman-adv.txt b/Documentation/networking/batman-adv.txt
index 77f0cdd..18afcd8 100644
--- a/Documentation/networking/batman-adv.txt
+++ b/Documentation/networking/batman-adv.txt
@@ -1,4 +1,4 @@
-[state: 21-11-2010]
+[state: 27-01-2011]
 
 BATMAN-ADV
 ----------
@@ -67,15 +67,16 @@ All  mesh  wide  settings  can be found in batman's own interface
 folder:
 
 #  ls  /sys/class/net/bat0/mesh/
-#  aggregated_ogms  bonding  fragmentation  orig_interval
-#  vis_mode
+#  aggregated_ogms  gw_bandwidth  hop_penalty
+#  bonding          gw_mode       orig_interval
+#  fragmentation    gw_sel_class  vis_mode
 
 
 There is a special folder for debugging informations:
 
 #  ls /sys/kernel/debug/batman_adv/bat0/
-#  originators  socket  transtable_global  transtable_local
-#  vis_data
+#  gateways     socket        transtable_global  vis_data
+#  originators  softif_neigh  transtable_local
 
 
 Some of the files contain all sort of status information  regard-
@@ -230,9 +231,8 @@ CONTACT
 Please send us comments, experiences, questions, anything :)
 
 IRC:            #batman   on   irc.freenode.org
-Mailing-list:   b.a.t.m.a.n@b.a.t.m.a.n@lists.open-mesh.org
-                (optional   subscription   at
-                 https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n)
+Mailing-list:   b.a.t.m.a.n@open-mesh.org (optional  subscription
+          at https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n)
 
 You can also contact the Authors:
 
-- 
1.7.2.3

