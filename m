Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 1/2] batctl: Only remove batadv interface on hardif reduction
Date: Sat, 13 Jun 2020 17:59:34 +0200
Message-Id: <20200613155935.8934-1-sven@narfation.org>
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
Cc: Sven Eckelmann <sven@narfation.org>, Matthias Schiffer <mschiffer@universe-factory.net>

A deletion of a hardif from a batadv meshif will also get a success reply
from the kernel when the hardif was never part of the batadv meshif. If the
batadv meshif had no attached hardifs before the removal was started, then
users are then not expecting that the batadv meshif is removed at all.

Since the delete operation is not an atomic compare-and-swap operation,
just check first the number of attached interfaces and only start the
removal of the batadv meshif when the number attached hardifs was reduced.

Fixes: 25022e0b154d ("batctl: Use rtnl to add/remove interfaces")
Reported-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 interface.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/interface.c b/interface.c
index 1cd6ede..ac4d883 100644
--- a/interface.c
+++ b/interface.c
@@ -386,6 +386,7 @@ static int interface(struct state *state, int argc, char **argv)
 	int ret;
 	unsigned int ifindex;
 	unsigned int ifmaster;
+	unsigned int pre_cnt;
 	const char *long_op;
 	unsigned int cnt;
 	int rest_argc;
@@ -502,6 +503,8 @@ static int interface(struct state *state, int argc, char **argv)
 		goto err;
 	}
 
+	pre_cnt = count_interfaces(state->mesh_iface);
+
 	for (i = 1; i < rest_argc; i++) {
 		ifindex = if_nametoindex(rest_argv[i]);
 
@@ -531,7 +534,7 @@ static int interface(struct state *state, int argc, char **argv)
 	/* check if there is no interface left and then destroy mesh_iface */
 	if (!manual_mode && rest_argv[0][0] == 'd') {
 		cnt = count_interfaces(state->mesh_iface);
-		if (cnt == 0)
+		if (cnt == 0 && pre_cnt > 0)
 			destroy_interface(state->mesh_iface);
 	}
 
-- 
2.20.1

