Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 4/4] batctl: event: Get ifname from netlink message
Date: Mon, 10 May 2021 15:07:34 +0200
Message-Id: <20210510130734.41080-4-sven@narfation.org>
In-Reply-To: <20210510130734.41080-1-sven@narfation.org>
References: <20210510130734.41080-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Sven Eckelmann <sven@narfation.org>

There is no need to gather the interface name for an interface via a
different syscall(s) when the kernel directly provides this information in
the netlink message for this event.

batman-adv provides this functionality with Linux 5.14/batman-adv 2021.2.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 event.c | 52 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/event.c b/event.c
index 955fe11..274f99f 100644
--- a/event.c
+++ b/event.c
@@ -174,10 +174,15 @@ static void event_parse_set_mesh(struct nlattr **attrs)
 				    ARRAY_SIZE(mesh_mandatory)))
 		return;
 
-	mesh_ifindex = nla_get_u32(attrs[BATADV_ATTR_MESH_IFINDEX]);
-	meshif_name = if_indextoname(mesh_ifindex, meshif_buf);
-	if (!meshif_name)
-		return;
+	if (attrs[BATADV_ATTR_MESH_IFNAME]) {
+		meshif_name = nla_get_string(attrs[BATADV_ATTR_MESH_IFNAME]);
+	} else {
+		/* compatibility for Linux < 5.14/batman-adv < 2021.2 */
+		mesh_ifindex = nla_get_u32(attrs[BATADV_ATTR_MESH_IFINDEX]);
+		meshif_name = if_indextoname(mesh_ifindex, meshif_buf);
+		if (!meshif_name)
+			return;
+	}
 
 	printf("%s: set mesh:\n", meshif_name);
 
@@ -305,15 +310,25 @@ static void event_parse_set_hardif(struct nlattr **attrs)
 				    ARRAY_SIZE(hardif_mandatory)))
 		return;
 
-	mesh_ifindex = nla_get_u32(attrs[BATADV_ATTR_MESH_IFINDEX]);
-	meshif_name = if_indextoname(mesh_ifindex, meshif_buf);
-	if (!meshif_name)
-		return;
+	if (attrs[BATADV_ATTR_MESH_IFNAME]) {
+		meshif_name = nla_get_string(attrs[BATADV_ATTR_MESH_IFNAME]);
+	} else {
+		/* compatibility for Linux < 5.14/batman-adv < 2021.2 */
+		mesh_ifindex = nla_get_u32(attrs[BATADV_ATTR_MESH_IFINDEX]);
+		meshif_name = if_indextoname(mesh_ifindex, meshif_buf);
+		if (!meshif_name)
+			return;
+	}
 
-	hardif_ifindex = nla_get_u32(attrs[BATADV_ATTR_HARD_IFINDEX]);
-	hardif_name = if_indextoname(hardif_ifindex, hardif_buf);
-	if (!hardif_name)
-		return;
+	if (attrs[BATADV_ATTR_MESH_IFNAME]) {
+		hardif_name = nla_get_string(attrs[BATADV_ATTR_HARD_IFNAME]);
+	} else {
+		/* compatibility for Linux < 5.14/batman-adv < 2021.2 */
+		hardif_ifindex = nla_get_u32(attrs[BATADV_ATTR_HARD_IFINDEX]);
+		hardif_name = if_indextoname(hardif_ifindex, hardif_buf);
+		if (!hardif_name)
+			return;
+	}
 
 	printf("%s (%s): set hardif:\n", meshif_name, hardif_name);
 
@@ -350,10 +365,15 @@ static void event_parse_set_vlan(struct nlattr **attrs)
 				    ARRAY_SIZE(vlan_mandatory)))
 		return;
 
-	mesh_ifindex = nla_get_u32(attrs[BATADV_ATTR_MESH_IFINDEX]);
-	meshif_name = if_indextoname(mesh_ifindex, meshif_buf);
-	if (!meshif_name)
-		return;
+	if (attrs[BATADV_ATTR_MESH_IFNAME]) {
+		meshif_name = nla_get_string(attrs[BATADV_ATTR_MESH_IFNAME]);
+	} else {
+		/* compatibility for Linux < 5.14/batman-adv < 2021.2 */
+		mesh_ifindex = nla_get_u32(attrs[BATADV_ATTR_MESH_IFINDEX]);
+		meshif_name = if_indextoname(mesh_ifindex, meshif_buf);
+		if (!meshif_name)
+			return;
+	}
 
 	vid = nla_get_u16(attrs[BATADV_ATTR_VLANID]);
 
-- 
2.30.2

