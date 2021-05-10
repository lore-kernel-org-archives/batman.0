Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 1/4] batctl: originators: Get outgoing ifname from netlink
Date: Mon, 10 May 2021 15:07:31 +0200
Message-Id: <20210510130734.41080-1-sven@narfation.org>
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
 originators.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/originators.c b/originators.c
index 8a29dd7..11ca4b9 100644
--- a/originators.c
+++ b/originators.c
@@ -40,12 +40,14 @@ static int originators_callback(struct nl_msg *msg, void *arg)
 	struct nlmsghdr *nlh = nlmsg_hdr(msg);
 	int last_seen_msecs, last_seen_secs;
 	struct print_opts *opts = arg;
+	char ifname_buf[IF_NAMESIZE];
 	struct bat_host *bat_host;
 	struct genlmsghdr *ghdr;
-	char ifname[IF_NAMESIZE];
+	uint32_t ifindex;
 	float last_seen;
 	uint8_t *neigh;
 	uint8_t *orig;
+	char *ifname;
 	char c = ' ';
 	uint8_t tq;
 
@@ -74,9 +76,16 @@ static int originators_callback(struct nl_msg *msg, void *arg)
 	orig = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
 	neigh = nla_data(attrs[BATADV_ATTR_NEIGH_ADDRESS]);
 
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
 
 	if (attrs[BATADV_ATTR_FLAG_BEST])
 		c = '*';
-- 
2.30.2

