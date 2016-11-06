Return-Path: <jj@jjsarton.de>
From: Jean-Jacques Sarton <jj.sarton@t-online.de>
Date: Sun,  6 Nov 2016 11:16:34 +0100
Message-Id: <1478427394-11607-1-git-send-email-jj.sarton@t-online.de>
Subject: [B.A.T.M.A.N.] [[PATCH] Alfred not working within network name
	space add static to function declaration
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

Fix scope of function to static

Signed-off-by: Jean-Jacques Sarton <jj.sarton@t-online.de>
---
 batadv_query.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/batadv_query.c b/batadv_query.c
index dc8a042..69f5a48 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -136,7 +136,7 @@ int ipv6_to_mac(const struct in6_addr *addr, struct ether_addr *mac)
 	return 0;
 }
 
-int batadv_interface_check_debugfs(const char *mesh_iface)
+static int batadv_interface_check_debugfs(const char *mesh_iface)
 {
 	char full_path[MAX_PATH + 1];
 	FILE *f;
-- 
2.7.4

