Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  5 May 2011 01:11:35 +0200
Message-Id: <1304550695-6922-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1304549599-25241-1-git-send-email-ordex@autistici.org>
References: <1304549599-25241-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batctl: rename stuff from *hna* to *tt*
	(translation table)
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

To be coherent, all the functions/variables/constats have been renamed to the
TranslationTable style

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 README       |   18 +++++++++---------
 man/batctl.8 |   12 ++++++------
 packet.h     |    2 +-
 sys.c        |    2 +-
 vis.c        |   38 +++++++++++++++++++-------------------
 5 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/README b/README
index 8f22eb1..d11c6d3 100644
--- a/README
+++ b/README
@@ -312,7 +312,7 @@ Usage: batctl translocal|tl
 Example:
 
 $ batctl translocal
-Locally retrieved addresses (from bat0) announced via HNA:
+Locally retrieved addresses (from bat0) announced via TT:
  * d6:e0:fd:d9:00:00
 
 batctl transglobal
@@ -324,7 +324,7 @@ Usage: batctl transglobal|tg
 
 Example:
 
-Globally announced HNAs received via the mesh (translation table):
+Globally announced TT entries received via the mesh (translation table):
  * 16:aa:c4:a2:00:00 via fe:fe:00:00:09:01
  * 5a:32:f9:df:00:00 via fe:fe:00:00:03:01
  * 32:ae:5a:00:00:00 via fe:fe:00:00:04:01
@@ -356,9 +356,9 @@ display the VIS data in dot or JSON format
 
 Usage:
 
-batctl vis dot {-h}{--no-HNA|-H} {--no-2nd|-2} {--numbers|-n}
+batctl vis dot {-h}{--no-TT|-T} {--no-2nd|-2} {--numbers|-n}
 or
-batctl vis json {-h}{--no-HNA|-H} {--no-2nd|-2} {--numbers|-n}
+batctl vis json {-h}{--no-TT|-T} {--no-2nd|-2} {--numbers|-n}
 
 
 Example:
@@ -367,19 +367,19 @@ Example:
 $ batctl vis_data dot
 digraph {
 	"A" -> "B" [label="1.00"]
-	"A" -> "00:ff:f3:cc:68:ac" [label="HNA"]
+	"A" -> "00:ff:f3:cc:68:ac" [label="TT"]
 	subgraph "cluster_A" {
 		"A" [peripheries=2]
 	}
 	"B" -> "A" [label="1.00"]
 	"B-if2" -> "C" [label="2.00"]
-	"B" -> "22:ff:f3:cc:68:ac" [label="HNA"]
+	"B" -> "22:ff:f3:cc:68:ac" [label="TT"]
 	subgraph "cluster_B" {
 		"B" [peripheries=2]
 		"B-if2"
 	}
 	"C" -> "B-if2" [label="2.00"]
-	"C" -> "44:ff:f3:cc:68:ac" [label="HNA"]
+	"C" -> "44:ff:f3:cc:68:ac" [label="TT"]
 	subgraph "cluster_C" {
 		"C" [peripheries=2]
 	}
@@ -395,7 +395,7 @@ connection (100%), 2.0 means 50%, 3.0 means 33% and so on.
 
 A host's mac address which is currently connected to the interface of a mesh
 node (either the mesh node itself or hosts being bridged into the mesh) is
-being displayed with an "HNA"-label. (--no-hna omits this output)
+being displayed with an "TT"-label. (--no-TT omits this output)
 
 To still have the information about which interfaces belong to which mesh node
 a subgraph/cluster is being added. The subpgraph is being labeled with a mesh
@@ -422,7 +422,7 @@ Meaning of the shapes in this image file:
 * Boxes:    interfaces belonging to one BATMAN-node
 * double circled interfaces: the primary interface of a BATMAN-node
       (which is known to other BATMAN-nodes only, except direct neighbours)
-* Ellipses with an HNA-arrow: mesh clients (this can be a BATMAN-node itself
+* Ellipses with a TT-arrow: mesh clients (this can be a BATMAN-node itself
       with its bat0 interface or computers/devices being bridged into the mesh)
 * Arrows with numbers: the transmit quality (in the form 1/TQ) from one
       BATMAN interface to another BATMAN interface
diff --git a/man/batctl.8 b/man/batctl.8
index 5aafce1..e710f46 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -65,7 +65,7 @@ Once started batctl will display the list of announced gateways in the network.
 If no parameter is given the current originator interval setting is displayed otherwise the parameter is used to set the originator interval. The interval is in units of milliseconds.
 .br
 .IP "\fBloglevel\fP|\fBll\fP      [\fBlevel\fP]"
-If no parameter is given the current log level settings are displayed otherwise the parameter is used to set the log level. Level 0 disables all verbose logging. Level 1 enables messages related to routing / flooding / broadcasting. Level 2 enables messages related to route or hna added / changed / deleted. Level 3 enables all messages. The messages are sent to the batman-adv debug log. Use \fBbatctl log\fP to see them. Make sure to have debugging output enabled when compiling the module otherwise the output as well as the loglevel options won't be available.
+If no parameter is given the current log level settings are displayed otherwise the parameter is used to set the log level. Level 0 disables all verbose logging. Level 1 enables messages related to routing / flooding / broadcasting. Level 2 enables messages related to route or tt entry added / changed / deleted. Level 3 enables all messages. The messages are sent to the batman-adv debug log. Use \fBbatctl log\fP to see them. Make sure to have debugging output enabled when compiling the module otherwise the output as well as the loglevel options won't be available.
 .br
 .IP "\fBlog\fP|\fBl\fP            [\fB\-n\fP]\fP"
 batctl will read the batman-adv debug log which has to be compiled into the kernel module. If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output.
@@ -127,18 +127,18 @@ Display the soft\-interface neighbor table. batctl will refresh the list every s
 .IP "\fBvis_mode|vm\fP	  [\fBmode\fP]\fP"
 If no parameter is given the current vis mode is displayed otherwise the parameter is used to set the vis mode.
 .br
-.IP "\fBvis_data|vd dot\fP  [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-H\fP|\fB\-\-no-HNA\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
+.IP "\fBvis_data|vd dot\fP  [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-H\fP|\fB\-\-no-TT\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
 Display the visualisation data in graphviz \fBdot\fP(1) format. If
 "\-\-numbers" or "\-n" is given batctl will not replace the MAC
-addresses with bat-host names in the output. With "\-\-no-HNA" or
-"\-H" the HNA entries are not displayed, so the pure mesh topology can
+addresses with bat-host names in the output. With "\-\-no-T" or
+"\-T" the TT entries are not displayed, so the pure mesh topology can
 be seen. With "\-\-no-2nd" or "\-2" a dot cluster is not formed around
 primary and secondary addresses from the same device.
 .br
-.IP "\fBvis_data|vd json\fP [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-H\fP|\fB\-\-no-HNA\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
+.IP "\fBvis_data|vd json\fP [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-H\fP|\fB\-\-no-TT\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
 Display the visualisation data in JSON format. If "\-\-numbers" or
 "\-n" is given batctl will not replace the MAC addresses with bat-host
-names in the output. With "\-\-no-HNA" or "\-H" the HNA entries are
+names in the output. With "\-\-no-TT" or "\-T" the TT entries are
 not displayed, so the pure mesh topology can be seen. With
 "\-\-no-2nd" or "\-2" a dot cluster is not formed around primary and
 secondary addresses from the same device.
diff --git a/packet.h b/packet.h
index e757187..c225c3a 100644
--- a/packet.h
+++ b/packet.h
@@ -61,7 +61,7 @@ struct batman_packet {
 	uint8_t  orig[6];
 	uint8_t  prev_sender[6];
 	uint8_t  ttl;
-	uint8_t  num_hna;
+	uint8_t  num_tt;
 	uint8_t  gw_flags;  /* flags related to gateway class */
 	uint8_t  align;
 } __packed;
diff --git a/sys.c b/sys.c
index 3511b40..f8fa1f2 100644
--- a/sys.c
+++ b/sys.c
@@ -213,7 +213,7 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 	printf("[%c] %s (%d)\n", (line_ptr[0] == '1') ? 'x' : ' ',
 	       "messages related to routing / flooding / broadcasting", 1);
 	printf("[%c] %s (%d)\n", (line_ptr[0] == '2') ? 'x' : ' ',
-	       "messages related to route or hna added / changed / deleted", 2);
+	       "messages related to route or tt entry added / changed / deleted", 2);
 	printf("[%c] %s (%d)\n", (line_ptr[0] == '3') ? 'x' : ' ',
 	       "all debug messages", 3);
 
diff --git a/vis.c b/vis.c
index adb12d0..1a8d181 100644
--- a/vis.c
+++ b/vis.c
@@ -37,7 +37,7 @@
 #define TQ_MAX_VALUE 255
 
 typedef void (*print_tq_t) (char *orig, char *from, const long tq);
-typedef void (*print_HNA_t) (char *orig, char *from);
+typedef void (*print_TT_t) (char *orig, char *from);
 typedef void (*print_1st_t) (char *orig);
 typedef void (*print_2nd_t) (char *orig, char *from);
 typedef void (*print_header_t) (void);
@@ -45,22 +45,22 @@ typedef void (*print_footer_t) (void);
 
 struct funcs {
 	print_tq_t print_tq;
-	print_HNA_t print_HNA;
+	print_TT_t print_TT;
 	print_1st_t print_1st;
 	print_2nd_t print_2nd;
 	print_header_t print_header;
 	print_footer_t print_footer;
 };
 
-static bool with_HNA = true;
+static bool with_TT = true;
 static bool with_2nd = true;
 static bool with_names = true;
 
 static void usage(void)
 {
-	printf("batctl vis_data dot {-h}{--no-HNA|-H} {--no-2nd|-2} {--numbers|-n}\n");
+	printf("batctl vis_data dot {-h}{--no-TT|-T} {--no-2nd|-2} {--numbers|-n}\n");
 	printf("or\n");
-	printf("batctl vis_data json {-h}{--no-HNA|-H} {--no-2nd|-2} {--numbers|-n}\n");
+	printf("batctl vis_data json {-h}{--no-TT|-T} {--no-2nd|-2} {--numbers|-n}\n");
 }
 
 static void dot_print_tq(char *orig, char *from, const long tq)
@@ -75,11 +75,11 @@ static void dot_print_tq(char *orig, char *from, const long tq)
 	       int_part, frac_part);
 }
 
-static void dot_print_HNA(char *orig, char *from)
+static void dot_print_TT(char *orig, char *from)
 {
 	printf("\t\"%s\" -> ",
 	       get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
-	printf("\"%s\" [label=\"HNA\"]\n",
+	printf("\"%s\" [label=\"TT\"]\n",
 	       get_name_by_macstr(from, (with_names ? USE_BAT_HOSTS : 0)));
 }
 
@@ -114,7 +114,7 @@ static void dot_print_footer(void)
 }
 
 const struct funcs dot_funcs = { dot_print_tq,
-	dot_print_HNA,
+	dot_print_TT,
 	dot_print_1st,
 	dot_print_2nd,
 	dot_print_header,
@@ -133,11 +133,11 @@ static void json_print_tq(char *orig, char *from, const long tq)
 	       int_part, frac_part);
 }
 
-static void json_print_HNA(char *orig, char *from)
+static void json_print_TT(char *orig, char *from)
 {
 	printf("{ \"router\" : \"%s\", ",
 	       get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
-	printf("\"gateway\" : \"%s\", \"label\" : \"HNA\" }\n",
+	printf("\"gateway\" : \"%s\", \"label\" : \"TT\" }\n",
 	       get_name_by_macstr(from, (with_names ? USE_BAT_HOSTS : 0)));
 }
 
@@ -157,7 +157,7 @@ static void json_print_2nd(char *orig, char *from)
 }
 
 const struct funcs json_funcs = { json_print_tq,
-	json_print_HNA,
+	json_print_TT,
 	json_print_1st,
 	json_print_2nd,
 	NULL,
@@ -217,12 +217,12 @@ static int format(char *mesh_iface, const struct funcs *funcs)
 				funcs->print_tq(orig, from, tq);
 				continue;
 			}
-			if (!strcmp(flag, "HNA")) {
-				/* We have an HNA record */
-				if (!with_HNA)
+			if (!strcmp(flag, "TT")) {
+				/* We have a TT record */
+				if (!with_TT)
 					continue;
 				from = strtok_r(NULL, " ", &component_save_ptr);
-				funcs->print_HNA(orig, from);
+				funcs->print_TT(orig, from);
 				continue;
 			}
 			if (!strcmp(flag, "SEC") && with_2nd) {
@@ -274,19 +274,19 @@ int vis_data(char *mesh_iface, int argc, char *argv[])
 	while (1) {
 		int option_index = 0;
 		static struct option long_options[] = {
-			{"no-HNA", 0, 0, 'H'},
+			{"no-TT", 0, 0, 'T'},
 			{"no-2nd", 0, 0, '2'},
 			{"numbers", 0, 0, 'n'},
 			{0, 0, 0, 0}
 		};
 
-		c = getopt_long(argc, argv, "hH2n", long_options, &option_index);
+		c = getopt_long(argc, argv, "hT2n", long_options, &option_index);
 		if (c == -1)
 			break;
 
 		switch (c) {
-		case 'H':
-			with_HNA = false;
+		case 'T':
+			with_TT = false;
 			break;
 		case '2':
 			with_2nd = false;
-- 
1.7.3.4

