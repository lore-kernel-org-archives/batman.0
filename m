Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 21 Nov 2011 23:53:08 +0100
Message-Id: <1321915993-29312-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1321915993-29312-1-git-send-email-ordex@autistici.org>
References: <1321915993-29312-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 2/7] batman-adv: add a new log level for
	DAT-ARP debugging
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

A new log level has been added to concentrate messages regarding DAT: ARP
snooping, requests, response and DHT related messages.
The new log level is named DBG_ARP

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Reviewed-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 bat_sysfs.c |    2 +-
 main.h      |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index c25492f..ec2e437 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -390,7 +390,7 @@ BAT_ATTR_UINT(gw_sel_class, S_IRUGO | S_IWUSR, 1, TQ_MAX_VALUE,
 static BAT_ATTR(gw_bandwidth, S_IRUGO | S_IWUSR, show_gw_bwidth,
 		store_gw_bwidth);
 #ifdef CONFIG_BATMAN_ADV_DEBUG
-BAT_ATTR_UINT(log_level, S_IRUGO | S_IWUSR, 0, 7, NULL);
+BAT_ATTR_UINT(log_level, S_IRUGO | S_IWUSR, 0, 15, NULL);
 #endif
 
 static struct bat_attribute *mesh_attrs[] = {
diff --git a/main.h b/main.h
index 464439f..e706193 100644
--- a/main.h
+++ b/main.h
@@ -120,7 +120,8 @@ enum dbg_level {
 	DBG_BATMAN = 1 << 0,
 	DBG_ROUTES = 1 << 1, /* route added / changed / deleted */
 	DBG_TT	   = 1 << 2, /* translation table operations */
-	DBG_ALL    = 7
+	DBG_ARP    = 1 << 3, /* snooped arp messages / dht operations */
+	DBG_ALL    = 15
 };
 
 
-- 
1.7.3.4

