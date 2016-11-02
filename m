Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  2 Nov 2016 18:14:43 +0100
Message-Id: <20161102171443.9491-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Revert "fix splat on
	disabling an interface"
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
Cc: julian@freifunk-rtk.de

The commit bac7733d06fa ("batman-adv: fix splat on disabling an interface")
fixed a warning but at the same time broke the rtnl function add_slave for
devices which were temporarily removed.

batadv_softif_slave_add requires soft_iface of and hard_iface to be NULL
before it is allowed to be enslaved. But this resetting of soft_iface to
NULL in batadv_hardif_disable_interface was removed with the aforementioned
commit.

Reported-by: Julian Labus <julian@freifunk-rtk.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Cc: Linus Lüssing <linus.luessing@c0d3.blue>
---
This is a simple revert. Linus, feel free to propose a patch to remove the
"|| hard_iface->soft_iface" when you think it is safe and you've tested
that it works

Bug report for it can be found at https://www.open-mesh.org/issues/307
---
 net/batman-adv/hard-interface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index e034afb..08ce361 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -652,6 +652,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 			batadv_softif_destroy_sysfs(hard_iface->soft_iface);
 	}
 
+	hard_iface->soft_iface = NULL;
 	batadv_hardif_put(hard_iface);
 
 out:
-- 
2.10.2

