Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat,  6 Oct 2012 21:11:21 +0200
Message-Id: <1349550683-22892-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batctl: add support for the DAT local
	table
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

With the introduction of DAT in batman-adv, another table is now exported
through debugfs. This patch adds the possibility to print it

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 README       | 18 ++++++++++++++++++
 debug.c      |  5 +++++
 debug.h      |  1 +
 man/batctl.8 |  3 +++
 4 files changed, 27 insertions(+)

diff --git a/README b/README
index 03d36c4..8ee2c9f 100644
--- a/README
+++ b/README
@@ -408,6 +408,24 @@ where:
 
 If any of the flags is not enabled, a '.' will substitute its symbol.
 
+batctl datcache
+=================
+
+display the local D.A.T. cache
+
+Usage batctl datcache|dc
+
+Example:
+
+Distributed ARP Table (bat0):
+          IPv4             MAC           last-seen
+ *     172.100.0.1 b6:9b:d0:ea:b1:13      0:00
+
+where:
+- IPv4 is the IP address of a client in the mesh network
+- MAC is the MAC address associated to that IP
+- last-seen is the amount of time since last refresh of this entry
+
 batctl vis_mode
 =================
 
diff --git a/debug.c b/debug.c
index 9b5146f..163bfc9 100644
--- a/debug.c
+++ b/debug.c
@@ -64,6 +64,11 @@ const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM] = {
 		.opt_short = "bbt",
 		.debugfs_name = "bla_backbone_table",
 	},
+	{
+		.opt_long = "datcache",
+		.opt_short = "dc",
+		.debugfs_name = "dat_cache",
+	},
 };
 
 void debug_table_usage(int debug_table)
diff --git a/debug.h b/debug.h
index 6068c2c..4e935cb 100644
--- a/debug.h
+++ b/debug.h
@@ -31,6 +31,7 @@ enum batctl_debug_tables {
 	BATCTL_TABLE_TRANSGLOBAL,
 	BATCTL_TABLE_BLA_CLAIMS,
 	BATCTL_TABLE_BLA_BACKBONES,
+	BATCTL_TABLE_DAT,
 	BATCTL_TABLE_NUM,
 };
 
diff --git a/man/batctl.8 b/man/batctl.8
index ab02e9a..310b43f 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -187,6 +187,9 @@ List of debug tables:
 .RS 10
 \- backbonetable|bbt (compile time option)
 .RE
+.RS 10
+\- datcache|dc (compile time option)
+.RE
 .RE
 .br
 .IP "\fBstatistics\fP|\fBs\fP"
-- 
1.7.12

