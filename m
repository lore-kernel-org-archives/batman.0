Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed,  9 May 2012 09:50:45 +0200
Message-Id: <1336549845-13765-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: use DBG_ALL in log_level sysfs
	definition
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

Each time a new log level is added the developer must change either the DBG_ALL
enum definition and the hard coded value in the bat_sysfs.c for the log_level
attribute max value. This is extremely error prone.
With this patch the code directly uses DBG_ALL in the sysfs definition

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 bat_sysfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index 6ba3d89..dc1edbe 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -445,7 +445,7 @@ BAT_ATTR_SIF_UINT(gw_sel_class, S_IRUGO | S_IWUSR, 1, TQ_MAX_VALUE,
 static BAT_ATTR(gw_bandwidth, S_IRUGO | S_IWUSR, show_gw_bwidth,
 		store_gw_bwidth);
 #ifdef CONFIG_BATMAN_ADV_DEBUG
-BAT_ATTR_SIF_UINT(log_level, S_IRUGO | S_IWUSR, 0, 31, NULL);
+BAT_ATTR_SIF_UINT(log_level, S_IRUGO | S_IWUSR, 0, DBG_ALL, NULL);
 #endif
 
 static struct bat_attribute *mesh_attrs[] = {
-- 
1.7.9.4

