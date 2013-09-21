Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 Sep 2013 16:31:17 +0200
Message-Id: <1379773877-6299-4-git-send-email-sven@narfation.org>
In-Reply-To: <1379773877-6299-1-git-send-email-sven@narfation.org>
References: <1379773877-6299-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/4] alfred: Add manpage stubs
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
Cc: Sven Eckelmann <sven@narfation.org>

manpages are a soft requirement for many distributions and it is a nice feature
for the end users. The stubs are only the restructured version of the README
but provides a start for more useful manpages.

Reported-by: Braden Aran <bradenaran@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile             |   4 ++
 man/alfred.8         | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++
 vis/Makefile         |   4 ++
 vis/man/batadv-vis.8 | 116 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 260 insertions(+)
 create mode 100644 man/alfred.8
 create mode 100644 vis/man/batadv-vis.8

diff --git a/Makefile b/Makefile
index ec9dc11..7b13d7b 100644
--- a/Makefile
+++ b/Makefile
@@ -21,6 +21,7 @@
 # alfred build
 BINARY_NAME = alfred
 OBJ = main.o server.o client.o netsock.o send.o recv.o hash.o unix_sock.o util.o debugfs.o batadv_query.o
+MANPAGE = man/alfred.8
 
 # alfred flags and options
 CFLAGS += -pedantic -Wall -W -std=gnu99 -fno-strict-aliasing -MD -MP
@@ -47,6 +48,7 @@ LINK.o = $(Q_LD)$(CC) $(CFLAGS) $(LDFLAGS) $(TARGET_ARCH)
 # standard install paths
 PREFIX = /usr/local
 SBINDIR = $(PREFIX)/sbin
+MANDIR = $(PREFIX)/share/man
 
 # try to generate revision
 REVISION= $(shell	if [ -d .git ]; then \
@@ -79,7 +81,9 @@ clean:	$(VIS_CLEAN)
 
 install: $(BINARY_NAME) $(VIS_INSTALL)
 	$(MKDIR) $(DESTDIR)$(SBINDIR)
+	$(MKDIR) $(DESTDIR)$(MANDIR)/man8
 	$(INSTALL) -m 0755 $(BINARY_NAME) $(DESTDIR)$(SBINDIR)
+	$(INSTALL) -m 0644 $(MANPAGE) $(DESTDIR)$(MANDIR)/man8
 
 vis-install:
 	$(MAKE) -C vis install
diff --git a/man/alfred.8 b/man/alfred.8
new file mode 100644
index 0000000..5eb48aa
--- /dev/null
+++ b/man/alfred.8
@@ -0,0 +1,136 @@
+.\"                                      Hey, EMACS: -*- nroff -*-
+.\" First parameter, NAME, should be all caps
+.\" Second parameter, SECTION, should be 1-8, maybe w/ subsection
+.\" other parameters are allowed: see man(7), man(1)
+.TH "ALFRED" "8" "Sep 21, 2013" "Linux" "Almighty Lightweight Fact Remote Exchange Daemon"
+.\" Please adjust this date whenever revising the manpage.
+.\"
+.\" Some roff macros, for reference:
+.\" .nh        disable hyphenation
+.\" .hy        enable hyphenation
+.\" .ad l      left justify
+.\" .ad b      justify to both left and right margins
+.\" .nf        disable filling
+.\" .fi        enable filling
+.\" .br        insert line break
+.\" .sp <n>    insert n+1 empty lines
+.\" for manpage-specific macros, see man(7)
+.\" --------------------------------------------------------------------------
+.\" Process this file with
+.\" groff -man alfred.8 -Tutf8
+.\" Retrieve format warnings with
+.\" man --warnings alfred.8 > /dev/null
+.\" --------------------------------------------------------------------------
+.ad l
+.SH NAME
+alfred \- Almighty Lightweight Fact Remote Exchange Daemon
+.SH SYNOPSIS
+.B alfred [\fIoptions\fP]
+.br
+.SH DESCRIPTION
+alfred is a user space daemon for distributing arbitrary local information over
+the mesh/network in a decentralized fashion. This data can be anything which
+appears to be useful - originally designed to replace the batman-adv
+visualization (vis), you may distribute hostnames, phone books, administration
+information, DNS information, the local weather forecast ...
+.PP
+alfred runs as daemon in the background of the system. A user may insert
+information by using the alfred binary on the command line, or use special
+programs to communicate with alfred (done via unix sockets). alfred then takes
+care of distributing the local information to other alfred servers on other
+nodes. This is done via IPv6 link-local multicast, and does not require any
+configuration. A user can request data from alfred, and will receive the
+information available from all alfred servers in the network.
+.PP
+.PP
+.SH OPTIONS
+.TP
+\fB\-v\fP, \fB\-\-version\fP
+Print the version
+.TP
+\fB\-h\fP, \fB\-\-help\fP
+Display a brief help message.
+.
+.SH CLIENT OPTIONS
+.TP
+\fB\-s\fP, \fB\-\-set\-data\fP \fIdata\-type\fP
+Sets new data to distribute from stdin for the supplied data type (0\-255).
+
+Note that 0 - 63 are reserved (please send an e-mail to the authors if you want
+to register a datatype), and can not be used on the commandline. Information
+must be periodically written again to alfred, otherwise it will timeout and
+alfred will forget about it (after 10 minutes).
+.TP
+\fB\-r\fP, \fB\-\-request\fP \fIdata\-type\fP
+Collect data from the network and prints it on the network
+.TP
+\fB\-V\fP, \fB\-\-req\-version\fP \fIversion\fP
+Specify the data version set for \fB\-s\fP
+
+Skipping the parameter entirely has the same effect as setting the parameter
+to 0 ('\fB\-V\fP 0').
+.TP
+\fB\-M\fP, \fB\-\-modeswitch\fP \fImode\fP
+.nf
+\fBmaster\fP
+    Switch daemon to mode master
+\fBslave\fP
+    Switch daemon to mode slave
+.fi
+.
+.SH SERVER OPTIONS
+.TP
+\fB\-i\fP, \fB\-\-interface\fP \fiface\fP
+Specify the interface to listen on
+.TP
+\fB\-b\fP \fIbatmanif\fP
+Specify the batman-adv interface configured on the system (default: bat0).
+Use 'none' to disable the batman-adv based best server selection.
+
+The \fB\-b\fP option is optional, and only needed if you run alfred on a
+batman-adv interface not called bat0, or if you don't use batman-adv at all
+(use '\fB\-b\fP none'). In this case, alfred will still work but will not be
+able to find the best next master server based on metrics.
+.TP
+\fB\-m\fP, \fB\-\-master\fP
+Start up the daemon in master mode, which accepts data from slaves and synces
+it with other masters.
+
+alfred servers may either run as master or slave in the network. Masters will
+announce their status via broadcast, so that slaves can find them. Slaves will
+then send their data to their nearest master (based on TQ). Masters will
+exchange their data (which they have received from slaves or got on their own)
+with other masters. By using masters and slaves, overhead can be reduced while
+still keeping redundancy (by having multiple masters). Obviously, at least one
+master must be present in the network to let any data exchange happen. Also
+having all nodes in master mode is possible (for maximum decentrality and
+overhead).
+.
+.SH EXAMPLES
+Start an alfred server listening on bridge br0 (assuming that this bridge
+includes the batman interface bat0):
+.br
+\fB     alfred \-i br0 \-m\fP
+.br
+
+Send data to the alfred server and store it under id 65:
+.br
+\fB     cat /etc/hostname | alfred -s 65\fP
+
+Retreive all data stored as id 65 from all connected alfred servers:
+.br
+\fB     alfred -r 65\fP
+.nf
+     { "fe:f1:00:00:01:01", "OpenWRT\-node\-1\\x0a" },
+     { "fe:f1:00:00:02:01", "OpenWRT\-node\-2\\x0a" },
+     { "fe:f1:00:00:03:01", "OpenWRT\-node\-3\\x0a" },
+.fi
+.br
+.
+.SH SEE ALSO
+.BR batadv-vis (8),
+.BR batctl (8)
+.SH AUTHOR
+alfred was written by Simon Wunderlich <siwu@hrz.tu-chemnitz.de> and Sven Eckelmann <sven@open-mesh.com>.
+.PP
+This manual page was written by Simon Wunderlich <siwu@hrz.tu-chemnitz.de> and Sven Eckelmann <sven@open-mesh.com>.
diff --git a/vis/Makefile b/vis/Makefile
index 4db27d9..586c1cd 100644
--- a/vis/Makefile
+++ b/vis/Makefile
@@ -21,6 +21,7 @@
 # batadv-vis build
 BINARY_NAME = batadv-vis
 OBJ = vis.o debugfs.o
+MANPAGE = man/batadv-vis.8
 
 # batadv-vis flags and options
 CFLAGS += -pedantic -Wall -W -std=gnu99 -fno-strict-aliasing -MD -MP
@@ -47,6 +48,7 @@ LINK.o = $(Q_LD)$(CC) $(CFLAGS) $(LDFLAGS) $(TARGET_ARCH)
 # standard install paths
 PREFIX = /usr/local
 SBINDIR = $(PREFIX)/sbin
+MANDIR = $(PREFIX)/share/man
 
 # try to generate revision
 REVISION= $(shell	if [ -d ../.git ]; then \
@@ -72,7 +74,9 @@ clean:
 
 install: $(BINARY_NAME)
 	$(MKDIR) $(DESTDIR)$(SBINDIR)
+	$(MKDIR) $(DESTDIR)$(MANDIR)/man8
 	$(INSTALL) -m 0755 $(BINARY_NAME) $(DESTDIR)$(SBINDIR)
+	$(INSTALL) -m 0644 $(MANPAGE) $(DESTDIR)$(MANDIR)/man8
 
 # load dependencies
 DEP = $(OBJ:.o=.d)
diff --git a/vis/man/batadv-vis.8 b/vis/man/batadv-vis.8
new file mode 100644
index 0000000..dfa2604
--- /dev/null
+++ b/vis/man/batadv-vis.8
@@ -0,0 +1,116 @@
+.\"                                      Hey, EMACS: -*- nroff -*-
+.\" First parameter, NAME, should be all caps
+.\" Second parameter, SECTION, should be 1-8, maybe w/ subsection
+.\" other parameters are allowed: see man(7), man(1)
+.TH "BATADV-VIS" "8" "Sep 21, 2013" "Linux" "batman-adv visualization server"
+.\" Please adjust this date whenever revising the manpage.
+.\"
+.\" Some roff macros, for reference:
+.\" .nh        disable hyphenation
+.\" .hy        enable hyphenation
+.\" .ad l      left justify
+.\" .ad b      justify to both left and right margins
+.\" .nf        disable filling
+.\" .fi        enable filling
+.\" .br        insert line break
+.\" .sp <n>    insert n+1 empty lines
+.\" for manpage-specific macros, see man(7)
+.\" --------------------------------------------------------------------------
+.\" Process this file with
+.\" groff -man batadv-vis.8 -Tutf8
+.\" Retrieve format warnings with
+.\" man --warnings batadv-vis.8 > /dev/null
+.\" --------------------------------------------------------------------------
+.ad l
+.SH NAME
+batadv\-vis \- batman-adv visualization server
+.SH SYNOPSIS
+.B batadv\-vis [\fIoptions\fP]
+.br
+.SH DESCRIPTION
+batadv\-vis can be used to visualize your batman-adv mesh network. It read the
+neighbor information and local client table and distributes this information via
+alfred in the network. By gathering this local information, any vis node can get
+the whole picture of the network.
+.PP
+.PP
+.SH OPTIONS
+.TP
+\fB\-v\fP, \fB\-\-version\fP
+Print the version
+.TP
+\fB\-h\fP, \fB\-\-help\fP
+Display a brief help message.
+.TP
+\fB\-i\fP, \fB\-\-interface\fP \fIiface\fP
+Specify the batman-adv interface configured on the system (default: bat0)
+.TP
+\fB\-s\fP, \fB\-\-server\fP
+Start up in server mode. This server will read the neighbor and client
+information from batman-adv every 10 seconds and set it in alfred via unix
+socket. The alfred server must run too to get this information set.
+.TP
+\fB\-f\fP, \fB\-\-format\fP \fIformat\fP
+Specify the output format for client mode (either "json" or "dot")
+.
+.SH EXAMPLES
+Start an batadv\-vis server which is fetching the information for bat0:
+.br
+\fB     batadv\-vis \-i bat0 \-s\fP
+.br
+
+To get a graphviz-compatible vis output:
+.br
+\fB     batadv-vis\fP
+.nf
+     digraph {
+             subgraph "cluster_fe:f0:00:00:04:01" {
+                     "fe:f0:00:00:04:01"
+             }
+             "fe:f0:00:00:04:01" -> "fe:f0:00:00:05:01" [label="1.000"]
+             "fe:f0:00:00:04:01" -> "fe:f0:00:00:03:01" [label="1.004"]
+             "fe:f0:00:00:04:01" -> "00:00:43:05:00:04" [label="TT"]
+             "fe:f0:00:00:04:01" -> "fe:f1:00:00:04:01" [label="TT"]
+             subgraph "cluster_fe:f0:00:00:02:01" {
+                     "fe:f0:00:00:02:01"
+             }
+             "fe:f0:00:00:02:01" -> "fe:f0:00:00:03:01" [label="1.000"]
+             "fe:f0:00:00:02:01" -> "fe:f0:00:00:01:01" [label="1.008"]
+             "fe:f0:00:00:02:01" -> "fe:f0:00:00:08:01" [label="1.000"]
+             "fe:f0:00:00:02:01" -> "fe:f1:00:00:02:01" [label="TT"]
+             "fe:f0:00:00:02:01" -> "00:00:43:05:00:02" [label="TT"]
+             subgraph "cluster_fe:f0:00:00:08:01" {
+                     "fe:f0:00:00:08:01"
+             }
+     [...]
+     }
+.fi
+.br
+
+To get a json vis output:
+.br
+\fB     batadv-vis -f json\fP
+.nf
+     { "primary" : "fe:f0:00:00:04:01" }
+     { "router" : "fe:f0:00:00:04:01", "neighbor" : "fe:f0:00:00:05:01", "label" : "1.000" }
+     { "router" : "fe:f0:00:00:04:01", "neighbor" : "fe:f0:00:00:03:01", "label" : "1.008" }
+     { "router" : "fe:f0:00:00:04:01", "gateway" : "00:00:43:05:00:04", "label" : "TT" }
+     { "router" : "fe:f0:00:00:04:01", "gateway" : "fe:f1:00:00:04:01", "label" : "TT" }
+     { "primary" : "fe:f0:00:00:02:01" }
+     { "router" : "fe:f0:00:00:02:01", "neighbor" : "fe:f0:00:00:03:01", "label" : "1.000" }
+     { "router" : "fe:f0:00:00:02:01", "neighbor" : "fe:f0:00:00:01:01", "label" : "1.016" }
+     { "router" : "fe:f0:00:00:02:01", "neighbor" : "fe:f0:00:00:08:01", "label" : "1.000" }
+     { "router" : "fe:f0:00:00:02:01", "gateway" : "fe:f1:00:00:02:01", "label" : "TT" }
+     { "router" : "fe:f0:00:00:02:01", "gateway" : "00:00:43:05:00:02", "label" : "TT" }
+     { "primary" : "fe:f0:00:00:08:01" }
+     [...]
+.fi
+.br
+.
+.SH SEE ALSO
+.BR alfred (8),
+.BR batctl (8)
+.SH AUTHOR
+batadv\-vis was written by Simon Wunderlich <siwu@hrz.tu-chemnitz.de>.
+.PP
+This manual page was written by Simon Wunderlich <siwu@hrz.tu-chemnitz.de> and Sven Eckelmann <sven@open-mesh.com>.
-- 
1.8.4.rc3

