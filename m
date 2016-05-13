Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri, 13 May 2016 17:30:16 +0200
Message-Id: <1463153416-6569-2-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1463153416-6569-1-git-send-email-linus.luessing@c0d3.blue>
References: <1463153416-6569-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv4 2/2] batctl: adding mcast flags debugfs
	table
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

From: Linus Lüssing <linus.luessing@web.de>

This patch adds an option to retrieve the per originator multicast
flags table.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---

Changes in v4:
* rebase to current master (no conflicts)

Changes in v3:
* updated mcast_flags example in README file

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
index b5de8a6..f92bc26 100644
--- a/README
+++ b/README
@@ -426,6 +426,40 @@ display or modify the multicast mode setting
 
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
+Multicast flags (own flags: [U46])
+* Bridged [U]                           U
+* No IGMP/MLD Querier [4/6]:            ./.
+* Shadowing IGMP/MLD Querier [4/6]:     4/6
+-------------------------------------------
+       Originator Flags
+02:04:64:a4:39:c1 [U..]
+02:04:64:a4:39:c2 [U..]
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
index 3db3ed9..5b280cb 100644
--- a/debug.c
+++ b/debug.c
@@ -84,6 +84,12 @@ const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM] = {
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
index df65f50..46e8c3c 100644
--- a/debug.h
+++ b/debug.h
@@ -40,6 +40,7 @@ enum batctl_debug_tables {
 	BATCTL_TABLE_BLA_BACKBONES,
 	BATCTL_TABLE_DAT,
 	BATCTL_TABLE_NETWORK_CODING_NODES,
+	BATCTL_TABLE_MCAST_FLAGS,
 	BATCTL_TABLE_NUM,
 };
 
diff --git a/functions.c b/functions.c
index be8f8b0..97a6dbd 100644
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
index f8955d0..05f68d3 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -236,6 +236,9 @@ List of debug tables:
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

