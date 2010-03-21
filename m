Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon, 22 Mar 2010 00:14:54 +0100
Message-Id: <1269213295-7211-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Update README about vis raw
	output
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

We are now having a newer, more neutral vis output so that we won't have
to change the kernelmodule for adding support of new vis output formats.
This patch adds an explanation about this in the README file of
batman-adv and removes the description about the dot/json format (they
will be added to the README of batctl).

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 README |   43 ++++++++++++++++++++++++++++---------------
 1 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/README b/README
index df21c61..2058a13 100644
--- a/README
+++ b/README
@@ -1,4 +1,4 @@
-[state: 01-01-2010]
+[state: 21-03-2010]
 
 BATMAN-ADV
 ----------
@@ -57,10 +57,11 @@ regular interface:
 # ping 192.168.0.2
 ...
 
+---
 If you want topology visualization, your meshnode must be configured
 as VIS-server:
 
-# echo "server" > /proc/net/batman-adv/vis
+# echo "server" > /proc/net/batman-adv/vis_server
 
 Each node is either configured as "server" or as "client" (default:
 "client"). Clients send their topology data to the server next to them,
@@ -71,19 +72,31 @@ more vis servers sharing the same (or at least very similar) data.
 
 When configured as server, you can get a topology snapshot of your mesh:
 
-# cat /proc/net/batman-adv/vis
-
-This output format is a graphviz formatted text file which can be
-processed with graphviz-tools like dot.
-The labels are similar/compatible to the ETX metric, 1.0 means perfect
-connection (100%), 2.0 means 50%, 3.0 means 33% and so on.
-
-Alternatively, a JSON output format is available. The format can be set
-using by writing either "dot_draw" or "json" into the vis_format file.
-"dot_draw" is selected by default.
-
-echo "json" > /proc/net/batman-adv/vis_format
-
+# cat /proc/net/batman-adv/vis_data
+
+This raw output is intended to be easily parsable and convertable with
+other tools. Have a look at the batctl README if you want a vis output
+in dot or json format for instance and how those outputs could then be
+visualised in an image.
+
+The raw format consists of comma seperated values per entry where each
+entry is giving information about a certain source interface. Each entry
+can/has to have the following values:
+-> "mac" -> mac address of an originator's source interface
+           (each line begins with it)
+-> "TQ mac value" -> src mac's link quality towards mac address of a neighbor
+                     originator's interface which is being used for routing
+-> "HNA mac" -> HNA announced by source mac
+-> "PRIMARY" -> this is a primary interface
+-> "SEC mac" -> secondary mac address of source (requires preceeding
+-> PRIMARY)
+
+The TQ value has a range from 4 to 255 with 255 being the best.
+The HNA entries are showing which hosts are connected to the mesh via bat0
+or being bridged into the mesh network.
+The PRIMARY/SEC values are only applied on primary interfaces
+
+---
 In very mobile scenarios, you might want to adjust the originator
 interval to a lower value. This will make the mesh more responsive to
 topology changes, but will also increase the overhead. Please make sure
-- 
1.7.0

