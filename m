Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed,  2 Oct 2013 18:26:26 +0200
Message-Id: <1380731186-17923-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCHv1 RFC] Add an output format which is json
	conformant.
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
To: siwu@hrz.tu-chmnitz.de, sven@open-mesh.com
Cc: Janne.Paatero@ruag.com, b.a.t.m.a.n@lists.open-mesh.org

The current json output consists of individual lines which are json
conformant, but there is no conformancy between lines. Add a new
output format, which as a whole is json conformant.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 README    |  41 ++++++++-
 vis/vis.c | 296 ++++++++++++++++++++++++++++++++++++++++++++++++++------------
 vis/vis.h |   3 +-
 3 files changed, 284 insertions(+), 56 deletions(-)

diff --git a/README b/README
index 50c36ad..29f675c 100644
--- a/README
+++ b/README
@@ -152,7 +152,7 @@ digraph {
 [...]
 }
 
-For a json formatted output, use:
+For a json like formatted output, use:
 
  $ batadv-vis -f json
 { "primary" : "fe:f0:00:00:04:01" }
@@ -169,6 +169,45 @@ For a json formatted output, use:
 { "primary" : "fe:f0:00:00:08:01" }
 [...]
 
+and for conformant json output, use:
+
+ $ batadv-vis -f cjson
+[
+  { "primary" : "fe:f0:00:00:04:01",
+    "neighbors" : [
+       { "router" : "fe:f0:00:00:04:01",
+         "neighbor" : "fe:f0:00:00:05:01",
+         "metric" : "1.000" },
+       { "router" : "fe:f0:00:00:04:01",
+         "neighbor" : "fe:f0:00:00:03:01",
+         "metric" : "1.008" }
+    ],
+    "clients" : [
+       "00:00:43:05:00:04",
+       "fe:f1:00:00:04:01"
+    ]
+  },
+  { "primary" : "fe:f0:00:00:02:01",
+    "neighbors" : [
+       { "router" : "fe:f0:00:00:02:01",
+         "neighbor" : "fe:f0:00:00:03:01",
+	 "metric" : "1.000" },
+       { "router" : "fe:f0:00:00:02:01",
+         "neighbor" : "fe:f0:00:00:01:01",
+         "metric" : "1.016" },
+       { "router" : "fe:f0:00:00:02:01",
+         "neighbor" : "fe:f0:00:00:08:01",
+         "metric" : "1.000" }
+    ],
+    "clients" : [
+      "fe:f1:00:00:02:01",
+      "00:00:43:05:00:02"
+    ]
+  },
+  { "primary" : "fe:f0:00:00:08:01",
+[...]
+
+
 License
 -------
 
diff --git a/vis/vis.c b/vis/vis.c
index ad7f530..7e401c9 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -26,6 +26,7 @@
 #include <linux/if.h>
 #include <netinet/in.h>
 #include <signal.h>
+#include <stdbool.h>
 #include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -511,18 +512,248 @@ static struct vis_v1 *vis_receive_answer_packet(int sock, uint16_t *len)
 	return (struct vis_v1 *) data->data;
 }
 
+static void vis_dot_preamble(void)
+{
+	printf("digraph {\n");
+}
+
+static void vis_dot_interfaces(uint8_t iface_n, struct vis_iface *ifaces)
+{
+	int i;
+
+	printf("\tsubgraph \"cluster_%s\" {\n", mac_to_str(ifaces[0].mac));
+	for (i = 0; i < iface_n; i++)
+		printf("\t\t\"%s\"%s\n", mac_to_str(ifaces[i].mac),
+		       i ? " [peripheries=2]":"");
+	printf("\t}\n");
+}
+
+static void vis_dot_entries(uint8_t entries_n, struct vis_entry *vis_entries,
+			    uint8_t iface_n, struct vis_iface *ifaces)
+{
+	int i;
+
+	for (i = 0; i < entries_n; i++) {
+		if (vis_entries[i].ifindex == 255) {
+			printf("\t\"%s\" ", mac_to_str(ifaces[0].mac));
+			printf("-> \"%s\" [label=\"TT\"]\n",
+			       mac_to_str(vis_entries[i].mac));
+		} else {
+			if (vis_entries[i].ifindex >= iface_n) {
+				fprintf(stderr, "ERROR: bad ifindex ...\n");
+				continue;
+			}
+			if (vis_entries[i].qual == 0) {
+				fprintf(stderr, "ERROR: quality = 0?\n");
+				continue;
+			}
+			printf("\t\"%s\" ",
+			       mac_to_str(ifaces[vis_entries[i].ifindex].mac));
+			printf("-> \"%s\" [label=\"%3.3f\"]\n",
+			       mac_to_str(vis_entries[i].mac),
+			       255.0 / ((float)vis_entries[i].qual));
+		}
+	}
+}
+
+static void vis_dot_postamble(void)
+{
+	printf("}\n");
+}
+
+static void vis_json_preamble(void)
+{
+}
+
+static void vis_json_interfaces(uint8_t iface_n, struct vis_iface *ifaces)
+{
+	int i;
+
+	printf("{ \"primary\" : \"%s\" }\n", mac_to_str(ifaces[0].mac));
+	for (i = 1; i < iface_n; i++) {
+		printf("{ \"secondary\" : \"%s\"", mac_to_str(ifaces[i].mac));
+		printf(", \"of\" : \"%s\" }\n", mac_to_str(ifaces[0].mac));
+	}
+}
+
+static void vis_json_entries(uint8_t entries_n, struct vis_entry *vis_entries,
+			     uint8_t iface_n, struct vis_iface *ifaces)
+{
+	int i;
+
+	for (i = 0; i < entries_n; i++) {
+		if (vis_entries[i].ifindex == 255) {
+			printf("{ \"router\" : \"%s\"",
+			       mac_to_str(ifaces[0].mac));
+			printf(", \"gateway\" : \"%s\", \"label\" : \"TT\" }\n",
+			       mac_to_str(vis_entries[i].mac));
+		} else {
+			if (vis_entries[i].ifindex >= iface_n) {
+				fprintf(stderr, "ERROR: bad ifindex ...\n");
+				continue;
+			}
+			if (vis_entries[i].qual == 0) {
+				fprintf(stderr, "ERROR: quality = 0?\n");
+				continue;
+			}
+			printf("{ \"router\" : \"%s\"",
+			       mac_to_str(ifaces[vis_entries[i].ifindex].mac));
+			printf(", \"neighbor\" : \"%s\", \"label\" : \"%3.3f\" }\n",
+			       mac_to_str(vis_entries[i].mac),
+			       255.0 / ((float)vis_entries[i].qual));
+		}
+	}
+}
+
+static void vis_json_postamble(void)
+{
+}
+
+static void vis_cjson_preamble(void)
+{
+	printf("[\n");
+}
+
+static void vis_cjson_interfaces(uint8_t iface_n, struct vis_iface *ifaces)
+{
+	int i;
+	static bool first_interface = true;
+
+	if (first_interface)
+		first_interface = false;
+	else
+		printf(",\n");
+
+	printf("  { \"primary\" : \"%s\",\n", mac_to_str(ifaces[0].mac));
+	if (iface_n > 1) {
+		printf("    \"secondary\" : [ ");
+		for (i = 1; i < iface_n; i++) {
+			printf("\"%s\"", mac_to_str(ifaces[i].mac));
+			if ( i < iface_n - 1)
+				printf(",");
+		}
+		printf("\n     ],\n");
+	}
+}
+
+static void vis_cjson_entries(uint8_t entries_n, struct vis_entry *vis_entries,
+			      uint8_t iface_n, struct vis_iface *ifaces)
+{
+	bool first_neighbor = true;
+	bool first_tt = true;
+	int i;
+
+	printf("    \"neighbors\" : [\n");
+
+	for (i = 0; i < entries_n; i++) {
+		if (vis_entries[i].ifindex == 255) {
+			continue;
+		}
+
+		if (vis_entries[i].ifindex >= iface_n) {
+			fprintf(stderr, "ERROR: bad ifindex ...\n");
+			continue;
+		}
+		if (vis_entries[i].qual == 0) {
+			fprintf(stderr, "ERROR: quality = 0?\n");
+			continue;
+		}
+
+		if (first_neighbor)
+			first_neighbor = false;
+		else
+			printf(",\n");
+
+		printf("       { \"router\" : \"%s\",\n",
+		       mac_to_str(ifaces[vis_entries[i].ifindex].mac));
+		printf("         \"neighbor\" : \"%s\",\n",
+		       mac_to_str(vis_entries[i].mac));
+		printf("         \"metric\" : \"%3.3f\" }",
+		       255.0 / ((float)vis_entries[i].qual));
+	}
+
+	printf("\n    ],\n");
+
+	printf("    \"clients\" : [\n");
+
+	for (i = 0; i < entries_n; i++) {
+		if (vis_entries[i].ifindex == 255) {
+			if (first_tt)
+				first_tt = false;
+			else
+				printf(",\n");
+
+			printf("      \"%s\"", mac_to_str(vis_entries[i].mac));
+		}
+	}
+	printf("\n    ]\n");
+	printf("  }");
+}
+
+static void vis_cjson_postamble(void)
+{
+	printf("\n]\n");
+}
+
+struct vis_print_ops
+{
+	void (*preamble)(void);
+	void (*interfaces)(uint8_t iface_n, struct vis_iface *ifaces);
+	void (*entries)(uint8_t entries_n, struct vis_entry *vis_entries,
+			uint8_t iface_n, struct vis_iface *ifaces);
+	void (*postamble)(void);
+};
+
+static const struct vis_print_ops vis_dot_ops =
+{
+	vis_dot_preamble,
+	vis_dot_interfaces,
+	vis_dot_entries,
+	vis_dot_postamble
+};
+
+static const struct vis_print_ops vis_json_ops =
+{
+	vis_json_preamble,
+	vis_json_interfaces,
+	vis_json_entries,
+	vis_json_postamble
+};
+
+static const struct vis_print_ops vis_cjson_ops =
+{
+	vis_cjson_preamble,
+	vis_cjson_interfaces,
+	vis_cjson_entries,
+	vis_cjson_postamble
+};
+
 static int vis_read_answer(struct globals *globals)
 {
+	const struct vis_print_ops *ops;
 	struct vis_v1 *vis_data;
 	uint16_t len;
 	struct vis_iface *ifaces;
 	struct vis_entry *vis_entries;
-	int i;
 
-	if (globals->vis_format == FORMAT_DOT)
-		printf("digraph {\n");
+	switch (globals->vis_format) {
+	case FORMAT_DOT:
+		ops = &vis_dot_ops;
+		break;
+	case FORMAT_JSON:
+		ops = &vis_json_ops;
+		break;
+	case FORMAT_CJSON:
+		ops = &vis_cjson_ops;
+		break;
+	default:
+		return -1;
+	}
+
+	ops->preamble();
 
-	while ((vis_data = vis_receive_answer_packet(globals->unix_sock, &len)) != NULL) {
+	while ((vis_data =
+		vis_receive_answer_packet(globals->unix_sock, &len)) != NULL) {
 		if (len < sizeof(*vis_data))
 			return -1;
 
@@ -536,60 +767,15 @@ static int vis_read_answer(struct globals *globals)
 		ifaces = vis_data->ifaces;
 		vis_entries = (struct vis_entry *) &ifaces[vis_data->iface_n];
 
-		if (globals->vis_format == FORMAT_DOT) {
-			printf("\tsubgraph \"cluster_%s\" {\n", mac_to_str(ifaces[0].mac));
-			for (i = 0; i < vis_data->iface_n; i++)
-				printf("\t\t\"%s\"%s\n", mac_to_str(ifaces[i].mac),
-				       i ? " [peripheries=2]":"");
-			printf("\t}\n");
-		} else if (globals->vis_format == FORMAT_JSON) {
-			printf("{ \"primary\" : \"%s\" }\n", mac_to_str(ifaces[0].mac));
-			for (i = 1; i < vis_data->iface_n; i++) {
-				printf("{ \"secondary\" : \"%s\"", mac_to_str(ifaces[i].mac));
-				printf(", \"of\" : \"%s\" }\n", mac_to_str(ifaces[0].mac));
-			}
-		}
+		ops->interfaces(vis_data->iface_n, ifaces);
 
 		if (vis_data->entries_n == 0)
 			continue;
 
-                for (i = 0; i < vis_data->entries_n; i++) {
-			if (vis_entries[i].ifindex == 255) {
-				if (globals->vis_format == FORMAT_DOT) {
-					printf("\t\"%s\" ", mac_to_str(ifaces[0].mac));
-					printf("-> \"%s\" [label=\"TT\"]\n", mac_to_str(vis_entries[i].mac));
-				} else if (globals->vis_format == FORMAT_JSON) {
-					printf("{ \"router\" : \"%s\"", mac_to_str(ifaces[0].mac));
-					printf(", \"gateway\" : \"%s\", \"label\" : \"TT\" }\n", mac_to_str(vis_entries[i].mac));
-				}
-			} else {
-				if (vis_entries[i].ifindex >= vis_data->iface_n) {
-					fprintf(stderr, "ERROR: bad ifindex ...\n");
-					continue;
-				}
-				if (vis_entries[i].qual == 0) {
-					fprintf(stderr, "ERROR: quality = 0?\n");
-					continue;
-				}
-				if (globals->vis_format == FORMAT_DOT) {
-					printf("\t\"%s\" ",
-					       mac_to_str(ifaces[vis_entries[i].ifindex].mac));
-					printf("-> \"%s\" [label=\"%3.3f\"]\n",
-					       mac_to_str(vis_entries[i].mac),
-					       255.0 / ((float)vis_entries[i].qual));
-				} else if (globals->vis_format == FORMAT_JSON) {
-					printf("{ \"router\" : \"%s\"",
-					       mac_to_str(ifaces[vis_entries[i].ifindex].mac));
-					printf(", \"neighbor\" : \"%s\", \"label\" : \"%3.3f\" }\n",
-					       mac_to_str(vis_entries[i].mac),
-					       255.0 / ((float)vis_entries[i].qual));
-
-				}
-			}
-		}
+		ops->entries(vis_data->entries_n, vis_entries,
+			     vis_data->iface_n, ifaces);
 	}
-	if (globals->vis_format == FORMAT_DOT)
-		printf("}\n");
+	ops->postamble();
 
 	return 0;
 }
@@ -611,7 +797,7 @@ static void vis_usage(void)
 	printf("Usage: batadv-vis [options]\n");
 	printf("  -i, --interface             specify the batman-adv interface configured on the system (default: bat0)\n");
 	printf("  -s, --server                start up in server mode, which regularly updates vis data from batman-adv\n");
-	printf("  -f, --format <format>       specify the output format for client mode (either \"json\" or \"dot\")\n");
+	printf("  -f, --format <format>       specify the output format for client mode (either \"json\", \"cjson\" or \"dot\")\n");
 	printf("  -v, --version               print the version\n");
 	printf("  -h, --help                  this help\n");
 	printf("\n");
@@ -651,6 +837,8 @@ static struct globals *vis_init(int argc, char *argv[])
 				globals->vis_format = FORMAT_DOT;
 			else if (strncmp(optarg, "json", 4) == 0)
 				globals->vis_format = FORMAT_JSON;
+			else if (strncmp(optarg, "cjson", 5) == 0)
+				globals->vis_format = FORMAT_CJSON;
 			else {
 				vis_usage();
 				return NULL;
diff --git a/vis/vis.h b/vis/vis.h
index 6ba70c6..5d01ffd 100644
--- a/vis/vis.h
+++ b/vis/vis.h
@@ -49,7 +49,8 @@ enum opmode {
 
 enum vis_format {
 	FORMAT_DOT,
-	FORMAT_JSON
+	FORMAT_JSON,
+	FORMAT_CJSON,
 };
 
 struct vis_iface {
-- 
1.8.4.rc3

