Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Wed, 18 May 2016 13:04:52 +0800
Message-Id: <1463547892-11290-9-git-send-email-a@unstable.cc>
In-Reply-To: <1463547892-11290-1-git-send-email-a@unstable.cc>
References: <1463547892-11290-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 8/8] batman-adv: initialize ELP orig address
	on secondary interfaces
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

From: Marek Lindner <mareklindner@neomailbox.ch>

This fix prevents nodes to wrongly create a 00:00:00:00:00:00 originator
which can potentially interfere with the rest of the neighbor statistics.

Fixes: d6f94d91f766 ("batman-adv: ELP - adding basic infrastructure")
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/bat_v.c     | 10 ++++++++++
 net/batman-adv/bat_v_elp.c | 31 ++++++++++++++++++++++---------
 net/batman-adv/bat_v_elp.h |  2 ++
 3 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 31bc57e2a944..0a12e5cdd65d 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -40,6 +40,16 @@
 
 static void batadv_v_iface_activate(struct batadv_hard_iface *hard_iface)
 {
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_hard_iface *primary_if;
+
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+
+	if (primary_if) {
+		batadv_v_elp_iface_activate(primary_if, hard_iface);
+		batadv_hardif_put(primary_if);
+	}
+
 	/* B.A.T.M.A.N. V does not use any queuing mechanism, therefore it can
 	 * set the interface as ACTIVE right away, without any risk of race
 	 * condition
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 3844e7efd0b0..df42eb1365a0 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -377,6 +377,27 @@ void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface)
 }
 
 /**
+ * batadv_v_elp_iface_activate - update the ELP buffer belonging to the given
+ *  hard-interface
+ * @primary_iface: the new primary interface
+ * @hard_iface: interface holding the to-be-updated buffer
+ */
+void batadv_v_elp_iface_activate(struct batadv_hard_iface *primary_iface,
+				 struct batadv_hard_iface *hard_iface)
+{
+	struct batadv_elp_packet *elp_packet;
+	struct sk_buff *skb;
+
+	if (!hard_iface->bat_v.elp_skb)
+		return;
+
+	skb = hard_iface->bat_v.elp_skb;
+	elp_packet = (struct batadv_elp_packet *)skb->data;
+	ether_addr_copy(elp_packet->orig,
+			primary_iface->net_dev->dev_addr);
+}
+
+/**
  * batadv_v_elp_primary_iface_set - change internal data to reflect the new
  *  primary interface
  * @primary_iface: the new primary interface
@@ -384,8 +405,6 @@ void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface)
 void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *primary_iface)
 {
 	struct batadv_hard_iface *hard_iface;
-	struct batadv_elp_packet *elp_packet;
-	struct sk_buff *skb;
 
 	/* update orig field of every elp iface belonging to this mesh */
 	rcu_read_lock();
@@ -393,13 +412,7 @@ void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *primary_iface)
 		if (primary_iface->soft_iface != hard_iface->soft_iface)
 			continue;
 
-		if (!hard_iface->bat_v.elp_skb)
-			continue;
-
-		skb = hard_iface->bat_v.elp_skb;
-		elp_packet = (struct batadv_elp_packet *)skb->data;
-		ether_addr_copy(elp_packet->orig,
-				primary_iface->net_dev->dev_addr);
+		batadv_v_elp_iface_activate(primary_iface, hard_iface);
 	}
 	rcu_read_unlock();
 }
diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
index e95f1bca0785..cc130b2d05e5 100644
--- a/net/batman-adv/bat_v_elp.h
+++ b/net/batman-adv/bat_v_elp.h
@@ -25,6 +25,8 @@ struct work_struct;
 
 int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface);
 void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface);
+void batadv_v_elp_iface_activate(struct batadv_hard_iface *primary_iface,
+				 struct batadv_hard_iface *hard_iface);
 void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *primary_iface);
 int batadv_v_elp_packet_recv(struct sk_buff *skb,
 			     struct batadv_hard_iface *if_incoming);
-- 
2.8.2

