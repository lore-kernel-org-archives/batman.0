Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 11 Jul 2013 19:47:38 +0200
Message-Id: <1373564858-2248-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: send GW_DEL event when the gw
	client mode is deselected
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Whenever the GW client mode is deselected, a DEL event has
to be sent in order to tell userspace that the current
gateway has been lost. Send the uevent on state change only
if a gateway was currently selected.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 gateway_client.c | 28 ++++++++++++++++++++++++++++
 gateway_client.h |  1 +
 sysfs.c          |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/gateway_client.c b/gateway_client.c
index 588d27e..bdda464 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -188,6 +188,34 @@ next:
 	return curr_gw;
 }
 
+/**
+ * batadv_gw_check_client_stop - check if clitn mode has been switched off
+ * @bat_priv: the bat priv with all the soft interface information
+ * @new_mode: the gw mode which the node is switching to
+ *
+ * This function assumes the caller has checked that the gw state *is actually
+ * changing*. This function is not supposed to be called when there is no state
+ * change.
+ */
+void batadv_gw_check_client_stop(struct batadv_priv *bat_priv)
+{
+	struct batadv_gw_node *curr_gw;
+
+	if (atomic_read(&bat_priv->gw_mode) != BATADV_GW_MODE_CLIENT)
+		return;
+
+	curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
+	if (!curr_gw)
+		return;
+
+	/* if batman-adv is switching the gw client mode off and a gateway was
+	 * already selected, send a DEL uevent
+	 */
+	batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_DEL, NULL);
+
+	batadv_gw_node_free_ref(curr_gw);
+}
+
 void batadv_gw_election(struct batadv_priv *bat_priv)
 {
 	struct batadv_gw_node *curr_gw = NULL, *next_gw = NULL;
diff --git a/gateway_client.h b/gateway_client.h
index 7ef955a..b235cbf 100644
--- a/gateway_client.h
+++ b/gateway_client.h
@@ -20,6 +20,7 @@
 #ifndef _NET_BATMAN_ADV_GATEWAY_CLIENT_H_
 #define _NET_BATMAN_ADV_GATEWAY_CLIENT_H_
 
+void batadv_gw_check_client_stop(struct batadv_priv *bat_priv);
 void batadv_gw_deselect(struct batadv_priv *bat_priv);
 void batadv_gw_election(struct batadv_priv *bat_priv);
 struct batadv_orig_node *
diff --git a/sysfs.c b/sysfs.c
index 6ec145d..1126f74 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -409,6 +409,8 @@ static ssize_t batadv_store_gw_mode(struct kobject *kobj,
 		    curr_gw_mode_str, buff);
 
 	batadv_gw_deselect(bat_priv);
+	/* always call the client check before changing the state */
+	batadv_gw_check_client_stop(bat_priv);
 	atomic_set(&bat_priv->gw_mode, (unsigned int)gw_mode_tmp);
 	batadv_gw_tvlv_container_update(bat_priv);
 	return count;
-- 
1.8.1.5

