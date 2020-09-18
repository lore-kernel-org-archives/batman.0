Return-Path: <xiyuyang19@fudan.edu.cn>
From: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Subject: [PATCH] batman-adv: Fix orig node refcnt leak when creating neigh node
Date: Fri, 18 Sep 2020 11:03:19 +0800
Message-Id: <1600398200-8198-1-git-send-email-xiyuyang19@fudan.edu.cn>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yuanxzhang@fudan.edu.cn, kjlu@umn.edu, Xiyu Yang <xiyuyang19@fudan.edu.cn>, Xin Tan <tanxin.ctf@gmail.com>

batadv_neigh_node_create() is used to create a neigh node object, whose
fields will be initialized with the specific object. When a new
reference of the specific object is created during the initialization,
its refcount should be increased.

However, when "neigh_node" object initializes its orig_node field with
the "orig_node" object, the function forgets to hold the refcount of the
"orig_node", causing a potential refcount leak and use-after-free issue
for the reason that the object can be freed in other places.

Fix this issue by increasing the refcount of orig_node object during the
initialization and adding corresponding batadv_orig_node_put() in
batadv_neigh_node_release().

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 net/batman-adv/originator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 805d8969bdfb..d6c2296f8e35 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -306,6 +306,8 @@ static void batadv_neigh_node_release(struct kref *ref)
 
 	batadv_hardif_put(neigh_node->if_incoming);
 
+	batadv_orig_node_put(neigh_node->orig_node);
+
 	kfree_rcu(neigh_node, rcu);
 }
 
@@ -685,6 +687,7 @@ batadv_neigh_node_create(struct batadv_orig_node *orig_node,
 	kref_get(&hard_iface->refcount);
 	ether_addr_copy(neigh_node->addr, neigh_addr);
 	neigh_node->if_incoming = hard_iface;
+	kref_get(&orig_node->refcount);
 	neigh_node->orig_node = orig_node;
 	neigh_node->last_seen = jiffies;
 
-- 
2.7.4

