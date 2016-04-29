Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 30 Apr 2016 00:59:23 +0200
Message-Id: <1461970765-24615-11-git-send-email-andrew@lunn.ch>
In-Reply-To: <1461970765-24615-1-git-send-email-andrew@lunn.ch>
References: <1461970765-24615-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH v2 10/12] batman-adv: Indicate netlink socket
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

Set the netnsof flag on the family structure, indicating it can
be used with different network name spaces.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 net/batman-adv/netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index a01bdf5..e188c2b 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -44,6 +44,7 @@ struct genl_family batadv_netlink_family = {
 	.name = BATADV_NL_NAME,
 	.version = 1,
 	.maxattr = BATADV_ATTR_MAX,
+	.netnsok = true,
 };
 
 static int
-- 
2.8.0.rc3

