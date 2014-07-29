Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 30 Jul 2014 01:14:58 +0200
Message-Id: <1406675698-20416-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1406675698-20416-1-git-send-email-linus.luessing@web.de>
References: <1406675698-20416-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 2/2] batctl: adding mcast flags debugfs
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

This patch adds an option to retrieve the per originator multicast
flags table.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---

Changes in v2:
* header_lines for 'mcast_flags' increased from 2 to 6
* Example updated to more verbose, 6 lines debugfs header output
* (kept order for the noted manpage section as it wasn't alphabetically
   orderd in the first place - instead keeping the previous "logical"
   order - 'mcast' after 'nc')

 README       |   34 ++++++++++++++++++++++++++++++++++
 debug.c      |    6 ++++++
 debug.h      |    1 +
 functions.c  |    1 +
 man/batctl.8 |    3 +++
 5 files changed, 45 insertions(+)

diff --git a/README b/README
index c5e3575..08c8e98 100644
--- a/README
+++ b/README
@@ -425,6 +425,40 @@ display or modify the multicast mode setting
 
 Usage: batctl multicast_mode|mm [0|1]
 
+batctl mcast_flags
+=================
+
+display the local D.A.T. cache
+
+Usage batctl mcast_flags|mf
+
+Example:
+
+Multicast flags (own flags: [U..])
+* Bridged [U]				+
+* No IGMP/MLD Querier [4/6]:		-
+* Shadowing IGMP/MLD Querier [4/6]:	-
+-------------------------------------------
+       Originator Flags
+02:04:64:a4:39:c4 [...]
+02:04:64:a4:39:c1 [U46]
+02:04:64:a4:39:c3 [...]
+
+where:
+- Originator: the MAC address of the originating (primary interface)
+		batman-adv node
+- Flags: multicast flags of the according node
+- U: wants all unsnoopable multicast traffic, meaning other nodes need to always
+	forward any multicast traffic destined to ff02::1 or 224.0.0.0/24 to it
+- 4: wants all IPv4 multicast traffic, meaning other nodes need to always
+	forward any IPv4 multicast traffic to it
+- 6: wants all IPv6 multicast traffic, meaning other nodes need to always
+	forward any IPv6 multicast traffic to it
+
+If a node does not have multicast optimizations available (e.g. old batman-adv
+version or optimizations not compiled in), therefore not announcing any
+multicast tvlv/flags, a '-' will be displayed instead of '[...]'.
+
 batctl aggregation
 ==================
 
diff --git a/debug.c b/debug.c
index dfcf3c3..6be3506 100644
--- a/debug.c
+++ b/debug.c
@@ -78,6 +78,12 @@ const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM] = {
 		.debugfs_name = "nc_nodes",
 		.header_lines = 0,
 	},
+	{
+		.opt_long = "mcast_flags",
+		.opt_short = "mf",
+		.debugfs_name = "mcast_flags",
+		.header_lines = 6,
+	},
 };
 
 static void debug_table_usage(int debug_table)
diff --git a/debug.h b/debug.h
index 76d5e68..6ea32a4 100644
--- a/debug.h
+++ b/debug.h
@@ -38,6 +38,7 @@ enum batctl_debug_tables {
 	BATCTL_TABLE_BLA_BACKBONES,
 	BATCTL_TABLE_DAT,
 	BATCTL_TABLE_NETWORK_CODING_NODES,
+	BATCTL_TABLE_MCAST_FLAGS,
 	BATCTL_TABLE_NUM,
 };
 
diff --git a/functions.c b/functions.c
index 251e616..7636e85 100644
--- a/functions.c
+++ b/functions.c
@@ -68,6 +68,7 @@ const char *fs_compile_out_param[] = {
 	batctl_debug_tables[BATCTL_TABLE_BLA_BACKBONES].debugfs_name,
 	batctl_debug_tables[BATCTL_TABLE_DAT].debugfs_name,
 	batctl_debug_tables[BATCTL_TABLE_NETWORK_CODING_NODES].debugfs_name,
+	batctl_debug_tables[BATCTL_TABLE_MCAST_FLAGS].debugfs_name,
 	NULL,
 };
 
diff --git a/man/batctl.8 b/man/batctl.8
index 66c28bb..6c5b244 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -227,6 +227,9 @@ List of debug tables:
 .RS 10
 \- nc_nodes|nn (compile time option)
 .RE
+.RS 10
+\- mcast_flags|mf (compile time option)
+.RE
 .RE
 .br
 .IP "\fBtranslate\fP|\fBt\fP \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP"
-- 
1.7.10.4

