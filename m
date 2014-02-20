Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu, 20 Feb 2014 16:00:22 +0100
Message-Id: <1392908422-364-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: add isolation_mark support
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

With this patch it is now possible to set/unset the value
of the isolation_mark used by the Extended Isolation feature
in batman-adv.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 sys.c | 9 +++++++--
 sys.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sys.c b/sys.c
index 5cebf52..fd6e107 100644
--- a/sys.c
+++ b/sys.c
@@ -96,8 +96,13 @@ const struct settings_data batctl_settings[BATCTL_SETTINGS_NUM] = {
 		.opt_short = "nc",
 		.sysfs_name = "network_coding",
 		.params = sysfs_param_enable,
-	}
-
+	},
+	{
+		.opt_long = "isolation_mark",
+		.opt_short = "mark",
+		.sysfs_name = "isolation_mark",
+		.params = NULL,
+	},
 };
 
 static void interface_usage(void)
diff --git a/sys.h b/sys.h
index 2cbbcfb..5633822 100644
--- a/sys.h
+++ b/sys.h
@@ -46,6 +46,7 @@ enum batctl_settings_list {
 	BATCTL_SETTINGS_BONDING,
 	BATCTL_SETTINGS_FRAGMENTATION,
 	BATCTL_SETTINGS_NETWORK_CODING,
+	BATCTL_SETTINGS_ISOLATION_MARK,
 	BATCTL_SETTINGS_NUM,
 };
 
-- 
1.8.5.5

