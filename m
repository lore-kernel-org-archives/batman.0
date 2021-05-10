Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 2/4] batctl: neighbors: Get outgoing ifname from netlink
Date: Mon, 10 May 2021 15:07:32 +0200
Message-Id: <20210510130734.41080-2-sven@narfation.org>
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
information in the netlink message for this neighbor table entry.

batman-adv provides this functionality with Linux 5.14/batman-adv 2021.2.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 neighbors.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/neighbors.c b/neighbors.c
index af76d0f..3102b0e 100644
--- a/neighbors.c
+++ b/neighbors.c
@@ -36,10 +36,12 @@ static int neighbors_callback(struct nl_msg *msg, void *arg)
 	struct nlmsghdr *nlh = nlmsg_hdr(msg);
 	int last_seen_msecs, last_seen_secs;
 	struct print_opts *opts = arg;
+	char ifname_buf[IF_NAMESIZE];
 	struct bat_host *bat_host;
-	char ifname[IF_NAMESIZE];
 	struct genlmsghdr *ghdr;
+	uint32_t ifindex;
 	uint8_t *neigh;
+	char *ifname;
 
 	if (!genlmsg_valid_hdr(nlh, 0)) {
 		fputs("Received invalid data from kernel.\n", stderr);
@@ -66,9 +68,16 @@ static int neighbors_callback(struct nl_msg *msg, void *arg)
 	neigh = nla_data(attrs[BATADV_ATTR_NEIGH_ADDRESS]);
 	bat_host = bat_hosts_find_by_mac((char *)neigh);
 
-	if (!if_indextoname(nla_get_u32(attrs[BATADV_ATTR_HARD_IFINDEX]),
-			    ifname))
-		ifname[0] = '\0';
+	if (attrs[BATADV_ATTR_HARD_IFNAME]) {
+		ifname = nla_get_string(attrs[BATADV_ATTR_HARD_IFNAME]);
+	} else {
+		/* compatibility for Linux < 5.14/batman-adv < 2021.2 */
+		ifindex = nla_get_u32(attrs[BATADV_ATTR_HARD_IFINDEX]);
+		if (!if_indextoname(ifindex, ifname_buf))
+			ifname_buf[0] = '\0';
+
+		ifname = ifname_buf;
+	}
 
 	last_seen_msecs = nla_get_u32(attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
 	last_seen_secs = last_seen_msecs / 1000;
-- 
2.30.2

