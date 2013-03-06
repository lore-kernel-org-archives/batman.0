Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Wed,  6 Mar 2013 13:17:58 +0100
Message-Id: <1362572280-17945-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batctl: Add NC runtime switch support
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
 README       | 9 +++++++++
 functions.c  | 1 +
 man/batctl.8 | 4 ++++
 sys.c        | 6 ++++++
 sys.h        | 1 +
 5 files changed, 21 insertions(+)

diff --git a/README b/README
index efdd3cb..2bc085e 100644
--- a/README
+++ b/README
@@ -363,6 +363,15 @@ $  batctl loglevel
 [ ] messages related to bridge loop avoidance (bla)
 [ ] messages related to arp snooping and distributed arp table (dat)
 
+batctl network_coding
+=====================
+
+display or modify the network coding setting
+
+Usage: batctl network_coding|nc [0|1]
+
+Note that network coding requires a working promiscuous mode on all interfaces.
+
 batctl aggregation
 ==================
 
diff --git a/functions.c b/functions.c
index 16acbb5..14fb45e 100644
--- a/functions.c
+++ b/functions.c
@@ -51,6 +51,7 @@ const char *fs_compile_out_param[] = {
 	SYS_LOG_LEVEL,
 	batctl_settings[BATCTL_SETTINGS_BLA].sysfs_name,
 	batctl_settings[BATCTL_SETTINGS_DAT].sysfs_name,
+	batctl_settings[BATCTL_SETTINGS_NETWORK_CODING].sysfs_name,
 	batctl_debug_tables[BATCTL_TABLE_BLA_CLAIMS].debugfs_name,
 	batctl_debug_tables[BATCTL_TABLE_BLA_BACKBONES].debugfs_name,
 	batctl_debug_tables[BATCTL_TABLE_DAT].debugfs_name,
diff --git a/man/batctl.8 b/man/batctl.8
index 7af78e9..533fdb7 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -87,6 +87,10 @@ the bonding mode.
 If no parameter is given the current fragmentation mode setting is displayed. Otherwise the parameter is used to enable or
 disable fragmentation.
 .br
+.IP "\fBnetwork_coding\fP|\fBnc\fP [\fB0\fP|\fB1\fP]"
+If no parameter is given the current network coding mode setting is displayed. Otherwise the parameter is used to enable or
+disable network coding.
+.br
 .IP "\fBloglevel\fP|\fBll\fP [\fBlevel\fP[ \fBlevel\fP[ \fBlevel\fP]] \fB...\fP]"
 If no parameter is given the current log level settings are displayed otherwise the parameter(s) is/are used to set the log
 level. Level 'none' disables all verbose logging. Level 'batman' enables messages related to routing / flooding / broadcasting.
diff --git a/sys.c b/sys.c
index d45d1a2..74a6c65 100644
--- a/sys.c
+++ b/sys.c
@@ -98,6 +98,12 @@ const struct settings_data batctl_settings[BATCTL_SETTINGS_NUM] = {
 		.sysfs_name = "fragmentation",
 		.params = sysfs_param_enable,
 	},
+	{
+		.opt_long = "network_coding",
+		.opt_short = "nc",
+		.sysfs_name = "network_coding",
+		.params = sysfs_param_enable,
+	}
 
 };
 
diff --git a/sys.h b/sys.h
index 5ab4135..a7187af 100644
--- a/sys.h
+++ b/sys.h
@@ -40,6 +40,7 @@ enum batctl_settings_list {
 	BATCTL_SETTINGS_AGGREGATION,
 	BATCTL_SETTINGS_BONDING,
 	BATCTL_SETTINGS_FRAGMENTATION,
+	BATCTL_SETTINGS_NETWORK_CODING,
 	BATCTL_SETTINGS_NUM,
 };
 
-- 
1.8.1.5

