Return-Path: <xerofoify@gmail.com>
From: Nicholas Krause <xerofoify@gmail.com>
Date: Wed, 10 Jun 2015 22:25:33 -0400
Message-Id: <1433989533-30587-1-git-send-email-xerofoify@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv:Make the function
	batadv_is_my_mac bool
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
To: mareklindner@neomailbox.ch
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, antonio@meshcoding.com, davem@davemloft.net

This makes the function batadv_is_my_mac bool now due
to this particular function only returning either one
or zero as its return value.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/batman-adv/main.c | 6 +++---
 net/batman-adv/main.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 12fc77b..47051d1 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -210,7 +210,7 @@ void batadv_mesh_free(struct net_device *soft_iface)
  * @bat_priv: the bat priv with all the soft interface information
  * @addr: the address to check
  */
-int batadv_is_my_mac(struct batadv_priv *bat_priv, const uint8_t *addr)
+bool batadv_is_my_mac(struct batadv_priv *bat_priv, const uint8_t *addr)
 {
 	const struct batadv_hard_iface *hard_iface;
 
@@ -224,11 +224,11 @@ int batadv_is_my_mac(struct batadv_priv *bat_priv, const uint8_t *addr)
 
 		if (batadv_compare_eth(hard_iface->net_dev->dev_addr, addr)) {
 			rcu_read_unlock();
-			return 1;
+			return true;
 		}
 	}
 	rcu_read_unlock();
-	return 0;
+	return false;
 }
 
 /**
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 4d23188..8f6e256 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -195,7 +195,7 @@ extern struct workqueue_struct *batadv_event_workqueue;
 
 int batadv_mesh_init(struct net_device *soft_iface);
 void batadv_mesh_free(struct net_device *soft_iface);
-int batadv_is_my_mac(struct batadv_priv *bat_priv, const uint8_t *addr);
+bool batadv_is_my_mac(struct batadv_priv *bat_priv, const uint8_t *addr);
 struct batadv_hard_iface *
 batadv_seq_print_text_primary_if_get(struct seq_file *seq);
 int batadv_max_header_len(void);
-- 
2.1.4

