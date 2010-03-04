Return-Path: <post@tiwoc.de>
Message-ID: <4B8FA44B.3020808@tiwoc.de>
Date: Thu, 04 Mar 2010 13:15:07 +0100
From: Daniel Seither <post@tiwoc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH] batctl: include ping -R in manpage
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This patch adds documentation for the ping -R option to the batctl manpage.

Signed-off-by: Daniel Seither <post@tiwoc.de>
---
Index: batctl/man/batctl.8
===================================================================
--- batctl/man/batctl.8	(revision 1579)
+++ batctl/man/batctl.8	(working copy)
@@ -126,14 +126,15 @@
 Otherwise the parameter is used to enable or disable packet
 aggregation.
 .br
-.IP "\fBping\fP|\fBp\fP [\fB\-c \fP\fIcount\fP][\fB\-i \fP\fIinterval\fP][\fB\-t \fP\fItime\fP] \fIMAC_address\fP|\fIbat\-host_name\fP"
+.IP "\fBping\fP|\fBp\fP [\fB\-c \fP\fIcount\fP][\fB\-i \fP\fIinterval\fP][\fB\-t \fP\fItime\fP][\fB\-R\fP] \fIMAC_address\fP|\fIbat\-host_name\fP"
 Layer 2 ping of a MAC address or bat\-host name.  batctl will try to
 find the bat\-host name if the given parameter was not a MAC
 address. The "\-c" option tells batctl how man pings should be sent
 before the program exits. Without the "\-c" option batctl will continue
 pinging without end. Use CTRL + C to stop it.  With "\-i" and "\-t"
 you can set the default interval between pings and the timeout time
-for replies, both in seconds.
+for replies, both in seconds. When run with "\-R", the route taken by
+the ping messages will be recorded.
 .br
 .IP "\fBtraceroute\fP|\fBtr\fP  [\fB\-n\fP] \fIMAC_address\fP|\fIbat\-host_name\fP"
 Layer 2 traceroute to a MAC address or bat\-host name. batctl will try
