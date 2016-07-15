Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 15 Jul 2016 17:39:17 +0200
Message-Id: <1468597173-25378-2-git-send-email-sven@narfation.org>
In-Reply-To: <1468597173-25378-1-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 02/18] batman-adv: Place kref_get for
	orig_ifinfo near use
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

It is hard to understand why the refcnt is increased when it isn't done
near the actual place the new reference is used. So using kref_get right
before the place which requires the reference and in the same function
helps to avoid accidental problems causedy incorrect reference counting.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - split patch based on type

 net/batman-adv/originator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index d778eb1..1db577d 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -380,6 +380,7 @@ batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
 	orig_ifinfo->if_outgoing = if_outgoing;
 	INIT_HLIST_NODE(&orig_ifinfo->list);
 	kref_init(&orig_ifinfo->refcount);
+
 	kref_get(&orig_ifinfo->refcount);
 	hlist_add_head_rcu(&orig_ifinfo->list,
 			   &orig_node->ifinfo_list);
-- 
2.8.1

