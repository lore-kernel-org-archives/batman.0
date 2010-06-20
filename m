Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 20 Jun 2010 22:49:52 +0200
Message-Id: <1277066992-25888-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201006202213.48253.sven.eckelmann@gmx.de>
References: <201006202213.48253.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCHv2] batctl: Merge differences between v2010.0.0
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

batctl started to diverge when the batctl-0.2.x (later batctl-maint) was
created. Even when not all changes inside the batctl branch has to be in
the batctl-maint branch, it must be ensured that all changes in
batctl-maint are also part of batctl.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batctl/Makefile      |    2 +-
 batctl/README        |   79 +++++++++++++++++++++++++++++++++++++++++++++++++-
 batctl/allocate.h    |    2 +-
 batctl/bat-hosts.c   |    2 +-
 batctl/bat-hosts.h   |    2 +-
 batctl/bisect.c      |    2 +-
 batctl/bisect.h      |    2 +-
 batctl/debug.c       |    2 +-
 batctl/functions.c   |    4 +-
 batctl/functions.h   |    3 +-
 batctl/main.c        |    2 +-
 batctl/main.h        |    2 +-
 batctl/man/batctl.8  |   10 +++---
 batctl/ping.c        |    2 +-
 batctl/ping.h        |    2 +-
 batctl/tcpdump.c     |    2 +-
 batctl/tcpdump.h     |    2 +-
 batctl/traceroute.c  |    2 +-
 batctl/traceroute.h  |    2 +-
 batctl/vis.c         |    4 ++-
 batctl/vis.h         |    4 ++-
 batman/hash.c        |    2 +-
 batman/hash.h        |    2 +-
 batman/list-batman.c |    2 +-
 batman/list-batman.h |    2 +-
 25 files changed, 111 insertions(+), 31 deletions(-)

diff --git a/batctl/Makefile b/batctl/Makefile
index c70e578..ab9c075 100644
--- a/batctl/Makefile
+++ b/batctl/Makefile
@@ -1,5 +1,5 @@
 #
-# Copyright (C) 2006-2009 BATMAN contributors
+# Copyright (C) 2006-2010 BATMAN contributors
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of version 2 of the GNU General Public
diff --git a/batctl/README b/batctl/README
index a234799..8f22eb1 100644
--- a/batctl/README
+++ b/batctl/README
@@ -335,7 +335,7 @@ Globally announced HNAs received via the mesh (translation table):
  * ca:a1:5b:e5:00:00 via fe:fe:00:00:06:01
 
 batctl vis_server
-================
+=================
 
 display or modify the status of the VIS server
 
@@ -348,4 +348,81 @@ $ batctl vis_server
 [ ] server mode (server enabled)
 
 
+batctl vis_data
+===============
+
+display the VIS data in dot or JSON format
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
+originator's interfaces which are being used for internal routing in batman.
+The labels are similar/compatible to the ETX metric, 1.0 means perfect
+connection (100%), 2.0 means 50%, 3.0 means 33% and so on.
+
+A host's mac address which is currently connected to the interface of a mesh
+node (either the mesh node itself or hosts being bridged into the mesh) is
+being displayed with an "HNA"-label. (--no-hna omits this output)
+
+To still have the information about which interfaces belong to which mesh node
+a subgraph/cluster is being added. The subpgraph is being labeled with a mesh
+nodes primary interface mac (= Originator MAC). It also has an additional tag
+[peripheries=2] to make this important MAC address visible, for instance in an
+image. (--no-2nd omits this output)
+After the conversion to a png file with graphviz-tools' fdp, all interfaces of
+a node would be combined in a visual box (see below for details).
+
+
+vis-dot to png
+--------------
+
+The vis dot output could then further be converted to an image of the topology
+graph, e.g. with the help of the graphviz-tools. The according commands could 
+then look like this:
+
+$ batctl vis_data dot > /tmp/graph.dot
+$ fdp -Tpng /tmp/graph.dot > graph.png
+
+Meaning of the shapes in this image file:
+* Ellipses: All BATMAN-node and host interfaces can be found in here
+            labeled with the according interface MAC-address.
+* Boxes:    interfaces belonging to one BATMAN-node
+* double circled interfaces: the primary interface of a BATMAN-node
+      (which is known to other BATMAN-nodes only, except direct neighbours)
+* Ellipses with an HNA-arrow: mesh clients (this can be a BATMAN-node itself
+      with its bat0 interface or computers/devices being bridged into the mesh)
+* Arrows with numbers: the transmit quality (in the form 1/TQ) from one
+      BATMAN interface to another BATMAN interface
diff --git a/batctl/allocate.h b/batctl/allocate.h
index 8347373..5584767 100644
--- a/batctl/allocate.h
+++ b/batctl/allocate.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/batctl/bat-hosts.c b/batctl/bat-hosts.c
index 1ffe96a..8948892 100644
--- a/batctl/bat-hosts.c
+++ b/batctl/bat-hosts.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <a.langer@q-dsl.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/batctl/bat-hosts.h b/batctl/bat-hosts.h
index 41fbd0a..0f019f9 100644
--- a/batctl/bat-hosts.h
+++ b/batctl/bat-hosts.h
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/batctl/bisect.c b/batctl/bisect.c
index b57afa3..2fa15f0 100644
--- a/batctl/bisect.c
+++ b/batctl/bisect.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/batctl/bisect.h b/batctl/bisect.h
index 71b6f32..70673e8 100644
--- a/batctl/bisect.h
+++ b/batctl/bisect.h
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/batctl/debug.c b/batctl/debug.c
index e8edb9d..0e877fa 100644
--- a/batctl/debug.c
+++ b/batctl/debug.c
@@ -100,4 +100,4 @@ int handle_debug_table(int argc, char **argv, char *file_path, void table_usage(
 
 	debugfs_make_path(DEBUG_BATIF_PATH "/", full_path, sizeof(full_path));
 	return read_file(full_path, file_path, read_opt);
-}
\ No newline at end of file
+}
diff --git a/batctl/functions.c b/batctl/functions.c
index 4e742b0..3bcb0b2 100644
--- a/batctl/functions.c
+++ b/batctl/functions.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <a.langer@q-dsl.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
@@ -99,7 +99,7 @@ char *get_name_by_macstr(char *mac_str, int read_opt)
 	return get_name_by_macaddr(mac_addr, read_opt);
 }
 
-int check_proc_dir(char *dir)
+static int check_proc_dir(char *dir)
 {
 	struct stat st;
 
diff --git a/batctl/functions.h b/batctl/functions.h
index 4f3a995..847a482 100644
--- a/batctl/functions.h
+++ b/batctl/functions.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <a.langer@q-dsl.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
@@ -35,7 +35,6 @@ char *get_name_by_macaddr(struct ether_addr *mac_addr, int read_opt);
 char *get_name_by_macstr(char *mac_str, int read_opt);
 int read_file(char *dir, char *path, int read_opt);
 int write_file(char *dir, char *fname, char *arg1, char *arg2);
-int check_proc_dir(char *dir);
 char *strchr_anyof(const char *s, const char *n);
 
 extern char *line_ptr;
diff --git a/batctl/main.c b/batctl/main.c
index a225489..0506dce 100644
--- a/batctl/main.c
+++ b/batctl/main.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <a.langer@q-dsl.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/batctl/main.h b/batctl/main.h
index 2fe603e..af2a8ca 100644
--- a/batctl/main.h
+++ b/batctl/main.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <a.langer@q-dsl.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/batctl/man/batctl.8 b/batctl/man/batctl.8
index ad165bf..0684d4f 100644
--- a/batctl/man/batctl.8
+++ b/batctl/man/batctl.8
@@ -56,16 +56,16 @@ protocol.
 .IP "\fBinterface\fP|\fBif\fP     [\fBadd\fP|\fBdel iface(s)\fP]"
 If no parameter is given or the first parameter is neither "add" nor "del" the current interface settings are displayed. In order to add or delete interfaces specify "add" or "del" as first argument and append the interface names you wish to add or delete.
 .br
-.IP "\fBoriginators\fP|\fBo\fP    [\fB\-b\fP][\fB\-n\fP]"
+.IP "\fBoriginators\fP|\fBo\fP    [\fB\-w\fP][\fB\-n\fP]"
 Once started batctl will display the list of announced gateways in the network. Use the "\-w" option to let batctl refresh the list every second. If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output.
 .br
 .IP "\fBinterval\fP|\fBit\fP      [\fBorig_interval\fP]"
 If no parameter is given the current originator interval setting is displayed otherwise the parameter is used to set the originator interval. The interval is in units of milliseconds.
 .br
 .IP "\fBloglevel\fP|\fBll\fP      [\fBlevel\fP]"
-If no parameter is given the current log level settings are displayed otherwise the parameter is used to set the log level. Level 0 disables all logging. Level 1 enables messages related to routing / flooding / broadcasting. Level 2 enables messages related to route or hna added / changed / deleted. Level 3 enables all messages. The messages are sent to the kernel log. Use \fBdmesg\fP(1) to see them. Make sure to have debugging output enabled when compiling the module otherwise the output as well as the loglevel options won't be available.
+If no parameter is given the current log level settings are displayed otherwise the parameter is used to set the log level. Level 0 disables all verbose logging. Level 1 enables messages related to routing / flooding / broadcasting. Level 2 enables messages related to route or hna added / changed / deleted. Level 3 enables all messages. The messages are sent to the kernel log. Use \fBdmesg\fP(1) to see them. Make sure to have debugging output enabled when compiling the module otherwise the output as well as the loglevel options won't be available.
 .br
-.IP "\fBlog\fP|\fBl\fP            [\fBlogfile\fP][\fB\-b\fP][\fB\-n\fP]\fP"
+.IP "\fBlog\fP|\fBl\fP            [\fBlogfile\fP][\fB\-w\fP][\fB\-n\fP]\fP"
 batctl will read the file logfile, or stdin if the logfile parameter is not given, applying filtering so only the B.A.T.M.A.N. Advanced messages are displayed. Once the end of the file has been reached batctl will exit unless the option "\-w" was specified which causes batctl to continue reading the file and print log output whenever new log data has been appended to the file.
 .br
 .IP "\fBgw_mode|gw\fP       [\fBoff\fP|\fBclient\fP|\fBserver\fP] [\fBgw_class\fP]\fP"
@@ -114,10 +114,10 @@ chooses the gateway with the best link quality but switches to another gateway a
 Once started batctl will display the list of announced gateways in the network. Use the "\-w" option to let batctl refresh the list every second. If "\-n" was given batctl will not replace the mac addresses with bat\-host names in the output.
 .br
 .IP "\fBtranslocal\fP|\fBtl\fP    [\fB\-w\fP][\fB\-n\fP]"
-Display the local translation table. batctl will refresh the displayed table every second if the "\-w" option was given. Use "\-n" to let batctl not replace the MAC addresses with bat\-host names in the output.
+Display the local translation table. batctl will refresh the list every second if the "\-w" option was given. Use "\-n" to let batctl not replace the MAC addresses with bat\-host names in the output.
 .br
 .IP "\fBtransglobal\fP|\fBtg\fP   [\fB\-w\fP][\fB\-n\fP]"
-Display the global translation table. batctl will refresh the displayed table every second if the "\-w" option was given. Use "\-n" to let batctl not replace the MAC addresses with bat\-host names in the output.
+Display the global translation table. batctl will refresh the list every second if the "\-w" option was given. Use "\-n" to let batctl not replace the MAC addresses with bat\-host names in the output.
 .br
 .IP "\fBvis_mode|vm\fP	  [\fBmode\fP]\fP"
 If no parameter is given the current vis mode is displayed otherwise the parameter is used to set the vis mode.
diff --git a/batctl/ping.c b/batctl/ping.c
index ce0673e..7820e32 100644
--- a/batctl/ping.c
+++ b/batctl/ping.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <a.langer@q-dsl.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/batctl/ping.h b/batctl/ping.h
index 672e8b9..d578f2a 100644
--- a/batctl/ping.h
+++ b/batctl/ping.h
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/batctl/tcpdump.c b/batctl/tcpdump.c
index c550f0d..77286c1 100644
--- a/batctl/tcpdump.c
+++ b/batctl/tcpdump.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <a.langer@q-dsl.de>
  *
diff --git a/batctl/tcpdump.h b/batctl/tcpdump.h
index db32865..91b839c 100644
--- a/batctl/tcpdump.h
+++ b/batctl/tcpdump.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <a.langer@q-dsl.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/batctl/traceroute.c b/batctl/traceroute.c
index 00fcd89..f5b63f9 100644
--- a/batctl/traceroute.c
+++ b/batctl/traceroute.c
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <a.langer@q-dsl.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/batctl/traceroute.h b/batctl/traceroute.h
index ed5f4f4..f1a2dd2 100644
--- a/batctl/traceroute.h
+++ b/batctl/traceroute.h
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/batctl/vis.c b/batctl/vis.c
index c06beb1..36152cf 100644
--- a/batctl/vis.c
+++ b/batctl/vis.c
@@ -1,4 +1,6 @@
-/* Copyright (C) 2009 B.A.T.M.A.N. contributors:
+/* 
+ * Copyright (C) 2009-2010 B.A.T.M.A.N. contributors:
+ *
  * Andrew Lunn <andrew@lunn.ch>
  *
  * This program is free software; you can redistribute it and/or
diff --git a/batctl/vis.h b/batctl/vis.h
index 8a7511a..7e6b85f 100644
--- a/batctl/vis.h
+++ b/batctl/vis.h
@@ -1,4 +1,6 @@
-/* Copyright (C) 2009 B.A.T.M.A.N. contributors:
+/* 
+ * Copyright (C) 2009-2010 B.A.T.M.A.N. contributors:
+ *
  * Andrew Lunn <andrew@lunn.ch>
  *
  * This program is free software; you can redistribute it and/or
diff --git a/batman/hash.c b/batman/hash.c
index 7a8b4a7..1dccafa 100644
--- a/batman/hash.c
+++ b/batman/hash.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2010 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/batman/hash.h b/batman/hash.h
index 52328d1..56b5b1a 100644
--- a/batman/hash.h
+++ b/batman/hash.h
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2010 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/batman/list-batman.c b/batman/list-batman.c
index 9f8be53..f521834 100644
--- a/batman/list-batman.c
+++ b/batman/list-batman.c
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/batman/list-batman.h b/batman/list-batman.h
index 7e2669b..cbacd7d 100644
--- a/batman/list-batman.h
+++ b/batman/list-batman.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
-- 
1.7.1

