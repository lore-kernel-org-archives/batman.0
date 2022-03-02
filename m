Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batman-adv: Demote batadv-on-batadv skip error message
Date: Wed,  2 Mar 2022 19:53:14 +0100
Message-Id: <20220302185314.415571-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, =?UTF-8?q?Leonardo=20M=C3=B6rlein?= <freifunk@irrelefant.net>

The error message "Cannot find parent device" was shown for users of
macvtap (on batadv devices) whenever the macvtap was moved to a different
netns. This happens because macvtap doesn't provide an implementation for
rtnl_link_ops->get_link_net.

The situation for which this message is printed is actually not an error
but just a warning that the optional sanity check was skipped. So demote
the message from error to warning and adjust the text to better explain
what happened.

Reported-by: Leonardo Mörlein <freifunk@irrelefant.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hard-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 59d19097..b25afc7f 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -165,9 +165,9 @@ static bool batadv_is_on_batman_iface(const struct net_device *net_dev)
 	/* recurse over the parent device */
 	parent_dev = __dev_get_by_index((struct net *)parent_net,
 					dev_get_iflink(net_dev));
-	/* if we got a NULL parent_dev there is something broken.. */
 	if (!parent_dev) {
-		pr_err("Cannot find parent device\n");
+		pr_warn("Cannot find parent device. Skipping batadv-on-batadv check for %s\n",
+			net_dev->name);
 		return false;
 	}
 
-- 
2.30.2

