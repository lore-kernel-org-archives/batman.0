Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] alfred: vis: Fix ifindex check when registering interface
Date: Fri,  2 Aug 2019 08:35:53 +0200
Message-Id: <20190802063553.5666-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The return value of if_nametoindex should be checked before the rtnl query
is send to the kernel. Otherwise we might try to operate on an ifindex
which doesn't exist in the kernel - which will never register any interface.

Fixes: a34f044de561 ("alfred: vis: Use rtnl to query list of hardifs of meshif")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 vis/vis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vis/vis.c b/vis/vis.c
index 8df3056..cdc5524 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -617,7 +617,7 @@ static int register_interfaces(struct globals *globals)
 	};
 
 	register_arg.ifindex = if_nametoindex(globals->interface);
-	if (!globals->interface)
+	if (!register_arg.ifindex)
 		return EXIT_FAILURE;
 
 
-- 
2.20.1

