Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  5 Jun 2016 20:47:07 +0200
Message-Id: <1465152428-17299-9-git-send-email-sven@narfation.org>
In-Reply-To: <1465152428-17299-1-git-send-email-sven@narfation.org>
References: <1465152428-17299-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 09/10] alfred: vis: Save device index in
	interface list
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

The netlink messages don't contain the complete names. Instead the device
indexes are used. To avoid extra overhead of retrieving the device name for
each index, the interface list can just be used again as cache by making it
queryable via the ifindex.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 vis/vis.c | 13 ++++++++++---
 vis/vis.h |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/vis/vis.c b/vis/vis.c
index 7eab781..bac451b 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -125,9 +125,10 @@ static int get_if_mac(char *ifname, uint8_t *mac)
 	return 0;
 }
 
-static int get_if_index(struct globals *globals, char *ifname)
+static int get_if_index_byname(struct globals *globals, char *ifname)
 {
 	struct iface_list_entry *i_entry;
+	int devindex;
 	int i;
 
 	if (!ifname)
@@ -139,6 +140,11 @@ static int get_if_index(struct globals *globals, char *ifname)
 			return i;
 		i++;
 	}
+
+	devindex = if_nametoindex(ifname);
+	if (!devindex)
+		return -1;
+
 	i_entry = malloc(sizeof(*i_entry));
 	if (!i_entry)
 		return -1;
@@ -148,6 +154,7 @@ static int get_if_index(struct globals *globals, char *ifname)
 		return -1;
 	}
 
+	i_entry->devindex = devindex;
 	strncpy(i_entry->name, ifname, sizeof(i_entry->name));
 	/* just to be safe ... */
 	i_entry->name[sizeof(i_entry->name) - 1] = 0;
@@ -301,7 +308,7 @@ static int register_interfaces(struct globals *globals)
 			*content_newline = '\0';
 
 		if (strcmp(file_content, "active") == 0)
-			get_if_index(globals, iface_dir->d_name);
+			get_if_index_byname(globals, iface_dir->d_name);
 
 free_line:
 		free(file_content);
@@ -364,7 +371,7 @@ static int parse_orig_list(struct globals *globals)
 				if (!mac)
 					continue;
 
-				ifindex = get_if_index(globals, iface);
+				ifindex = get_if_index_byname(globals, iface);
 				if (ifindex < 0)
 					continue;
 
diff --git a/vis/vis.h b/vis/vis.h
index 4c98064..c25a75b 100644
--- a/vis/vis.h
+++ b/vis/vis.h
@@ -77,6 +77,7 @@ struct vis_v1 {
 struct iface_list_entry {
 	char name[256];
 	uint8_t mac[ETH_ALEN];
+	int devindex;
 	struct list_head list;
 };
 
-- 
2.8.1

