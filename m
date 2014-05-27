Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 27 May 2014 04:25:47 +0200
Message-Id: <1401157547-25199-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1401157547-25199-1-git-send-email-antonio@meshcoding.com>
References: <1401157547-25199-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix NULL pointer dereferences
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Marek Lindner <mareklindner@neomailbox.ch>

Was introduced with 4c8755d69cbde2ec464a39c932aed0a83f9ff89f
("batman-adv: Send multicast packets to nodes with a WANT_ALL flag")

Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Acked-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/multicast.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 8c7ca81..96b66fd 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -415,7 +415,7 @@ batadv_mcast_forw_ipv4_node_get(struct batadv_priv *bat_priv)
 	hlist_for_each_entry_rcu(tmp_orig_node,
 				 &bat_priv->mcast.want_all_ipv4_list,
 				 mcast_want_all_ipv4_node) {
-		if (!atomic_inc_not_zero(&orig_node->refcount))
+		if (!atomic_inc_not_zero(&tmp_orig_node->refcount))
 			continue;
 
 		orig_node = tmp_orig_node;
@@ -442,7 +442,7 @@ batadv_mcast_forw_ipv6_node_get(struct batadv_priv *bat_priv)
 	hlist_for_each_entry_rcu(tmp_orig_node,
 				 &bat_priv->mcast.want_all_ipv6_list,
 				 mcast_want_all_ipv6_node) {
-		if (!atomic_inc_not_zero(&orig_node->refcount))
+		if (!atomic_inc_not_zero(&tmp_orig_node->refcount))
 			continue;
 
 		orig_node = tmp_orig_node;
@@ -493,7 +493,7 @@ batadv_mcast_forw_unsnoop_node_get(struct batadv_priv *bat_priv)
 	hlist_for_each_entry_rcu(tmp_orig_node,
 				 &bat_priv->mcast.want_all_unsnoopables_list,
 				 mcast_want_all_unsnoopables_node) {
-		if (!atomic_inc_not_zero(&orig_node->refcount))
+		if (!atomic_inc_not_zero(&tmp_orig_node->refcount))
 			continue;
 
 		orig_node = tmp_orig_node;
-- 
1.8.5.5

