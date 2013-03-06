Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Wed,  6 Mar 2013 13:17:59 +0100
Message-Id: <1362572280-17945-2-git-send-email-martin@hundeboll.net>
In-Reply-To: <1362572280-17945-1-git-send-email-martin@hundeboll.net>
References: <1362572280-17945-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batctl: Add support for the NC nodes
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 README       | 18 ++++++++++++++++++
 debug.c      |  6 ++++++
 debug.h      |  1 +
 functions.c  |  1 +
 man/batctl.8 |  3 +++
 5 files changed, 29 insertions(+)

diff --git a/README b/README
index 2bc085e..f19a081 100644
--- a/README
+++ b/README
@@ -363,6 +363,24 @@ $  batctl loglevel
 [ ] messages related to bridge loop avoidance (bla)
 [ ] messages related to arp snooping and distributed arp table (dat)
 
+batctl nc_nodes
+===============
+
+display the neighbor nodes considered for network coded packets
+
+Usage: batctl nc_nodes|nn
+
+Example:
+
+Node:      fe:fe:00:0a:01:01
+ Ingoing:  fe:fe:00:0a:01:01 fe:fe:00:0a:02:01
+ Outgoing: fe:fe:00:0a:01:01 fe:fe:00:0a:02:01
+
+Where:
+- Node is the neighbor
+- Ingoing is the neighbors this neighbor can hear packets from
+- Outgoing is the neighbors that can hear packets from this neighbor
+
 batctl network_coding
 =====================
 
diff --git a/debug.c b/debug.c
index 9b9e385..c879603 100644
--- a/debug.c
+++ b/debug.c
@@ -76,6 +76,12 @@ const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM] = {
 		.debugfs_name = "dat_cache",
 		.header_lines = 2,
 	},
+	{
+		.opt_long = "nc_nodes",
+		.opt_short = "nn",
+		.debugfs_name = "nc_nodes",
+		.header_lines = 0,
+	},
 };
 
 void debug_table_usage(int debug_table)
diff --git a/debug.h b/debug.h
index 60dd9a8..2427ece 100644
--- a/debug.h
+++ b/debug.h
@@ -33,6 +33,7 @@ enum batctl_debug_tables {
 	BATCTL_TABLE_BLA_CLAIMS,
 	BATCTL_TABLE_BLA_BACKBONES,
 	BATCTL_TABLE_DAT,
+	BATCTL_TABLE_NETWORK_CODING_NODES,
 	BATCTL_TABLE_NUM,
 };
 
diff --git a/functions.c b/functions.c
index 14fb45e..a025395 100644
--- a/functions.c
+++ b/functions.c
@@ -55,6 +55,7 @@ const char *fs_compile_out_param[] = {
 	batctl_debug_tables[BATCTL_TABLE_BLA_CLAIMS].debugfs_name,
 	batctl_debug_tables[BATCTL_TABLE_BLA_BACKBONES].debugfs_name,
 	batctl_debug_tables[BATCTL_TABLE_DAT].debugfs_name,
+	batctl_debug_tables[BATCTL_TABLE_NETWORK_CODING_NODES].debugfs_name,
 	NULL,
 };
 
diff --git a/man/batctl.8 b/man/batctl.8
index 533fdb7..6f8d210 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -204,6 +204,9 @@ List of debug tables:
 .RS 10
 \- dat_cache|dc (compile time option)
 .RE
+.RS 10
+\- nc_nodes|nn (compile time option)
+.RE
 .RE
 .br
 .IP "\fBtranslate\fP|\fBt\fP \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIPv4_address\fP"
-- 
1.8.1.5

