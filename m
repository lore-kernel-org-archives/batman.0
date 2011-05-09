Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon,  9 May 2011 11:52:22 +0200
Message-Id: <1304934744-6599-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1304579589-5222-1-git-send-email-ordex@autistici.org>
References: <1304579589-5222-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 1/3] batman-adv: add wrapper function to
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
 1) BAT*= strings have been substituted by macros.
 2) the return value of kobject_uevent is now included in the error message
 
 bat_sysfs.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 bat_sysfs.h |    2 +
 main.h      |   11 +++++++++
 3 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index 497a070..5bb9b34 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -32,6 +32,20 @@
 #define kobj_to_netdev(obj)	to_net_dev(to_dev(obj->parent))
 #define kobj_to_batpriv(obj)	netdev_priv(kobj_to_netdev(obj))
 
+#define UEV_TYPE_VAR	"BATTYPE="
+#define UEV_ACTION_VAR	"BATACTION="
+#define UEV_DATA_VAR	"BATDATA="
+
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
@@ -594,3 +608,60 @@ void sysfs_del_hardif(struct kobject **hardif_obj)
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
+	uevent_env[0] = kmalloc(strlen(UEV_TYPE_VAR) +
+				strlen(uev_type_str[type]) + 1,
+				GFP_ATOMIC);
+	if (!uevent_env[0])
+		goto out;
+
+	sprintf(uevent_env[0], "%s%s", UEV_TYPE_VAR, uev_type_str[type]);
+
+	uevent_env[1] = kmalloc(strlen(UEV_ACTION_VAR) +
+				strlen(uev_action_str[action]) + 1,
+				GFP_ATOMIC);
+	if (!uevent_env[1])
+		goto out;
+
+	sprintf(uevent_env[1], "%s%s", UEV_ACTION_VAR, uev_action_str[action]);
+
+	/* If the event is DEL, ignore the data field */
+	if (action != UEV_DEL) {
+		uevent_env[2] = kmalloc(strlen(UEV_DATA_VAR) +
+					strlen(data) + 1, GFP_ATOMIC);
+		if (!uevent_env[2])
+			goto out;
+
+		sprintf(uevent_env[2], "%s%s", UEV_DATA_VAR, data);
+	}
+
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
+			"uevent for (%s,%s,%s) event (err: %d)\n",
+			uev_type_str[type], uev_action_str[action],
+			(action == UEV_DEL ? "NULL" : data), ret);
+	return ret;
+}
diff --git a/bat_sysfs.h b/bat_sysfs.h
index 02f1fa7..e48ed9a 100644
--- a/bat_sysfs.h
+++ b/bat_sysfs.h
@@ -38,5 +38,7 @@ int sysfs_add_meshif(struct net_device *dev);
 void sysfs_del_meshif(struct net_device *dev);
 int sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev);
 void sysfs_del_hardif(struct kobject **hardif_obj);
+int throw_uevent(struct bat_priv *bat_priv, enum uev_type type,
+		 enum uev_action action, char *data);
 
 #endif /* _NET_BATMAN_ADV_SYSFS_H_ */
diff --git a/main.h b/main.h
index 3ca3941..4f9991d 100644
--- a/main.h
+++ b/main.h
@@ -79,6 +79,17 @@
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

