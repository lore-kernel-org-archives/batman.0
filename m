Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat,  2 Jan 2010 18:51:45 +0100
Message-Id: <1262454706-6137-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1262454706-6137-1-git-send-email-sven.eckelmann@gmx.de>
References: <1262454706-6137-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batctl: Differentiate between hyphen and
	minus in manpage
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

groff differentiate between minus signs and hyphens. The default option is to
interpret '-' as hyphens (U+2010) and makes it hard to use copy and paste for
options in UTF-8 environments.

See http://lists.debian.org/debian-devel/2003/03/msg01481.html for more
informations.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batctl/man/batctl.8 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batctl/man/batctl.8 b/batctl/man/batctl.8
index 311fca3..304168c 100644
--- a/batctl/man/batctl.8
+++ b/batctl/man/batctl.8
@@ -91,7 +91,7 @@ Layer 2 traceroute mac address or bat\-host name (batctl will try to find bat\-h
 Per default batctl will display all packets that were seen on the given interface(s). The "\-p" options allows to filter certain packet types: 1 displays batman ogm packets only, 2 displays batman icmp packets only, etc. These numbers can be added to filter more than one packet type, e.g. use "\-p 3" to display batman ogm packets and batman icmp packets only. If "\-n" was given batctl will not replace the mac addresses with bat\-host names in the output.
 .br
 .IP "\fBbisect		logfile1 logfile2 .. logfileN\fP"
-Analyzes the logfiles to build a small internal database of all sent sequence numbers and routing table changes. This database can be used to search for routing loops (default action), to trace OGMs of a host (use "-t" to specify the mac address or bat\-host name) throughout the network or to display routing tables of the nodes (use "-r" to specify the mac address or bat\-host name). You can name a specific sequence number or a range using the "-s" option to limit the output's range. Furthermore you can filter the output by specifying an originator (use "-o" to specify the mac address or bat\-host name) to only see data connected to this originator. If "\-n" was given batctl will not replace the mac addresses with bat\-host names in the output.
+Analyzes the logfiles to build a small internal database of all sent sequence numbers and routing table changes. This database can be used to search for routing loops (default action), to trace OGMs of a host (use "\-t" to specify the mac address or bat\-host name) throughout the network or to display routing tables of the nodes (use "\-r" to specify the mac address or bat\-host name). You can name a specific sequence number or a range using the "\-s" option to limit the output's range. Furthermore you can filter the output by specifying an originator (use "\-o" to specify the mac address or bat\-host name) to only see data connected to this originator. If "\-n" was given batctl will not replace the mac addresses with bat\-host names in the output.
 .br
 .SH FILES
 .TP
-- 
1.6.5.7

