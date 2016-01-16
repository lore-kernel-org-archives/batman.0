Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 16 Jan 2016 16:40:11 +0800
Message-Id: <1452933619-6712-4-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <8047297.0qIFjkW2bL@voltaire>
References: <8047297.0qIFjkW2bL@voltaire>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v2 04/12] batman-adv: ELP - adding sysfs
	parameter for elp interval
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@open-mesh.com>

From: Linus Luessing <linus.luessing@web.de>

This parameter can be set individually on each interface and
allows the configuration of the elp interval for the link
quality measurements during runtime. Usually it is desirable
to set it to a higher (= slower) value on interfaces which
have a more static characteristic (e.g. wired interfaces)
or very dense neighbourhoods to reduce overhead.

Developed by Linus during a 6 months trainee study period in
Ascom (Switzerland) AG.

Signed-off-by: Linus Luessing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
[antonio@open-mesh.com: respin on top of the latest master]
Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 Documentation/ABI/testing/sysfs-class-net-batman-adv | 8 +++++++-
 net/batman-adv/sysfs.c                               | 7 +++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-net-batman-adv b/Documentation/ABI/testing/sysfs-class-net-batman-adv
index 7f34a95..aea78db 100644
--- a/Documentation/ABI/testing/sysfs-class-net-batman-adv
+++ b/Documentation/ABI/testing/sysfs-class-net-batman-adv
@@ -1,4 +1,11 @@
 
+What:           /sys/class/net/<iface>/batman-adv/elp_interval
+Date:           Feb 2014
+Contact:        Linus Lüssing <linus.luessing@web.de>
+Description:
+                Defines the interval in milliseconds in which batman
+                sends its probing packets for link quality measurements.
+
 What:           /sys/class/net/<iface>/batman-adv/iface_status
 Date:           May 2010
 Contact:        Marek Lindner <mareklindner@neomailbox.ch>
@@ -12,4 +19,3 @@ Description:
                 The /sys/class/net/<iface>/batman-adv/mesh_iface file
                 displays the batman mesh interface this <iface>
                 currently is associated with.
-
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index d3f69d5..e860143 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -920,10 +920,17 @@ static ssize_t batadv_show_iface_status(struct kobject *kobj,
 static BATADV_ATTR(mesh_iface, S_IRUGO | S_IWUSR, batadv_show_mesh_iface,
 		   batadv_store_mesh_iface);
 static BATADV_ATTR(iface_status, S_IRUGO, batadv_show_iface_status, NULL);
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+BATADV_ATTR_HIF_UINT(elp_interval, bat_v.elp_interval, S_IRUGO | S_IWUSR,
+		     2 * BATADV_JITTER, INT_MAX, NULL);
+#endif
 
 static struct batadv_attribute *batadv_batman_attrs[] = {
 	&batadv_attr_mesh_iface,
 	&batadv_attr_iface_status,
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	&batadv_attr_elp_interval,
+#endif
 	NULL,
 };
 
-- 
2.7.0.rc3

