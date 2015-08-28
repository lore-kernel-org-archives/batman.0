Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Fri, 28 Aug 2015 11:12:28 +0200
Message-Id: <1440753156-7808-3-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1440753156-7808-1-git-send-email-antonio@meshcoding.com>
References: <1440753156-7808-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 02/10] batman-adv: remove redundant
	hard_iface assignment
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

The batadv_neigh_node_new() function already sets the hard_iface pointer.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Acked-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/bat_iv_ogm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index b9b8b33..b18184e 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -304,7 +304,6 @@ batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 		goto out;
 
 	neigh_node->orig_node = orig_neigh;
-	neigh_node->if_incoming = hard_iface;
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
 	tmp_neigh_node = batadv_neigh_node_get(orig_node, hard_iface,
-- 
2.5.0

