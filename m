Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Wed, 18 May 2016 13:04:49 +0800
Message-Id: <1463547892-11290-6-git-send-email-a@unstable.cc>
In-Reply-To: <1463547892-11290-1-git-send-email-a@unstable.cc>
References: <1463547892-11290-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 5/8] batman-adv: make sure ELP/OGM orig MAC
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>

When the MAC address of the primary interface is changed,
update the originator address in the ELP and OGM skb buffers as
well in order to reflect the change.

Fixes: d6f94d91f766 ("batman-adv: ELP - adding basic infrastructure")
Reported-by: Marek Lindner <marek@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/bat_v.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 4f626a6b8ebd..31bc57e2a944 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -73,16 +73,34 @@ static void batadv_v_iface_disable(struct batadv_hard_iface *hard_iface)
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
 
+/**
+ * batadv_v_iface_update_mac - react to hard-interface MAC address change
+ * @hard_iface: the modified interface
+ *
+ * If the modified interface is the primary one, update the originator
+ * address in the ELP and OGM messages to reflect the new MAC address.
+ */
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
2.8.2

