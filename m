Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 25 Feb 2014 14:59:44 +0100
Message-Id: <1393336784-1094-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv3] batctl: add isolation_mark support
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

With this patch it is now possible to set/unset the value
of the isolation_mark used by the Extended Isolation feature
in batman-adv.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---

Change from v2:
- added section in README

Change from v1:
- added section in man page


 README       | 13 +++++++++++++
 man/batctl.8 | 20 ++++++++++++++++++++
 sys.c        |  9 +++++++--
 sys.h        |  1 +
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 5af95c8..a4507b7 100644
--- a/README
+++ b/README
@@ -399,6 +399,19 @@ display or modify the packet aggregation setting
 
 Usage: batctl aggregation|ag [0|1]
 
+batctl isolation_mark
+=====================
+
+display or modify the isolation mark.
+This value is used by Extended Isolation feature.
+
+Usage: batctl isolation_mark|mark $value[/0x$mask]
+
+Example 1: batctl mark 0x00000001/0xffffffff
+Example 2: batctl mark 0x00040000/0xffff0000
+Example 3: batctl mark 16
+Example 4: batctl mark 0x0f
+
 batctl translocal
 =================
 
diff --git a/man/batctl.8 b/man/batctl.8
index 2fe5941..b808293 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -151,6 +151,26 @@ least XX TQ better than the currently selected gateway (XX has to be a number be
 .RE
 .RE
 .br
+.IP "\fBisolation_mark\fP|\fBmark\fP"
+If no parameter is given the current isolation mark value is displayed.
+Otherwise the parameter is used to set or unset the isolation mark used by the
+Extended Isolation feature.
+.br
+The input is supposed to be of the form $value/$mask, where $value can be any
+32bit long integer (expressed in decimal or hex base) and $mask is a generic
+bitmask (expressed in hex base) that selects the bits to take into consideration
+from $value. It is also possible to enter the input using only $value and in
+this case the full bitmask is used by default.
+
+.br
+.br
+Example 1: 0x00000001/0xffffffff
+.br
+Example 2: 0x00040000/0xffff0000
+.br
+Example 3: 16 or 0x0F
+.br
+.br
 .PP
 .I \fBdebug tables:
 .IP
diff --git a/sys.c b/sys.c
index 5cebf52..fd6e107 100644
--- a/sys.c
+++ b/sys.c
@@ -96,8 +96,13 @@ const struct settings_data batctl_settings[BATCTL_SETTINGS_NUM] = {
 		.opt_short = "nc",
 		.sysfs_name = "network_coding",
 		.params = sysfs_param_enable,
-	}
-
+	},
+	{
+		.opt_long = "isolation_mark",
+		.opt_short = "mark",
+		.sysfs_name = "isolation_mark",
+		.params = NULL,
+	},
 };
 
 static void interface_usage(void)
diff --git a/sys.h b/sys.h
index 2cbbcfb..5633822 100644
--- a/sys.h
+++ b/sys.h
@@ -46,6 +46,7 @@ enum batctl_settings_list {
 	BATCTL_SETTINGS_BONDING,
 	BATCTL_SETTINGS_FRAGMENTATION,
 	BATCTL_SETTINGS_NETWORK_CODING,
+	BATCTL_SETTINGS_ISOLATION_MARK,
 	BATCTL_SETTINGS_NUM,
 };
 
-- 
1.8.4.5

