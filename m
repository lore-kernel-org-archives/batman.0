Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon, 24 Feb 2014 05:11:43 +0100
Message-Id: <1393215104-28184-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1393215104-28184-1-git-send-email-linus.luessing@web.de>
References: <1393215104-28184-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batctl: add switch for setting
	multicast_mode
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

This patch adds a switch for the new multicast_mode setting in
batman-adv.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 README       |    7 +++++++
 man/batctl.8 |    4 ++++
 sys.c        |    6 ++++++
 sys.h        |    1 +
 4 files changed, 18 insertions(+)

diff --git a/README b/README
index 5af95c8..69c7a07 100644
--- a/README
+++ b/README
@@ -392,6 +392,13 @@ Usage: batctl network_coding|nc [0|1]
 
 Note that network coding requires a working promiscuous mode on all interfaces.
 
+batctl multicast_mode
+=====================
+
+display or modify the multicast mode setting
+
+Usage: batctl multicast_mode|mm [0|1]
+
 batctl aggregation
 ==================
 
diff --git a/man/batctl.8 b/man/batctl.8
index 2fe5941..a8e8868 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -88,6 +88,10 @@ disable fragmentation.
 If no parameter is given the current network coding mode setting is displayed. Otherwise the parameter is used to enable or
 disable network coding.
 .br
+.IP "\fBmulticast_mode\fP|\fBmm\fP [\fB0\fP|\fB1\fP]"
+If no parameter is given the current multicast mode setting is displayed. Otherwise the parameter is used to enable or
+disable multicast optimizations (i.e. disabling means always sending own multicast frames via classic flooding).
+.br
 .IP "\fBloglevel\fP|\fBll\fP [\fBlevel\fP[ \fBlevel\fP[ \fBlevel\fP]] \fB...\fP]"
 If no parameter is given the current log level settings are displayed otherwise the parameter(s) is/are used to set the log
 level. Level 'none' disables all verbose logging. Level 'batman' enables messages related to routing / flooding / broadcasting.
diff --git a/sys.c b/sys.c
index 5cebf52..45fb656 100644
--- a/sys.c
+++ b/sys.c
@@ -96,6 +96,12 @@ const struct settings_data batctl_settings[BATCTL_SETTINGS_NUM] = {
 		.opt_short = "nc",
 		.sysfs_name = "network_coding",
 		.params = sysfs_param_enable,
+	},
+	{
+		.opt_long = "multicast_mode",
+		.opt_short = "mm",
+		.sysfs_name = "multicast_mode",
+		.params = sysfs_param_enable,
 	}
 
 };
diff --git a/sys.h b/sys.h
index 2cbbcfb..9016501 100644
--- a/sys.h
+++ b/sys.h
@@ -46,6 +46,7 @@ enum batctl_settings_list {
 	BATCTL_SETTINGS_BONDING,
 	BATCTL_SETTINGS_FRAGMENTATION,
 	BATCTL_SETTINGS_NETWORK_CODING,
+	BATCTL_SETTINGS_MULTICAST_MODE,
 	BATCTL_SETTINGS_NUM,
 };
 
-- 
1.7.10.4

