Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 3/4] batctl: ping: Get outgoing ifname from netlink
Date: Mon, 10 May 2021 15:07:33 +0200
Message-Id: <20210510130734.41080-3-sven@narfation.org>
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

There is no need to gather the interface name for an outgoing interface
via a different syscall(s) when the kernel directly provides this
information in the netlink message for this originator table entry.

batman-adv provides this functionality with Linux 5.14/batman-adv 2021.2.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 netlink.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/netlink.c b/netlink.c
index 31c9b01..4e616b6 100644
--- a/netlink.c
+++ b/netlink.c
@@ -728,9 +728,16 @@ static int get_nexthop_netlink_cb(struct nl_msg *msg, void *arg)
 
 	/* save result */
 	memcpy(opts->nexthop, neigh, ETH_ALEN);
-	ifname = if_indextoname(index, opts->ifname);
-	if (!ifname)
-		return NL_OK;
+
+	if (attrs[BATADV_ATTR_HARD_IFNAME]) {
+		ifname = nla_get_string(attrs[BATADV_ATTR_HARD_IFNAME]);
+		strncpy(opts->ifname, ifname, IFNAMSIZ);
+	} else {
+		/* compatibility for Linux < 5.14/batman-adv < 2021.2 */
+		ifname = if_indextoname(index, opts->ifname);
+		if (!ifname)
+			return NL_OK;
+	}
 
 	opts->found = true;
 	opts->query_opts.err = 0;
-- 
2.30.2

