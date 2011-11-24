Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 24 Nov 2011 23:21:14 +0100
Message-Id: <1322173279-18338-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1322173279-18338-1-git-send-email-ordex@autistici.org>
References: <1322173279-18338-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv4 2/7] batman-adv: add a new log level for
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
---
 README      |    3 ++-
 bat_sysfs.c |    2 +-
 main.h      |    3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 7404c0a..856ca7e 100644
--- a/README
+++ b/README
@@ -224,7 +224,8 @@ abled  during run time. Following log_levels are defined:
 1 - Enable messages related to routing / flooding / broadcasting
 2 - Enable messages related to route added / changed / deleted
 4 - Enable messages related to translation table operations
-7 - Enable all messages
+8 - Enable messaged related to DAT, ARP snooping and parsing
+15 - Enable all messages
 
 The debug output can be changed at runtime  using  the  file
 /sys/class/net/bat0/mesh/log_level. e.g.
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
index 3c58235..5561bf7 100644
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

