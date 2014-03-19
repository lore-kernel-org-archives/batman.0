Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 19 Mar 2014 09:08:52 +0100
Message-Id: <1395216532-31099-11-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1395216532-31099-1-git-send-email-antonio@meshcoding.com>
References: <1395216532-31099-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 next 11/11] batman-adv: fix more code style
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

- use common iteration style pattern when looking up an
  object

Introduced by f2ed1502191a37abb39e3e2c80cca07f0f3bb411
("batman-adv: Send multicast packets to nodes with a WANT_ALL flag")

Cc: Linux Lüssing <linus.luessing@web.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 multicast.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/multicast.c b/multicast.c
index 79a18a0..de47018 100644
--- a/multicast.c
+++ b/multicast.c
@@ -415,20 +415,20 @@ batadv_mcast_forw_tt_node_get(struct batadv_priv *bat_priv,
 static struct batadv_orig_node *
 batadv_mcast_forw_ipv4_node_get(struct batadv_priv *bat_priv)
 {
-	struct batadv_orig_node *orig_node;
+	struct batadv_orig_node *tmp_orig_node, *orig_node = NULL;
 
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(orig_node,
+	hlist_for_each_entry_rcu(tmp_orig_node,
 				 &bat_priv->mcast.want_all_ipv4_list,
 				 mcast_want_all_ipv4_node) {
-		if (atomic_inc_not_zero(&orig_node->refcount))
-			goto unlock;
-	}
-
-	orig_node = NULL;
+		if (!atomic_inc_not_zero(&orig_node->refcount))
+			continue;
 
-unlock:
+		orig_node = tmp_orig_node;
+		break;
+	}
 	rcu_read_unlock();
+
 	return orig_node;
 }
 
@@ -442,20 +442,20 @@ unlock:
 static struct batadv_orig_node *
 batadv_mcast_forw_ipv6_node_get(struct batadv_priv *bat_priv)
 {
-	struct batadv_orig_node *orig_node;
+	struct batadv_orig_node *tmp_orig_node, *orig_node = NULL;
 
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(orig_node,
+	hlist_for_each_entry_rcu(tmp_orig_node,
 				 &bat_priv->mcast.want_all_ipv6_list,
 				 mcast_want_all_ipv6_node) {
-		if (atomic_inc_not_zero(&orig_node->refcount))
-			goto unlock;
-	}
-
-	orig_node = NULL;
+		if (!atomic_inc_not_zero(&orig_node->refcount))
+			continue;
 
-unlock:
+		orig_node = tmp_orig_node;
+		break;
+	}
 	rcu_read_unlock();
+
 	return orig_node;
 }
 
-- 
1.8.3.2

