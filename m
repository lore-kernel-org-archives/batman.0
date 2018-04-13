Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 13 Apr 2018 20:16:18 +0200
Message-Id: <20180413181618.24144-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Validate translated mac addresses
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
Cc: Sven Eckelmann <sven@narfation.org>, Andre Kasper <Andre.Kasper@gmx.de>

The IP translation layer is using the neighbor table of the kernel to get
the unicast link layer (mac) address for IP(v4|v6) addresses. The kernel
can not only return unicast mac addresses to such an RTM_GETNEIGH request
but also zero mac address. Such an address must be considered invalid
because the global translation table may not only contain a unique client
mac address entry for it. The translation from client mac to originator
will therefore most likely return an unexpected originator.

Dropping these kind of (bogus) results avoids confusions while using things
like batctl's ping or traceroute.

Reported-by: Andre Kasper <Andre.Kasper@gmx.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Andre Kasper <Andre.Kasper@gmx.de>

See https://www.open-mesh.org/issues/353
---
 functions.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/functions.c b/functions.c
index cd92b60..3c340a2 100644
--- a/functions.c
+++ b/functions.c
@@ -571,6 +571,19 @@ static struct nla_policy neigh_policy[NDA_MAX+1] = {
 	[NDA_PROBES]    = { .type = NLA_U32 },
 };
 
+static bool ether_addr_valid(const uint8_t *addr)
+{
+	/* no multicast address */
+	if (addr[0] & 0x01)
+		return false;
+
+	/* no zero address */
+	if ((addr[0] | addr[1] | addr[2] | addr[3] | addr[4] | addr[5]) == 0)
+		return false;
+
+	return true;
+}
+
 static int resolve_mac_from_parse(struct nl_msg *msg, void *arg)
 {
 	struct nlattr *tb[NDA_MAX + 1];
@@ -616,6 +629,9 @@ static int resolve_mac_from_parse(struct nl_msg *msg, void *arg)
 	mac = nla_data(tb[NDA_LLADDR]);
 	l3addr = nla_data(tb[NDA_DST]);
 
+	if (!ether_addr_valid(mac))
+		goto err;
+
 	if (memcmp(nl_arg->l3addr, l3addr, l3_len) == 0) {
 		memcpy(nl_arg->mac_result, mac, ETH_ALEN);
 		nl_arg->found = 1;
-- 
2.17.0

