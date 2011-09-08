Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu,  8 Sep 2011 18:40:49 +0200
Message-Id: <1315500051-1122-6-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1315500051-1122-1-git-send-email-lindner_marek@yahoo.de>
References: <1315500051-1122-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/7] batman-adv: update README (date & ap
	isolation sysfs file)
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

From: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 Documentation/networking/batman-adv.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/batman-adv.txt b/Documentation/networking/batman-adv.txt
index 88d4afb..c86d03f 100644
--- a/Documentation/networking/batman-adv.txt
+++ b/Documentation/networking/batman-adv.txt
@@ -1,4 +1,4 @@
-[state: 17-04-2011]
+[state: 21-08-2011]
 
 BATMAN-ADV
 ----------
@@ -68,9 +68,9 @@ All  mesh  wide  settings  can be found in batman's own interface
 folder:
 
 #  ls  /sys/class/net/bat0/mesh/
-#  aggregated_ogms  gw_bandwidth  hop_penalty
-#  bonding          gw_mode       orig_interval
-#  fragmentation    gw_sel_class  vis_mode
+# aggregated_ogms   fragmentation gw_sel_class   vis_mode
+# ap_isolation      gw_bandwidth  hop_penalty
+# bonding           gw_mode       orig_interval
 
 
 There is a special folder for debugging information:
-- 
1.7.5.4

