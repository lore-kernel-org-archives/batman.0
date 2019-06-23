Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH v2 6/6] batctl: Allow to omit explicit prefix name
Date: Sun, 23 Jun 2019 15:07:09 +0200
Message-Id: <20190623130709.24751-7-sven@narfation.org>
In-Reply-To: <20190623130709.24751-1-sven@narfation.org>
References: <20190623130709.24751-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

batctl allows three types of netdev based prefixes

* meshif <netdev>
* vlan <vdev>
* hardif <netdev>

The first word is used to tell batctl that the netdev is expected to be of
a specific type and all further information should be parsed in context of
this specific type. This avoids ambiguity when parsing the command line
information.

But there are various situations when there is no ambiguity at all. For all
of them, following points are true:

* <netdev|vdev> exists
* <netdev|vdev> has not the name of any existing batctl subcommand
* <netdev|vdev> is not "vlan", "vid", "hardif", "slave", "meshif" or "dev

In these situations, the first word can be omitted and batctl can guess the
type automatically.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 36 +++++++++++++++++++++++++++++++++---
 functions.h |  3 +++
 main.c      | 28 +++++++++++++++++++++++++++-
 3 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/functions.c b/functions.c
index 4ffa86c..69d063e 100644
--- a/functions.c
+++ b/functions.c
@@ -1020,11 +1020,11 @@ int translate_hard_iface(struct state *state, const char *hardif)
 	return 0;
 }
 
-static int check_mesh_iface_netlink(struct state *state)
+static int check_mesh_iface_netlink(unsigned int ifindex)
 {
 	struct rtnl_link_iface_data link_data;
 
-	query_rtnl_link_single(state->mesh_ifindex, &link_data);
+	query_rtnl_link_single(ifindex, &link_data);
 	if (!link_data.kind_found)
 		return -1;
 
@@ -1034,6 +1034,36 @@ static int check_mesh_iface_netlink(struct state *state)
 	return 0;
 }
 
+int guess_netdev_type(const char *netdev, enum selector_prefix *type)
+{
+	struct rtnl_link_iface_data link_data;
+	unsigned int netdev_ifindex;
+
+	netdev_ifindex = if_nametoindex(netdev);
+	if (netdev_ifindex == 0)
+		return -ENODEV;
+
+	query_rtnl_link_single(netdev_ifindex, &link_data);
+
+	if (link_data.kind_found && strcmp(link_data.kind, "batadv") == 0) {
+		*type = SP_MESHIF;
+		return 0;
+	}
+
+	if (link_data.master_found &&
+	    check_mesh_iface_netlink(link_data.master) >= 0) {
+		*type = SP_HARDIF;
+		return 0;
+	}
+
+	if (link_data.kind_found && strcmp(link_data.kind, "vlan") == 0) {
+		*type = SP_VLAN;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static int check_mesh_iface_sysfs(struct state *state)
 {
 	char path_buff[PATH_BUFF_LEN];
@@ -1060,7 +1090,7 @@ int check_mesh_iface(struct state *state)
 	if (state->mesh_ifindex == 0)
 		return -1;
 
-	ret = check_mesh_iface_netlink(state);
+	ret = check_mesh_iface_netlink(state->mesh_ifindex);
 	if (ret == 0)
 		return ret;
 
diff --git a/functions.h b/functions.h
index 0a08870..31806d4 100644
--- a/functions.h
+++ b/functions.h
@@ -16,6 +16,8 @@
 #include <stddef.h>
 #include <stdint.h>
 
+#include "main.h"
+
 /**
  * enum batadv_bandwidth_units - bandwidth unit types
  */
@@ -54,6 +56,7 @@ int translate_mesh_iface_vlan(struct state *state, const char *vlandev);
 int translate_vlan_iface(struct state *state, const char *vlandev);
 int translate_vid(struct state *state, const char *vidstr);
 int translate_hard_iface(struct state *state, const char *hardif);
+int guess_netdev_type(const char *netdev, enum selector_prefix *type);
 int get_algoname(const char *mesh_iface, char *algoname, size_t algoname_len);
 int check_mesh_iface(struct state *state);
 int check_mesh_iface_ownership(struct state *state, char *hard_iface);
diff --git a/main.c b/main.c
index eddc2ad..8a87f28 100644
--- a/main.c
+++ b/main.c
@@ -206,6 +206,32 @@ static int detect_selector_prefix(int argc, char *argv[],
 	return 0;
 }
 
+static int guess_selector_prefix(int argc, char *argv[],
+				 enum selector_prefix *selector)
+{
+	int ret;
+
+	/* check if there is a direct hit with full prefix */
+	ret = detect_selector_prefix(argc, argv, selector);
+	if (ret > 0)
+		return ret;
+
+	/* not enough remaining arguments to detect anything */
+	if (argc < 1)
+		return -EINVAL;
+
+	/* don't try to parse subcommand names as network interface */
+	if (find_command_by_types(0xffffffff, argv[0]))
+		return -EEXIST;
+
+	/* check if it is a netdev - and if it exists, try to guess what kind */
+	ret = guess_netdev_type(argv[0], selector);
+	if (ret < 0)
+		return ret;
+
+	return 1;
+}
+
 static int parse_meshif_args(struct state *state, int argc, char *argv[])
 {
 	enum selector_prefix selector;
@@ -213,7 +239,7 @@ static int parse_meshif_args(struct state *state, int argc, char *argv[])
 	char *dev_arg;
 	int ret;
 
-	parsed_args = detect_selector_prefix(argc, argv, &selector);
+	parsed_args = guess_selector_prefix(argc, argv, &selector);
 	if (parsed_args < 1)
 		goto fallback_meshif_vlan;
 
-- 
2.20.1

