Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Mon,  2 May 2016 01:36:20 +0800
Message-Id: <1462124180-12104-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: make sure ELP/OGM orig MAC
	is updated on address change
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
Cc: Antonio Quartulli <a@unstable.cc>

When the MAC address of the primary interface is changed,
update the originator address in the ELP and OGM skb buffers as
well in order to reflect the change.

Reported-by: Marek Lindner <marek@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/bat_v.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 3ff8bd1..554ccd5 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -72,16 +72,27 @@ static void batadv_v_iface_disable(struct batadv_hard_iface *hard_iface)
 	batadv_v_elp_iface_disable(hard_iface);
 }
 
-static void batadv_v_iface_update_mac(struct batadv_hard_iface *hard_iface)
-{
-}
-
 static void batadv_v_primary_iface_set(struct batadv_hard_iface *hard_iface)
 {
 	batadv_v_elp_primary_iface_set(hard_iface);
 	batadv_v_ogm_primary_iface_set(hard_iface);
 }
 
+static void batadv_v_iface_update_mac(struct batadv_hard_iface *hard_iface)
+{
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_hard_iface *primary_if;
+
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+	if (primary_if != hard_iface)
+		goto out;
+
+	batadv_v_primary_iface_set(hard_iface);
+out:
+	if (primary_if)
+		batadv_hardif_put(primary_if);
+}
+
 static void
 batadv_v_hardif_neigh_init(struct batadv_hardif_neigh_node *hardif_neigh)
 {
-- 
2.8.1

