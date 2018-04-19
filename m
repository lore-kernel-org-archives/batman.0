Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 19 Apr 2018 20:14:20 +0200
Message-Id: <20180419181420.3167-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Don't translate multicast and zero
 mac addresses
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

The IP to mac translation code already skips zero and multicast mac
addressses because there might be multiple entries in the global
translation table which would match this entry. There is no "best" entry
originator for such an entry and such the result is basically a random
pick.

Translating such an input mac address (from ping/traceoute/translate) to a
single originator address is therefore not appropriate.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/functions.c b/functions.c
index 3c340a2..e0e9978 100644
--- a/functions.c
+++ b/functions.c
@@ -194,6 +194,19 @@ static int str_is_mcast_addr(char *addr)
 		mac_addr->ether_addr_octet[0] & 0x01;
 }
 
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
 int read_file(const char *dir, const char *fname, int read_opt,
 	      float orig_timeout, float watch_interval, size_t header_lines)
 {
@@ -475,6 +488,9 @@ struct ether_addr *translate_mac(const char *mesh_iface,
 	memcpy(&out_mac, mac, sizeof(out_mac));
 	mac_result = &out_mac;
 
+	if (!ether_addr_valid(in_mac.ether_addr_octet))
+		return mac_result;
+
 	ret = translate_mac_netlink(mesh_iface, &in_mac, mac_result);
 
 	if (ret == -EOPNOTSUPP)
@@ -571,19 +587,6 @@ static struct nla_policy neigh_policy[NDA_MAX+1] = {
 	[NDA_PROBES]    = { .type = NLA_U32 },
 };
 
-static bool ether_addr_valid(const uint8_t *addr)
-{
-	/* no multicast address */
-	if (addr[0] & 0x01)
-		return false;
-
-	/* no zero address */
-	if ((addr[0] | addr[1] | addr[2] | addr[3] | addr[4] | addr[5]) == 0)
-		return false;
-
-	return true;
-}
-
 static int resolve_mac_from_parse(struct nl_msg *msg, void *arg)
 {
 	struct nlattr *tb[NDA_MAX + 1];
-- 
2.17.0

