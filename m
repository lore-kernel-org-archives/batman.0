Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon, 17 Feb 2014 23:12:35 +0100
Message-Id: <1392675155-26954-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: use ether_addr_copy instead of
	memcpy in multicast code
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

ether_addr_copy is supposed to be slightly more efficient for copying
mac addresses, so let's use it. This makes recent versions of checkpatch
happy, too.

Reported-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 multicast.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/multicast.c b/multicast.c
index 00bb30e..e69143b 100644
--- a/multicast.c
+++ b/multicast.c
@@ -45,7 +45,7 @@ static int batadv_mcast_mla_softif_get(struct net_device *dev,
 			break;
 		}
 
-		memcpy(&new->addr, &mc_list_entry->addr, ETH_ALEN);
+		ether_addr_copy(&new->addr, &mc_list_entry->addr);
 		hlist_add_head(&new->list, mcast_list);
 		ret++;
 	}
-- 
1.7.10.4

