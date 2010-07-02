Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Fri,  2 Jul 2010 02:10:27 +0200
Message-Id: <1278029427-23533-4-git-send-email-linus.luessing@web.de>
In-Reply-To: <1278029427-23533-1-git-send-email-linus.luessing@web.de>
References: <1278029427-23533-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Add manpage entry for -w [num] and
	-t [num]
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

This patch documents the new ability to specifiy a custom refresh
interval and the new originator timeout filter in the manpage.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 batctl/man/batctl.8 |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/batctl/man/batctl.8 b/batctl/man/batctl.8
index 8089b24..ccd3546 100644
--- a/batctl/man/batctl.8
+++ b/batctl/man/batctl.8
@@ -56,8 +56,8 @@ protocol.
 .IP "\fBinterface\fP|\fBif\fP     [\fBadd\fP|\fBdel iface(s)\fP]"
 If no parameter is given or the first parameter is neither "add" nor "del" the current interface settings are displayed. In order to add or delete interfaces specify "add" or "del" as first argument and append the interface names you wish to add or delete.
 .br
-.IP "\fBoriginators\fP|\fBo\fP    [\fB\-w\fP][\fB\-n\fP]"
-Once started batctl will display the list of announced gateways in the network. Use the "\-w" option to let batctl refresh the list every second. If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output.
+.IP "\fBoriginators\fP|\fBo\fP    [\fB\-w\fP [\fI\interval\fP]][\fB\-n\fP][\fB\-t\fP]"
+Once started batctl will display the list of announced gateways in the network. Use the "\-w" option to let batctl refresh the list every second or add a number to let it refresh at a custom interval in seconds (with optional decimal places). If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output. The "\-t" option filters all originators that have not been seen for the specified amount of seconds (with optional decimal places) from the output.
 .br
 .IP "\fBinterval\fP|\fBit\fP      [\fBorig_interval\fP]"
 If no parameter is given the current originator interval setting is displayed otherwise the parameter is used to set the originator interval. The interval is in units of milliseconds.
@@ -110,14 +110,14 @@ chooses the gateway with the best link quality but switches to another gateway a
 .RE
 .RE
 .br
-.IP "\fBgateways|gwl\fP     [\fB\-w\fP][\fB\-n\fP]"
-Once started batctl will display the list of announced gateways in the network. Use the "\-w" option to let batctl refresh the list every second. If "\-n" was given batctl will not replace the mac addresses with bat\-host names in the output.
+.IP "\fBgateways|gwl\fP     [\fB\-w\fP [\fI\interval\fP]][\fB\-n\fP]"
+Once started batctl will display the list of announced gateways in the network. Use the "\-w" option to let batctl refresh the list every second or add a number to let it refresh at a custom interval in seconds (with optional decimal places). If "\-n" was given batctl will not replace the mac addresses with bat\-host names in the output.
 .br
-.IP "\fBtranslocal\fP|\fBtl\fP    [\fB\-w\fP][\fB\-n\fP]"
-Display the local translation table. batctl will refresh the list every second if the "\-w" option was given. Use "\-n" to let batctl not replace the MAC addresses with bat\-host names in the output.
+.IP "\fBtranslocal\fP|\fBtl\fP    [\fB\-w\fP [\fI\interval\fP]][\fB\-n\fP]"
+Display the local translation table. batctl will refresh the list every second if the "\-w" option was given or add a number to let it refresh at a custom interval in seconds (with optional decimal places). Use "\-n" to let batctl not replace the MAC addresses with bat\-host names in the output.
 .br
-.IP "\fBtransglobal\fP|\fBtg\fP   [\fB\-w\fP][\fB\-n\fP]"
-Display the global translation table. batctl will refresh the list every second if the "\-w" option was given. Use "\-n" to let batctl not replace the MAC addresses with bat\-host names in the output.
+.IP "\fBtransglobal\fP|\fBtg\fP   [\fB\-w\fP [\fI\interval\fP]][\fB\-n\fP]"
+Display the global translation table. batctl will refresh the list every second if the "\-w" option was given or add a number to let it refresh at a custom interval in seconds (with optional decimal places). Use "\-n" to let batctl not replace the MAC addresses with bat\-host names in the output.
 .br
 .IP "\fBvis_mode|vm\fP	  [\fBmode\fP]\fP"
 If no parameter is given the current vis mode is displayed otherwise the parameter is used to set the vis mode.
-- 
1.5.6.5

