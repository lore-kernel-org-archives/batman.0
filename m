Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon, 22 Mar 2010 00:14:55 +0100
Message-Id: <1269213295-7211-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1269213295-7211-1-git-send-email-linus.luessing@web.de>
References: <1269213295-7211-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Update README's vis section
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

This patch adds a short description and a more detailed explanation
of the vis_data output. Furthermore the final steps of how to
convert a vis-dot file to a png graphic is now being explained here.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Index: README
===================================================================
--- README	(revision 1607)
+++ README	(working copy)
@@ -335,7 +335,7 @@
  * ca:a1:5b:e5:00:00 via fe:fe:00:00:06:01
 
 batctl vis_server
-================
+=================
 
 display or modify the status of the VIS server
 
@@ -348,4 +348,80 @@
 [ ] server mode (server enabled)
 
 
+batctl vis_data
+===============
 
+display the VIS data in dot or JSON format
+
+
+Usage:
+
+batctl vis dot {-h}{--no-HNA|-H} {--no-2nd|-2} {--numbers|-n}
+or
+batctl vis json {-h}{--no-HNA|-H} {--no-2nd|-2} {--numbers|-n}
+
+
+Example:
+(A <- 100% -> B,B-if2 <- 50% -> C)
+
+$ batctl vis_data dot
+digraph {
+	"A" -> "B" [label="1.00"]
+	"A" -> "00:ff:f3:cc:68:ac" [label="HNA"]
+	subgraph "cluster_A" {
+		"A" [peripheries=2]
+	}
+	"B" -> "A" [label="1.00"]
+	"B-if2" -> "C" [label="2.00"]
+	"B" -> "22:ff:f3:cc:68:ac" [label="HNA"]
+	subgraph "cluster_B" {
+		"B" [peripheries=2]
+		"B-if2"
+	}
+	"C" -> "B-if2" [label="2.00"]
+	"C" -> "44:ff:f3:cc:68:ac" [label="HNA"]
+	subgraph "cluster_C" {
+		"C" [peripheries=2]
+	}
+}
+
+
+Explanation:
+
+The vis dot (or json) output is adding an entry for each link between two
+originator's interfaces which are being used for batman's internal routing.
+The labels are similar/compatible to the ETX metric, 1.0 means perfect
+connection (100%), 2.0 means 50%, 3.0 means 33% and so on.
+
+A host's mac address which is currently connected to the interface of a mesh
+node (either the mesh node itself or hosts being bridged into the mesh) is
+being displayed with an "HNA"-label. (--no-hna omits this output)
+
+To still have the information about which interfaces belong to which mesh node
+a subgraph/cluster is being added. The subpgraph is being labeled with a mesh
+nodes's primary interface mac (= Originator MAC) which is also having an
+additional [peripheries=2] to make this important MAC address visible in an
+image for instance. (--no-2nd omits this output)
+After the conversion to a png file with graphviz-tools' fdp, all interfaces of
+a node would be combined in a visual box (see below for details).
+
+
+vis-dot to png
+--------------
+
+The vis dot output could then further be converted to an image of the topology
+graph with the help of the graphviz-tools for instance. The according commands
+could then look like this:
+$ batctl vis_data dot > /tmp/graph.dot
+$ fdp -Tpng /tmp/graph.dot > graph.png
+
+Meaning of the shapes in this image file:
+* Ellipses: Every BATMAN-node's and host's interface can be found in here
+            labeled with the according interface's MAC-address.
+* Boxes:    interfaces belonging to one BATMAN-node
+* double circled interfaces: the primary interface of a BATMAN-node
+      (which is known to other BATMAN-nodes only, except direct neighbours)
+* Ellipses with an HNA-arrow: mesh clients (this can be a BATMAN-node itself
+      with its bat0 interface or computers/devices being bridged into the mesh)
+* Arrows with numbers: the transmit quality (in the form 1/TQ) from one
+      BATMAN-node's interface to another BATMAN-node's interface
