Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] alfred: Ensure processed change_iface packet is 0-terminated
Date: Sat, 19 Feb 2022 08:54:24 +0100
Message-Id: <20220219075424.802930-1-sven@narfation.org>
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

A client sending a alfred_change_interface_v0 packet to the alfred server
might have forgotten to 0-terminate the string. In this case, strstr in
unix_sock_change_iface might read outside of the available buffer.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 unix_sock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/unix_sock.c b/unix_sock.c
index bc39199..8c2b762 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -329,6 +329,8 @@ unix_sock_change_iface(struct globals *globals,
 	if (len < (int)(sizeof(*change_iface) - sizeof(change_iface->header)))
 		goto err;
 
+	change_iface->ifaces[sizeof(change_iface->ifaces) - 1] = '\0';
+
 	if (globals->opmode == OPMODE_SECONDARY) {
 		if (strstr(change_iface->ifaces, ",") != NULL) {
 			ret = -EINVAL;
-- 
2.30.2

