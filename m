Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 25 Mar 2013 13:49:47 +0100
Message-Id: <1364215787-17935-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1364215787-17935-1-git-send-email-ordex@autistici.org>
References: <1364215787-17935-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: slightly improve neighbor
	creation debug message
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

print the interface along with the new neighbor mac address

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 originator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/originator.c b/originator.c
index ddd417c..fc331bc 100644
--- a/originator.c
+++ b/originator.c
@@ -110,7 +110,8 @@ batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
 	atomic_set(&neigh_node->refcount, 2);
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-		   "Creating new neighbor %pM\n", neigh_addr);
+		   "Creating new neighbor %pM on interface %s\n", neigh_addr,
+		   hard_iface->net_dev->dev_name);
 
 out:
 	return neigh_node;
-- 
1.8.1.5

