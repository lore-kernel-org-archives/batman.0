Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 29 May 2013 10:10:35 +0200
Message-Id: <1369815051-708-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1369815051-708-1-git-send-email-ordex@autistici.org>
References: <1369815051-708-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 05/21] batman-adv: slightly improve neighbor
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

print the interface along with the new neighbor mac address

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/originator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index ddf5634..f50553a 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -110,7 +110,8 @@ batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
 	atomic_set(&neigh_node->refcount, 2);
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-		   "Creating new neighbor %pM\n", neigh_addr);
+		   "Creating new neighbor %pM on interface %s\n", neigh_addr,
+		   hard_iface->net_dev->name);
 
 out:
 	return neigh_node;
-- 
1.8.1.5

