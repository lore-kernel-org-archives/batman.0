Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 22 Mar 2012 22:51:14 +0100
Message-Id: <1332453075-27999-4-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1332453075-27999-1-git-send-email-lindner_marek@yahoo.de>
References: <201203222250.31309.lindner_marek@yahoo.de>
	<1332453075-27999-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] =?utf-8?q?=5BRFC_4/5=5D_batman-adv=3A_ELP_-_adding?=
	=?utf-8?q?_sysfs_parameter_for_elp_interval?=
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

From: Linus Luessing <linus.luessing@web.de>

This parameter can be set individually on each interface and allows the
configuration of the ndp interval for the link quality measurements during
runtime. Usually it is desirable to set it to a higher (= slower) value on
interfaces which have a more static characteristic (e.g. wired interfaces)
or very dense neighbourhoods to reduce overhead.

Developed by Linus during a 6 months trainee study period in Ascom
(Switzerland) AG.

Signed-off-by: Linus Luessing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_sysfs.c                |    6 ++++++
 sysfs-class-net-batman-adv |    7 +++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index d0f8453..6195a66 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -630,10 +630,16 @@ static ssize_t show_iface_status(struct kobject *kobj, struct attribute *attr,
 static BAT_ATTR(mesh_iface, S_IRUGO | S_IWUSR,
 		show_mesh_iface, store_mesh_iface);
 static BAT_ATTR(iface_status, S_IRUGO, show_iface_status, NULL);
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+BAT_ATTR_HIF_UINT(elp_interval, S_IRUGO | S_IWUSR, 2 * JITTER, INT_MAX, NULL);
+#endif
 
 static struct bat_attribute *batman_attrs[] = {
 	&bat_attr_mesh_iface,
 	&bat_attr_iface_status,
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	&bat_attr_elp_interval,
+#endif
 	NULL,
 };
 
diff --git a/sysfs-class-net-batman-adv b/sysfs-class-net-batman-adv
index 38dd762..954ab1f 100644
--- a/sysfs-class-net-batman-adv
+++ b/sysfs-class-net-batman-adv
@@ -12,3 +12,10 @@ Date:           May 2010
 Contact:        Marek Lindner <lindner_marek@yahoo.de>
 Description:
                 Indicates the status of <iface> as it is seen by batman.
+
+What:           /sys/class/net/<mesh_iface>/batman-adv/elp_interval
+Date:           Mar 2012
+Contact:        Linus Lüssing <linus.luessing@web.de>
+Description:
+                Defines the interval in milliseconds in which batman
+                sends its probing packets for link quality measurements.
\ No newline at end of file
-- 
1.7.9.1

