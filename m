Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  5 May 2011 09:13:07 +0200
Message-Id: <1304579589-5222-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1304579589-5222-1-git-send-email-ordex@autistici.org>
References: <1304579589-5222-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: add wrapper function to
	throw uevent in userspace
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

Using throw_uevent() is now possible to trigger uevent signal that can
be recognised in userspace. Uevents will be triggered through the
/devices/virtual/net/{MESH_IFACE} kobject.

A triggered uevent has three properties:
- type: the event class. Who generates the event (only 'gw' is currently
  defined). Corresponds to the BATTYPE uevent variable.
- action: the associated action with the event ('add'/'change'/'del' are
  currently defined). Corresponds to the BAACTION uevent variable.
- data: any useful data for the userspace. Corresponds to the BATDATA
  uevent variable.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 bat_sysfs.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 bat_sysfs.h |    4 +++
 main.h      |   11 +++++++++
 3 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index 497a070..83c0980 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -32,6 +32,16 @@
 #define kobj_to_netdev(obj)	to_net_dev(to_dev(obj->parent))
 #define kobj_to_batpriv(obj)	netdev_priv(kobj_to_netdev(obj))
 
+static char *uev_action_str[] = {
+	"add",
+	"del",
+	"change"
+};
+
+static char *uev_type_str[] = {
+	"gw"
+};
+
 /* Use this, if you have customized show and store functions */
 #define BAT_ATTR(_name, _mode, _show, _store)	\
 struct bat_attribute bat_attr_##_name = {	\
@@ -594,3 +604,62 @@ void sysfs_del_hardif(struct kobject **hardif_obj)
 	kobject_put(*hardif_obj);
 	*hardif_obj = NULL;
 }
+
+int throw_uevent(struct bat_priv *bat_priv, enum uev_type type,
+		 enum uev_action action, char *data)
+{
+	int ret = -1;
+	struct hard_iface *primary_if = NULL;
+	struct kobject *bat_kobj;
+	char *uevent_env[4] = { NULL, NULL, NULL, NULL };
+
+	primary_if = primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		goto out;
+
+	bat_kobj = &primary_if->soft_iface->dev.kobj;
+
+	uevent_env[0] = kmalloc(strlen("BATTYPE=") +
+				strlen(uev_type_str[type]) + 1,
+				GFP_ATOMIC);
+	if (!uevent_env[0])
+		goto out;
+
+	sprintf(uevent_env[0], "BATTYPE=%s", uev_type_str[type]);
+
+	uevent_env[1] = kmalloc(strlen("BATACTION=") +
+				strlen(uev_action_str[action]) + 1,
+				GFP_ATOMIC);
+	if (!uevent_env[1])
+		goto out;
+
+	sprintf(uevent_env[1], "BATACTION=%s", uev_action_str[action]);
+
+	/* If the event is DEL, ignore the data field */
+	if (action == UEV_DEL)
+		goto throw;
+
+	uevent_env[2] = kmalloc(strlen("BATDATA=") +
+				strlen(data) + 1, GFP_ATOMIC);
+	if (!uevent_env[2])
+		goto out;
+
+	sprintf(uevent_env[2], "BATDATA=%s", data);
+
+throw:
+	ret = kobject_uevent_env(bat_kobj, KOBJ_CHANGE, uevent_env);
+out:
+	kfree(uevent_env[0]);
+	kfree(uevent_env[1]);
+	kfree(uevent_env[2]);
+
+	if (primary_if)
+		hardif_free_ref(primary_if);
+
+	if (ret)
+		bat_dbg(DBG_BATMAN, bat_priv, "Impossible to send "
+			"uevent for (%s,%s,%s) event\n",
+			uev_type_str[type], uev_action_str[action],
+			(action == UEV_DEL ? "NULL" : data));
+	return ret;
+}
diff --git a/bat_sysfs.h b/bat_sysfs.h
index 02f1fa7..2b1a1d0 100644
--- a/bat_sysfs.h
+++ b/bat_sysfs.h
@@ -26,6 +26,8 @@
 #define SYSFS_IF_MESH_SUBDIR "mesh"
 #define SYSFS_IF_BAT_SUBDIR "batman_adv"
 
+struct bat_priv;
+
 struct bat_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct kobject *kobj, struct attribute *attr,
@@ -38,5 +40,7 @@ int sysfs_add_meshif(struct net_device *dev);
 void sysfs_del_meshif(struct net_device *dev);
 int sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev);
 void sysfs_del_hardif(struct kobject **hardif_obj);
+int throw_uevent(struct bat_priv *bat_priv, enum uev_type type,
+		 enum uev_action action, char *data);
 
 #endif /* _NET_BATMAN_ADV_SYSFS_H_ */
diff --git a/main.h b/main.h
index 101d9dc..0dfb46e 100644
--- a/main.h
+++ b/main.h
@@ -78,6 +78,17 @@
 #define BCAST_QUEUE_LEN		256
 #define BATMAN_QUEUE_LEN	256
 
+
+enum uev_action {
+	UEV_ADD = 0,
+	UEV_DEL,
+	UEV_CHANGE
+};
+
+enum uev_type {
+	UEV_GW = 0
+};
+
 /*
  * Debug Messages
  */
-- 
1.7.3.4

