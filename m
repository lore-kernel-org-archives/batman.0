Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  9 Feb 2019 14:42:04 +0100
Message-Id: <20190209134222.15035-3-sven@narfation.org>
In-Reply-To: <20190209134222.15035-1-sven@narfation.org>
References: <20190209134222.15035-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v5 02/20] batctl: Don't allocate new buffer
 for vlan parent device
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

The buffer size is limited by IF_NAMESIZE and can easily be stored on the
stack. This will also make it easier to store this as part of the the state
of batctl.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 23 ++++++-----------------
 functions.h |  2 +-
 sys.c       |  6 +++---
 3 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/functions.c b/functions.c
index 98dea77..aeebebf 100644
--- a/functions.c
+++ b/functions.c
@@ -798,10 +798,6 @@ static int vlan_get_link_parse(struct nl_msg *msg, void *arg)
 
 	/* get parent link name */
 	idx = *(int *)nla_data(tb[IFLA_LINK]);
-	free(nl_arg->iface);
-	nl_arg->iface = malloc(IFNAMSIZ + 1);
-	if (!nl_arg->iface)
-		goto err;
 
 	if (!if_indextoname(idx, nl_arg->iface))
 		goto err;
@@ -819,12 +815,12 @@ static int vlan_get_link_parse(struct nl_msg *msg, void *arg)
 /**
  * vlan_get_link - convert a VLAN interface into its parent one
  * @ifname: the interface to convert
- * @parent: buffer where the parent interface name will be written (allocated by
- *  this function)
+ * @parent: buffer where the parent interface name will be written
+ *  (minimum IF_NAMESIZE)
  *
  * Returns the vlan identifier on success or -1 on error
  */
-int vlan_get_link(const char *ifname, char **parent)
+int vlan_get_link(const char *ifname, char *parent)
 {
 	struct nl_sock *sock;
 	int ret;
@@ -834,12 +830,10 @@ int vlan_get_link(const char *ifname, char **parent)
 	};
 	struct nl_cb *cb = NULL;
 	struct vlan_get_link_nl_arg arg = {
-		.iface = NULL,
+		.iface = parent,
 		.vid = -1,
 	};
 
-	*parent = NULL;
-
 	sock = nl_socket_alloc();
 	if (!sock)
 		goto err;
@@ -862,8 +856,6 @@ int vlan_get_link(const char *ifname, char **parent)
 	if (ret < 0)
 		goto err;
 
-	*parent = arg.iface;
-
 err:
 	if (cb)
 		nl_cb_put(cb);
@@ -997,13 +989,13 @@ int netlink_simple_request(struct nl_msg *msg)
 
 int check_mesh_iface(char *mesh_iface)
 {
-	char *base_dev = NULL;
 	char path_buff[PATH_BUFF_LEN];
+	char base_dev[IF_NAMESIZE];
 	int ret = -1, vid;
 	DIR *dir;
 
 	/* use the parent interface if this is a VLAN */
-	vid = vlan_get_link(mesh_iface, &base_dev);
+	vid = vlan_get_link(mesh_iface, base_dev);
 	if (vid >= 0)
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_VLAN_PATH, base_dev, vid);
 	else
@@ -1018,9 +1010,6 @@ int check_mesh_iface(char *mesh_iface)
 
 	ret = 0;
 out:
-	if (base_dev)
-		free(base_dev);
-
 	return ret;
 }
 
diff --git a/functions.h b/functions.h
index a7ae1eb..a38d5f8 100644
--- a/functions.h
+++ b/functions.h
@@ -48,7 +48,7 @@ int write_file(const char *dir, const char *fname, const char *arg1,
 struct ether_addr *translate_mac(const char *mesh_iface,
 				 const struct ether_addr *mac);
 struct ether_addr *resolve_mac(const char *asc);
-int vlan_get_link(const char *ifname, char **parent);\
+int vlan_get_link(const char *ifname, char *parent);
 int query_rtnl_link(int ifindex, nl_recvmsg_msg_cb_t func, void *arg);
 int netlink_simple_request(struct nl_msg *msg);
 int check_mesh_iface(char *mesh_iface);
diff --git a/sys.c b/sys.c
index 27da5b9..bf2720b 100644
--- a/sys.c
+++ b/sys.c
@@ -67,7 +67,8 @@ int handle_sys_setting(struct state *state, int argc, char **argv)
 {
 	struct settings_data *settings = state->cmd->arg;
 	int vid, optchar, res = EXIT_FAILURE;
-	char *path_buff, *base_dev = NULL;
+	char base_dev[IF_NAMESIZE];
+	char *path_buff;
 	const char **ptr;
 
 	while ((optchar = getopt(argc, argv, "h")) != -1) {
@@ -93,7 +94,7 @@ int handle_sys_setting(struct state *state, int argc, char **argv)
 	/* if the specified interface is a VLAN then change the path to point
 	 * to the proper "vlan%{vid}" subfolder in the sysfs tree.
 	 */
-	vid = vlan_get_link(state->mesh_iface, &base_dev);
+	vid = vlan_get_link(state->mesh_iface, base_dev);
 	if (vid >= 0)
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_VLAN_PATH, base_dev, vid);
 
@@ -133,6 +134,5 @@ int handle_sys_setting(struct state *state, int argc, char **argv)
 
 out:
 	free(path_buff);
-	free(base_dev);
 	return res;
 }
-- 
2.20.1

