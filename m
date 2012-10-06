Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat,  6 Oct 2012 21:11:23 +0200
Message-Id: <1349550683-22892-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1349550683-22892-1-git-send-email-ordex@autistici.org>
References: <1349550683-22892-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batctl: add DAT runtime switch support
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

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 man/batctl.8 | 4 ++++
 sys.c        | 6 ++++++
 sys.h        | 1 +
 3 files changed, 11 insertions(+)

diff --git a/man/batctl.8 b/man/batctl.8
index 250e461..4359411 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -66,6 +66,10 @@ If no parameter is given the current bridge loop avoidance setting is displayed.
 or disable the bridge loop avoidance. Bridge loop avoidance support has to be enabled when compiling the module otherwise
 this option won't be available.
 .br
+.IP "\fBdistributed_arp_table\fP|\fBdat\fP [\fB0\fP|\fB1\fP]"
+If no parameter is given the current distributed arp table setting is displayed. Otherwise the parameter is used to
+enable or disable the distributed arp table.
+.br
 .IP "\fBvis_mode|vm\fP [\fBclient|server\fP]\fP"
 If no parameter is given the current vis mode is displayed otherwise the parameter is used to set the vis mode.
 .br
diff --git a/sys.c b/sys.c
index 4c2d6a5..d4d2175 100644
--- a/sys.c
+++ b/sys.c
@@ -69,6 +69,12 @@ const struct settings_data batctl_settings[BATCTL_SETTINGS_NUM] = {
 		.params = sysfs_param_enable,
 	},
 	{
+		.opt_long = "distributed_arp_table",
+		.opt_short = "dat",
+		.sysfs_name = "distributed_arp_table",
+		.params = sysfs_param_enable,
+	},
+	{
 		.opt_long = "vis_mode",
 		.opt_short = "vm",
 		.sysfs_name = "vis_mode",
diff --git a/sys.h b/sys.h
index 1fc473e..40b64b1 100644
--- a/sys.h
+++ b/sys.h
@@ -35,6 +35,7 @@ enum batctl_settings_list {
 	BATCTL_SETTINGS_ORIG_INTERVAL,
 	BATCTL_SETTINGS_AP_ISOLATION,
 	BATCTL_SETTINGS_BLA,
+	BATCTL_SETTINGS_DAT,
 	BATCTL_SETTINGS_VIS_MODE,
 	BATCTL_SETTINGS_AGGREGATION,
 	BATCTL_SETTINGS_BONDING,
-- 
1.7.12

