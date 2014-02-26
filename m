Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 26 Feb 2014 14:13:32 +0100
Message-Id: <1393420412-3931-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: use the name of the array as
	pointer
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

Introduced by fb4756fe5f6e58ca2ab208ca634ae4c8dd6e9499
("batman-adv: use ether_addr_copy instead of memcpy in multicast code")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---

change from v1:
- added Signed-off-by clause

 multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/multicast.c b/multicast.c
index e69143b..998b429 100644
--- a/multicast.c
+++ b/multicast.c
@@ -45,7 +45,7 @@ static int batadv_mcast_mla_softif_get(struct net_device *dev,
 			break;
 		}
 
-		ether_addr_copy(&new->addr, &mc_list_entry->addr);
+		ether_addr_copy(new->addr, mc_list_entry->addr);
 		hlist_add_head(&new->list, mcast_list);
 		ret++;
 	}
-- 
1.8.4.5

