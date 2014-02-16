Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 16 Feb 2014 10:25:52 +0100
Message-Id: <1392542752-16987-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: return NULL instead of 0 in
	batadv_mcast_forw_ip_node_get()
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

batadv_mcast_forw_ip_node_get() returns a pointer, so returning NULL in
error cases is always more appropriate than 0.

Introduced by: c8fedbea81eac41a4971bb43353fd52a903d7c4c
("batman-adv: Send multicast packets to nodes with a WANT_ALL flag")

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 multicast.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/multicast.c b/multicast.c
index b2abe00..00bb30e 100644
--- a/multicast.c
+++ b/multicast.c
@@ -498,7 +498,7 @@ batadv_mcast_forw_ip_node_get(struct batadv_priv *bat_priv,
 		return batadv_mcast_forw_ipv6_node_get(bat_priv);
 	default:
 		/* we shouldn't be here... */
-		return 0;
+		return NULL;
 	}
 }
 
-- 
1.7.10.4

