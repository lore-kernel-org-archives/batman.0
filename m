Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Mon, 16 Oct 2017 09:48:03 +0200
Message-Id: <20171016074803.17947-1-sven.eckelmann@openmesh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Avoid spurious warnings from
 bat_v neigh_cmp implementation
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
Cc: Joseph Stefek <joseph.stefek@openmesh.com>, =?UTF-8?q?Steffen=20F=C3=B6rster?= <steffen@chemnitz.freifunk.net>, Sven Eckelmann <sven.eckelmann@openmesh.com>, Antonio Quartulli <a@unstable.cc>

The neighbor compare API implementation for B.A.T.M.A.N. V checks whether
the neigh_ifinfo for this neighbor on a specific interface exists. A
warning is printed when it isn't found.

But it is not called inside a lock which would prevent that this
information is lost right before batadv_neigh_ifinfo_get. It must therefore
be expected that batadv_v_neigh_(cmp|is_sob) might not be able to get the
requested neigh_ifinfo.

A WARN_ON for such a situation seems not to be appropriate because this
will only flood the kernel logs. The warnings must therefore be removed.

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
Cc: Antonio Quartulli <a@unstable.cc>

This patch is for https://www.open-mesh.org/issues/343
---
 net/batman-adv/bat_v.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 93ef1c0..69436d2 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -623,11 +623,11 @@ static int batadv_v_neigh_cmp(struct batadv_neigh_node *neigh1,
 	int ret = 0;
 
 	ifinfo1 = batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
-	if (WARN_ON(!ifinfo1))
+	if (!ifinfo1)
 		goto err_ifinfo1;
 
 	ifinfo2 = batadv_neigh_ifinfo_get(neigh2, if_outgoing2);
-	if (WARN_ON(!ifinfo2))
+	if (!ifinfo2)
 		goto err_ifinfo2;
 
 	ret = ifinfo1->bat_v.throughput - ifinfo2->bat_v.throughput;
@@ -649,11 +649,11 @@ static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
 	bool ret = false;
 
 	ifinfo1 = batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
-	if (WARN_ON(!ifinfo1))
+	if (!ifinfo1)
 		goto err_ifinfo1;
 
 	ifinfo2 = batadv_neigh_ifinfo_get(neigh2, if_outgoing2);
-	if (WARN_ON(!ifinfo2))
+	if (!ifinfo2)
 		goto err_ifinfo2;
 
 	threshold = ifinfo1->bat_v.throughput / 4;
-- 
2.11.0

