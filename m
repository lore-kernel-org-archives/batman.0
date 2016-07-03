Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Jul 2016 12:46:35 +0200
Message-Id: <1467542795-29647-5-git-send-email-sven@narfation.org>
In-Reply-To: <1467542795-29647-1-git-send-email-sven@narfation.org>
References: <1467542795-29647-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v6 4/4] batman-adv: disable sysfs knobs when
	GW-mode is not implemented
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

From: Antonio Quartulli <a@unstable.cc>

Now that the GW-mode code is algorithm specific, batman-adv expects the
routing algorithm to implement some APIs to make it work.

However, such APIs are not mandatory, therefore we might have algorithms
not providing them. In this case all the sysfs knobs related to GW-mode
should be deactivated to make sure that settings injected by the user
for this feature are rejected.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v6:
 - no changes
---
 net/batman-adv/sysfs.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index e78bd7f..02d96f2 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -429,6 +429,13 @@ static ssize_t batadv_show_gw_mode(struct kobject *kobj, struct attribute *attr,
 	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
 	int bytes_written;
 
+	/* GW mode is not available if the routing algorithm in use does not
+	 * implement the GW API
+	 */
+	if (!bat_priv->algo_ops->gw.get_best_gw_node ||
+	    !bat_priv->algo_ops->gw.is_eligible)
+		return -ENOENT;
+
 	switch (atomic_read(&bat_priv->gw.mode)) {
 	case BATADV_GW_MODE_CLIENT:
 		bytes_written = sprintf(buff, "%s\n",
@@ -456,6 +463,13 @@ static ssize_t batadv_store_gw_mode(struct kobject *kobj,
 	char *curr_gw_mode_str;
 	int gw_mode_tmp = -1;
 
+	/* toggling GW mode is allowed only if the routing algorithm in use
+	 * provides the GW API
+	 */
+	if (!bat_priv->algo_ops->gw.get_best_gw_node ||
+	    !bat_priv->algo_ops->gw.is_eligible)
+		return -EINVAL;
+
 	if (buff[count - 1] == '\n')
 		buff[count - 1] = '\0';
 
@@ -520,6 +534,13 @@ static ssize_t batadv_show_gw_sel_class(struct kobject *kobj,
 {
 	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
 
+	/* GW selection class is not available if the routing algorithm in use
+	 * does not implement the GW API
+	 */
+	if (!bat_priv->algo_ops->gw.get_best_gw_node ||
+	    !bat_priv->algo_ops->gw.is_eligible)
+		return -ENOENT;
+
 	if (bat_priv->algo_ops->gw.show_sel_class)
 		return bat_priv->algo_ops->gw.show_sel_class(bat_priv, buff);
 
@@ -532,6 +553,13 @@ static ssize_t batadv_store_gw_sel_class(struct kobject *kobj,
 {
 	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
 
+	/* setting the GW selection class is allowed only if the routing
+	 * algorithm in use implements the GW API
+	 */
+	if (!bat_priv->algo_ops->gw.get_best_gw_node ||
+	    !bat_priv->algo_ops->gw.is_eligible)
+		return -EINVAL;
+
 	if (buff[count - 1] == '\n')
 		buff[count - 1] = '\0';
 
-- 
2.8.1

