Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  2 Dec 2017 08:45:59 +0100
Message-Id: <20171202074559.3582-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Handle allocation error in
 vlan_get_link_parse
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

The malloc could fail and return NULL. In this case, the processing of the
current interface index has to be stopped to avoid writing to NULL (which
would cause a segfault).

Fixes: d29288fe0583 ("batctl: implement vlan-to-link helper functions")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/functions.c b/functions.c
index 8bcf52d..5e4eda0 100644
--- a/functions.c
+++ b/functions.c
@@ -812,6 +812,9 @@ static int vlan_get_link_parse(struct nl_msg *msg, void *arg)
 	idx = *(int *)nla_data(tb[IFLA_LINK]);
 	free(nl_arg->iface);
 	nl_arg->iface = malloc(IFNAMSIZ + 1);
+	if (!nl_arg->iface)
+		goto err;
+
 	if (!if_indextoname(idx, nl_arg->iface))
 		goto err;
 
-- 
2.11.0

