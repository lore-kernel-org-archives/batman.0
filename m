Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 16 May 2016 19:28:09 +0200
Message-Id: <1463419689-3580-12-git-send-email-andrew@lunn.ch>
In-Reply-To: <1463419689-3580-1-git-send-email-andrew@lunn.ch>
References: <1463419689-3580-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH v6 11/11] batman-adv: Indicate netlink socket
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

Set the netnsof flag on the family structure, indicating it can
be used with different network name spaces.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 net/batman-adv/netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 972b4cf..e79de09 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -49,6 +49,7 @@ struct genl_family batadv_netlink_family = {
 	.name = BATADV_NL_NAME,
 	.version = 1,
 	.maxattr = BATADV_ATTR_MAX,
+	.netnsok = true,
 };
 
 static struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
-- 
2.8.0.rc3

