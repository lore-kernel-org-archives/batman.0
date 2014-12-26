Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Fri, 26 Dec 2014 12:41:38 +0100
Message-Id: <1419594103-10928-22-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH v2 21/26] batman-adv: main,
	Convert is_my_mac() to bool
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
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>

It is much clearer to see a bool type as return value than 'int' for
functions that are supposed to return true or false.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 main.c | 11 +++++++----
 main.h |  2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/main.c b/main.c
index cff31bb9bb14..d5c79ae1db6f 100644
--- a/main.c
+++ b/main.c
@@ -228,10 +228,13 @@ void batadv_mesh_free(struct net_device *soft_iface)
  * interfaces in the current mesh
  * @bat_priv: the bat priv with all the soft interface information
  * @addr: the address to check
+ *
+ * Returns 'true' if the mac address was found, false otherwise.
  */
-int batadv_is_my_mac(struct batadv_priv *bat_priv, const uint8_t *addr)
+bool batadv_is_my_mac(struct batadv_priv *bat_priv, const uint8_t *addr)
 {
 	const struct batadv_hard_iface *hard_iface;
+	bool is_my_mac = false;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
@@ -242,12 +245,12 @@ int batadv_is_my_mac(struct batadv_priv *bat_priv, const uint8_t *addr)
 			continue;
 
 		if (batadv_compare_eth(hard_iface->net_dev->dev_addr, addr)) {
-			rcu_read_unlock();
-			return 1;
+			is_my_mac = true;
+			break;
 		}
 	}
 	rcu_read_unlock();
-	return 0;
+	return is_my_mac;
 }
 
 /**
diff --git a/main.h b/main.h
index 013de2f7ee11..6cd339090658 100644
--- a/main.h
+++ b/main.h
@@ -196,7 +196,7 @@ extern struct workqueue_struct *batadv_event_workqueue;
 
 int batadv_mesh_init(struct net_device *soft_iface);
 void batadv_mesh_free(struct net_device *soft_iface);
-int batadv_is_my_mac(struct batadv_priv *bat_priv, const uint8_t *addr);
+bool batadv_is_my_mac(struct batadv_priv *bat_priv, const uint8_t *addr);
 struct batadv_hard_iface *
 batadv_seq_print_text_primary_if_get(struct seq_file *seq);
 int batadv_max_header_len(void);
-- 
2.1.3

