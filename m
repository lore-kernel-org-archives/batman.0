Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 19 Mar 2014 09:08:51 +0100
Message-Id: <1395216532-31099-10-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1395216532-31099-1-git-send-email-antonio@meshcoding.com>
References: <1395216532-31099-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 next 10/11] batman-adv: fix more code style
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

- keep variable declarations in descending line length order
- use common iteration style pattern when looking up an
  object

Introduced by 86cb16e5ec1e2d75821006e8f4abbec66fb741ac
("batman-adv: Add IPv4 link-local/IPv6-ll-all-nodes multicast support")

Cc: Linux Lüssing <linus.luessing@web.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 multicast.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/multicast.c b/multicast.c
index 7927865..79a18a0 100644
--- a/multicast.c
+++ b/multicast.c
@@ -493,20 +493,20 @@ batadv_mcast_forw_ip_node_get(struct batadv_priv *bat_priv,
 static struct batadv_orig_node *
 batadv_mcast_forw_unsnoop_node_get(struct batadv_priv *bat_priv)
 {
-	struct batadv_orig_node *orig_node;
+	struct batadv_orig_node *tmp_orig_node, *orig_node = NULL;
 
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(orig_node,
+	hlist_for_each_entry_rcu(tmp_orig_node,
 				 &bat_priv->mcast.want_all_unsnoopables_list,
 				 mcast_want_all_unsnoopables_node) {
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
 
@@ -524,9 +524,9 @@ enum batadv_forw_mode
 batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		       struct batadv_orig_node **orig)
 {
-	struct ethhdr *ethhdr;
-	bool is_unsnoopable = false;
 	int ret, tt_count, ip_count, unsnoop_count, total_count;
+	bool is_unsnoopable = false;
+	struct ethhdr *ethhdr;
 
 	ret = batadv_mcast_forw_mode_check(bat_priv, skb, &is_unsnoopable);
 	if (ret == -ENOMEM)
-- 
1.8.3.2

