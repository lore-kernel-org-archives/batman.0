Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 20 Apr 2012 04:36:49 +0800
Message-Id: <1334867810-12487-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: fix man page originator entry
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Reported-by: Jo-Philipp Wich <jow@openwrt.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 man/batctl.8 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/man/batctl.8 b/man/batctl.8
index 036412b..4f2e1c6 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -59,7 +59,7 @@ protocol.
 If no parameter is given or the first parameter is neither "add" nor "del" the current interface settings are displayed. In order to add or delete interfaces specify "add" or "del" as first argument and append the interface names you wish to add or delete.
 .br
 .IP "\fBoriginators\fP|\fBo\fP    [\fB\-w\fP [\fI\interval\fP]][\fB\-n\fP][\fB\-t\fP]"
-Once started batctl will display the list of announced gateways in the network. Use the "\-w" option to let batctl refresh the list every second or add a number to let it refresh at a custom interval in seconds (with optional decimal places). If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output. The "\-t" option filters all originators that have not been seen for the specified amount of seconds (with optional decimal places) from the output.
+Once started batctl will display the list of announced originators in the network. Use the "\-w" option to let batctl refresh the list every second or add a number to let it refresh at a custom interval in seconds (with optional decimal places). If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output. The "\-t" option filters all originators that have not been seen for the specified amount of seconds (with optional decimal places) from the output.
 .br
 .IP "\fBinterval\fP|\fBit\fP      [\fBorig_interval\fP]"
 If no parameter is given the current originator interval setting is displayed otherwise the parameter is used to set the originator interval. The interval is in units of milliseconds.
-- 
1.7.9.1

