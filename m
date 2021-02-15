Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 1/4] alfred: Show error message for invalid batadv interface
Date: Mon, 15 Feb 2021 21:01:23 +0100
Message-Id: <20210215200126.140253-1-sven@narfation.org>
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

The alfred server process always stopped without any informational message
when the provided batman-adv was not "none" and was not accessible. This
made it extremely hard to debug the reason why alfred directly stopped
after launching it.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 server.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/server.c b/server.c
index fc27246..efac5ad 100644
--- a/server.c
+++ b/server.c
@@ -385,8 +385,11 @@ int alfred_server(struct globals *globals)
 	}
 
 	if (strcmp(globals->mesh_iface, "none") != 0 &&
-	    batadv_interface_check(globals->mesh_iface) < 0)
+	    batadv_interface_check(globals->mesh_iface) < 0) {
+		fprintf(stderr, "Can't start server: batman-adv interface %s not found\n",
+			globals->mesh_iface);
 		return -1;
+	}
 
 	num_socks = netsock_open_all(globals);
 	if (num_socks <= 0) {
-- 
2.30.0

