Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Wed, 18 May 2016 13:04:46 +0800
Message-Id: <1463547892-11290-3-git-send-email-a@unstable.cc>
In-Reply-To: <1463547892-11290-1-git-send-email-a@unstable.cc>
References: <1463547892-11290-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 2/8] batman-adv: Avoid nullptr derefence in
	batadv_v_neigh_is_sob
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

batadv_neigh_ifinfo_get can return NULL when it cannot find (even when only
temporarily) anymore the neigh_ifinfo in the list neigh->ifinfo_list. This
has to be checked to avoid kernel Oopses when the ifinfo is dereferenced.

This a situation which isn't expected but is already handled by functions
like batadv_v_neigh_cmp. The same kind of warning is therefore used before
the function returns without dereferencing the pointers.

Fixes: 9786906022eb ("batman-adv: B.A.T.M.A.N. V - implement neighbor comparison API calls")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/bat_v.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 3ff8bd1b7bdc..50bfcf87f569 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -27,6 +27,7 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/seq_file.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
@@ -276,6 +277,9 @@ static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
 	ifinfo1 = batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
 	ifinfo2 = batadv_neigh_ifinfo_get(neigh2, if_outgoing2);
 
+	if (WARN_ON(!ifinfo1 || !ifinfo2))
+		return false;
+
 	threshold = ifinfo1->bat_v.throughput / 4;
 	threshold = ifinfo1->bat_v.throughput - threshold;
 
-- 
2.8.2

