Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu,  9 Jan 2014 15:52:55 +0100
Message-Id: <1389279182-3256-7-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1389279182-3256-1-git-send-email-antonio@meshcoding.com>
References: <1389279182-3256-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 06/13] batman-adv: remove parenthesis from
	return statements
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

Remove parenthesis around return expression as suggested by
checkpatch.

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 01ec607..93e1fb0 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -139,7 +139,7 @@ static int batadv_compare_dat(const struct hlist_node *node, const void *data2)
 	const void *data1 = container_of(node, struct batadv_dat_entry,
 					 hash_entry);
 
-	return (memcmp(data1, data2, sizeof(__be32)) == 0 ? 1 : 0);
+	return memcmp(data1, data2, sizeof(__be32)) == 0 ? 1 : 0;
 }
 
 /**
-- 
1.8.5.2

