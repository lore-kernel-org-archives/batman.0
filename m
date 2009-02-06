From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri,  6 Feb 2009 19:00:26 +0100
Message-Id: <1233943226-24592-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <200901140236.58441.sven.eckelmann@gmx.de>
References: <200901140236.58441.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Add bsd-stubs for nat functionality
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/bsd/tun.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/batman/bsd/tun.c b/batman/bsd/tun.c
index b44dac3..3e75c4c 100644
--- a/batman/bsd/tun.c
+++ b/batman/bsd/tun.c
@@ -89,6 +89,20 @@ static int open_tun_any(char *dev_name, size_t dev_name_size)
 }
 #endif
 
+/* Probe for iptables binary availability */
+int probe_nat_tool(void) {
+	fprintf(stderr, "probe_nat_tool: not implemented\n");
+	return -1;
+}
+
+void add_nat_rule(char *BATMANUNUSED(dev)) {
+	fprintf(stderr, "add_nat_rule: not implemented\n");
+}
+
+void del_nat_rule(char *BATMANUNUSED(dev)) {
+	fprintf(stderr, "del_nat_rule: not implemented\n");
+}
+
 /* Probe for tun interface availability */
 int8_t probe_tun(uint8_t BATMANUNUSED(print_to_stderr))
 {
-- 
1.6.0.6

