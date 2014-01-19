Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Sun, 19 Jan 2014 16:01:04 +0100
Message-Id: <d48019225b19f19f5ac724d3b1a247cdf921f92b.1390143639.git.mschiffer@universe-factory.net>
Subject: [B.A.T.M.A.N.] [PATCH] batadv-vis: don't leak socket fd in
	get_if_mac()
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

Leaking an fd every time get_if_mac() is called causes a batadv-vis server
process to hit the open file limit in a matter of hours when it is as low as
1024 (which it is on OpenWRT).

Reported-by: Jan-Philipp Litza <janphilipp@litza.de>
Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 vis/vis.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/vis/vis.c b/vis/vis.c
index dcb4db4..7a8e780 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -96,7 +96,7 @@ static uint8_t *str_to_mac(char *str)
 static int get_if_mac(char *ifname, uint8_t *mac)
 {
 	struct ifreq ifr;
-	int sock;
+	int sock, ret;
 
 	strncpy(ifr.ifr_name, ifname, IFNAMSIZ);
 
@@ -105,7 +105,11 @@ static int get_if_mac(char *ifname, uint8_t *mac)
 		return -1;
 	}
 
-	if (ioctl(sock, SIOCGIFHWADDR, &ifr) == -1) {
+	ret = ioctl(sock, SIOCGIFHWADDR, &ifr);
+
+	close(sock);
+
+	if (ret == -1) {
 		fprintf(stderr, "can't get MAC address: %s\n", strerror(errno));
 		return -1;
 	}
-- 
1.8.5.3

