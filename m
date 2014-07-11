Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Fri, 11 Jul 2014 14:26:33 +0200
Message-Id: <1405081595-23371-11-git-send-email-martin@hundeboll.net>
In-Reply-To: <1405081595-23371-1-git-send-email-martin@hundeboll.net>
References: <1405081595-23371-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 11/13] batman-adv: kernel doc fixes for
	sysfs.{c, h}
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 sysfs.c | 5 ++---
 sysfs.h | 8 ++++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/sysfs.c b/sysfs.c
index fc47baa..bf8800e 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -62,6 +62,7 @@ static struct batadv_priv *batadv_vlan_kobj_to_batpriv(struct kobject *obj)
 
 /**
  * batadv_kobj_to_vlan - convert a kobj in the associated softif_vlan struct
+ * @bat_priv: batman-adv private data
  * @obj: kobject to covert
  *
  * Returns the associated softif_vlan struct if found, NULL otherwise.
@@ -593,9 +594,7 @@ static struct batadv_attribute *batadv_mesh_attrs[] = {
 
 BATADV_ATTR_VLAN_BOOL(ap_isolation, S_IRUGO | S_IWUSR, NULL);
 
-/**
- * batadv_vlan_attrs - array of vlan specific sysfs attributes
- */
+/* struct batadv_vlan_attrs - array of vlan specific sysfs attributes */
 static struct batadv_attribute *batadv_vlan_attrs[] = {
 	&batadv_attr_vlan_ap_isolation,
 	NULL,
diff --git a/sysfs.h b/sysfs.h
index b715b60..68b8c99 100644
--- a/sysfs.h
+++ b/sysfs.h
@@ -20,10 +20,10 @@
 
 #define BATADV_SYSFS_IF_MESH_SUBDIR "mesh"
 #define BATADV_SYSFS_IF_BAT_SUBDIR "batman_adv"
-/**
- * BATADV_SYSFS_VLAN_SUBDIR_PREFIX - prefix of the subfolder that will be
- *  created in the sysfs hierarchy for each VLAN interface. The subfolder will
- *  be named "BATADV_SYSFS_VLAN_SUBDIR_PREFIX%vid".
+
+/* BATADV_SYSFS_VLAN_SUBDIR_PREFIX - prefix of the subfolder that will be
+ * created in the sysfs hierarchy for each VLAN interface. The subfolder will
+ * be named "BATADV_SYSFS_VLAN_SUBDIR_PREFIX%vid".
  */
 #define BATADV_SYSFS_VLAN_SUBDIR_PREFIX "vlan"
 
-- 
2.0.1

