Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 23 May 2016 17:59:45 +0200
Message-Id: <1464019185-8381-15-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1464019185-8381-1-git-send-email-sw@simonwunderlich.de>
References: <1464019185-8381-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH v8 14/14] batman-adv: Indicate netlink socket
	can be used with netns.
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

From: Andrew Lunn <andrew@lunn.ch>

Set the netnsof flag on the family structure, indicating it can
be used with different network name spaces.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index e7785d9..3f5ba3c 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -54,6 +54,7 @@ struct genl_family batadv_netlink_family = {
 	.name = BATADV_NL_NAME,
 	.version = 1,
 	.maxattr = BATADV_ATTR_MAX,
+	.netnsok = true,
 };
 
 /* multicast groups */
-- 
2.8.1

