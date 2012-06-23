Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 23 Jun 2012 18:40:12 +0200
Message-Id: <1340469612-6543-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1340469612-6543-1-git-send-email-lindner_marek@yahoo.de>
References: <1340469612-6543-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batctl: beef up man page
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

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 README       |   14 ++--
 bisect.c     |    4 +-
 debug.c      |    8 +-
 main.c       |    4 +-
 man/batctl.8 |  251 +++++++++++++++++++++++++++++++---------------------------
 ping.c       |    4 +-
 sys.c        |   12 ++--
 tcpdump.c    |    4 +-
 traceroute.c |    4 +-
 9 files changed, 160 insertions(+), 145 deletions(-)

diff --git a/README b/README
index b06aacf..86c9f20 100644
--- a/README
+++ b/README
@@ -81,8 +81,8 @@ batctl ping
 
 Sends a Layer 2 batman-adv ping to check round trip time and connectivity
 
-Usage: batctl ping [options] mac|bat-host
-options:
+Usage: batctl ping [parameters] mac|bat-host
+parameters:
          -c ping packet count
          -h print this help
          -i interval in seconds
@@ -106,7 +106,7 @@ batctl traceroute
 Traceroute sends 3 packets to each hop, awaits the answers and prints out the
 response times.
 
-Usage: batctl traceroute [options] mac|bat-host
+Usage: batctl traceroute [parameters] mac|bat-host
 
 Example:
 
@@ -128,8 +128,8 @@ batctl tcpdump
 
 tcpdump layer 2 and/or layer 3 traffic on the given interface
 
-Usage: batctl tcpdump [options] interface [interface]
-options:
+Usage: batctl tcpdump [parameters] interface [interface]
+parameters:
          -c compat filter - only display packets matching own compat version (14)
          -h print this help
          -n don't convert addresses to bat-host names
@@ -182,8 +182,8 @@ bat-host name) to only see data connected to  this  originator.  If  "-n"  was
 given batctl will not replace the mac addresses with bat-host names in the
 output.
 
-Usage: batctl bisect [options] <file1> <file2> .. <fileN>
-options:
+Usage: batctl bisect [parameters] <file1> <file2> .. <fileN>
+parameters:
          -h print this help
          -l run a loop detection of given mac address or bat-host (default)
          -n don't convert addresses to bat-host names
diff --git a/bisect.c b/bisect.c
index b505b1a..8bc9c65 100644
--- a/bisect.c
+++ b/bisect.c
@@ -37,8 +37,8 @@ static struct bat_node *curr_bat_node = NULL;
 
 static void bisect_usage(void)
 {
-	printf("Usage: batctl bisect [options] <file1> <file2> .. <fileN>\n");
-	printf("options:\n");
+	printf("Usage: batctl bisect [parameters] <file1> <file2> .. <fileN>\n");
+	printf("parameters:\n");
 	printf(" \t -h print this help\n");
 	printf(" \t -l run a loop detection of given mac address or bat-host (default)\n");
 	printf(" \t -n don't convert addresses to bat-host names\n");
diff --git a/debug.c b/debug.c
index 8aa36c2..9b5146f 100644
--- a/debug.c
+++ b/debug.c
@@ -68,9 +68,9 @@ const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM] = {
 
 void debug_table_usage(int debug_table)
 {
-	printf("Usage: batctl [options] %s|%s\n",
+	printf("Usage: batctl [options] %s|%s [parameters]\n",
 	       batctl_debug_tables[debug_table].opt_long, batctl_debug_tables[debug_table].opt_short);
-	printf("options:\n");
+	printf("parameters:\n");
 	printf(" \t -h print this help\n");
 	printf(" \t -n don't replace mac addresses with bat-host names\n");
 	printf(" \t -w [interval] watch mode - refresh the table continuously\n");
@@ -152,8 +152,8 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 
 static void log_usage(void)
 {
-	printf("Usage: batctl [options] log \n");
-	printf("options:\n");
+	printf("Usage: batctl [options] log [parameters]\n");
+	printf("parameters:\n");
 	printf(" \t -h print this help\n");
 	printf(" \t -n don't replace mac addresses with bat-host names\n");
 }
diff --git a/main.c b/main.c
index ae0b3d2..1086f8e 100644
--- a/main.c
+++ b/main.c
@@ -47,10 +47,10 @@ void print_usage(void)
 {
 	int i, opt_indent;
 
-	printf("Usage: batctl [options] command|debug table \n");
+	printf("Usage: batctl [options] command|debug table [parameters]\n");
 	printf("options:\n");
 	printf(" \t-m mesh interface (default 'bat0')\n");
-	printf(" \t-h print this help (or 'batctl <command|debug table> -h' for the specific help)\n");
+	printf(" \t-h print this help (or 'batctl <command|debug table> -h' for the parameter help)\n");
 	printf(" \t-v print version\n");
 	printf("\n");
 
diff --git a/man/batctl.8 b/man/batctl.8
index af30b67..1a11508 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -23,30 +23,23 @@
 .SH NAME
 batctl \- B.A.T.M.A.N. advanced control and management tool
 .SH SYNOPSIS
-.B batctl
-.I [\fIbatctl\-options\fP]\ \fIcommand\fP\ [\fIcommand\-options\fP]
+.B batctl [\fIoptions\fP]\ \fIcommand\fP|\fIdebug\ table\fP\ [\fIparameters\fP]
 .br
 .SH DESCRIPTION
-batctl offers a convenient way to configure the batman\-adv kernel
-module as well as displaying debug information such as originator
-tables, translation tables and the debug log. In combination with a
-bat\-hosts file batctl allows the use of host names instead of MAC
-addresses.
+batctl offers a convenient way to configure the batman\-adv kernel module as well as displaying debug information
+such as originator tables, translation tables and the debug log. In combination with a bat\-hosts file batctl allows
+the use of host names instead of MAC addresses.
 .PP
-B.A.T.M.A.N. advanced operates on layer 2. Thus all hosts
-participating in the virtual switched network are transparently
-connected together for all protocols above layer 2. Therefore the
-common diagnosis tools do not work as expected. To overcome these
-problems batctl contains the commands \fBping\fP, \fBtraceroute\fP,
-\fBtcpdump\fP which provide similar functionality to the normal
-\fBping\fP(1), \fBtraceroute\fP(1), \fBtcpdump\fP(1) commands, but
-modified to layer 2 behaviour or using the B.A.T.M.A.N. advanced
-protocol.
+B.A.T.M.A.N. advanced operates on layer 2. Thus all hosts participating in the virtual switched network are transparently
+connected together for all protocols above layer 2. Therefore the common diagnosis tools do not work as expected. To
+overcome these problems batctl contains the commands \fBping\fP, \fBtraceroute\fP, \fBtcpdump\fP which provide similar
+functionality to the normal \fBping\fP(1), \fBtraceroute\fP(1), \fBtcpdump\fP(1) commands, but modified to layer 2
+behaviour or using the B.A.T.M.A.N. advanced protocol.
 .PP
 .PP
 .SH OPTIONS
 .TP
-.I \fBbatctl\-options:
+.I \fBoptions:
 \-m     specify mesh interface (default 'bat0')
 .br
 \-h     print general batctl help
@@ -55,23 +48,58 @@ protocol.
 .br
 .TP
 .I \fBcommands:
-.IP "\fBinterface\fP|\fBif\fP     [\fBadd\fP|\fBdel iface(s)\fP]"
-If no parameter is given or the first parameter is neither "add" nor "del" the current interface settings are displayed. In order to add or delete interfaces specify "add" or "del" as first argument and append the interface names you wish to add or delete.
+.IP "\fBinterface\fP|\fBif\fP [\fBadd\fP|\fBdel iface(s)\fP]"
+If no parameter is given or the first parameter is neither "add" nor "del" the current interface settings are displayed.
+In order to add or delete interfaces specify "add" or "del" as first argument and append the interface names you wish to
+add or delete. Multiple interfaces can be specified.
+.br
+.IP "\fBorig_interval\fP|\fBit\fP [\fBinterval\fP]"
+If no parameter is given the current originator interval setting is displayed otherwise the parameter is used to set the
+originator interval. The interval is in units of milliseconds.
+.br
+.IP "\fBap_isolation\fP|\fBap\fP [\fB0\fP|\fB1\fP]"
+If no parameter is given the current ap isolation setting is displayed. Otherwise the parameter is used to enable or
+disable ap isolation.
+.br
+.IP "\fBbridge_loop_avoidance\fP|\fBbl\fP [\fB0\fP|\fB1\fP]"
+If no parameter is given the current bridge loop avoidance setting is displayed. Otherwise the parameter is used to enable
+or disable the bridge loop avoidance. Bridge loop avoidance support has to be enabled when compiling the module otherwise
+this option won't be available.
 .br
-.IP "\fBoriginators\fP|\fBo\fP    [\fB\-w\fP [\fI\interval\fP]][\fB\-n\fP][\fB\-t\fP]"
-Once started batctl will display the list of announced originators in the network. Use the "\-w" option to let batctl refresh the list every second or add a number to let it refresh at a custom interval in seconds (with optional decimal places). If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output. The "\-t" option filters all originators that have not been seen for the specified amount of seconds (with optional decimal places) from the output.
+.IP "\fBvis_mode|vm\fP [\fBclient|server\fP]\fP"
+If no parameter is given the current vis mode is displayed otherwise the parameter is used to set the vis mode.
+.br
+.IP "\fBaggregation\fP|\fBag\fP [\fB0\fP|\fB1\fP]"
+If no parameter is given the current aggregation setting is displayed. Otherwise the parameter is used to enable or disable
+OGM packet aggregation.
 .br
-.IP "\fBinterval\fP|\fBit\fP      [\fBorig_interval\fP]"
-If no parameter is given the current originator interval setting is displayed otherwise the parameter is used to set the originator interval. The interval is in units of milliseconds.
+.IP "\fBbonding\fP|\fBb\fP [\fB0\fP|\fB1\fP]"
+If no parameter is given the current bonding mode setting is displayed. Otherwise the parameter is used to enable or disable
+the bonding mode.
 .br
-.IP "\fBloglevel\fP|\fBll\fP      [\fBlevel\fP[ \fBlevel\fP[ \fBlevel\fP]] \fB...\fP]"
-If no parameter is given the current log level settings are displayed otherwise the parameter(s) is/are used to set the log level. Level 'none' disables all verbose logging. Level 'batman' enables messages related to routing / flooding / broadcasting. Level 'routes' enables messages related to routes being added / changed / deleted. Level 'tt' enables messages related to translation table operations. Level 'bla' enables messages related to the bridge loop avoidance. Level 'all' enables all messages. The messages are sent to the batman-adv debug log. Use \fBbatctl log\fP to see them. Make sure to have debugging output enabled when compiling the module otherwise the output as well as the loglevel options won't be available.
+.IP "\fBfragmentation\fP|\fBf\fP [\fB0\fP|\fB1\fP]"
+If no parameter is given the current fragmentation mode setting is displayed. Otherwise the parameter is used to enable or
+disable fragmentation.
 .br
-.IP "\fBlog\fP|\fBl\fP            [\fB\-n\fP]\fP"
-batctl will read the batman-adv debug log which has to be compiled into the kernel module. If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output.
+.IP "\fBloglevel\fP|\fBll\fP [\fBlevel\fP[ \fBlevel\fP[ \fBlevel\fP]] \fB...\fP]"
+If no parameter is given the current log level settings are displayed otherwise the parameter(s) is/are used to set the log
+level. Level 'none' disables all verbose logging. Level 'batman' enables messages related to routing / flooding / broadcasting.
+Level 'routes' enables messages related to routes being added / changed / deleted. Level 'tt' enables messages related to
+translation table operations. Level 'bla' enables messages related to the bridge loop avoidance. Level 'all' enables all
+messages. The messages are sent to the batman-adv debug log. Use \fBbatctl log\fP to retrieve it. Make sure to have debugging
+output enabled when compiling the module otherwise the output as well as the loglevel options won't be available.
 .br
-.IP "\fBgw_mode|gw\fP       [\fBoff\fP|\fBclient\fP|\fBserver\fP] [\fBsel_class|bandwidth\fP]\fP"
-If no parameter is given the current gateway mode is displayed otherwise the parameter is used to set the gateway mode. The second (optional) argument specifies the selection class (if 'client' was the first argument) or the gateway bandwidth (if 'server' was the first argument). If the node is a server this parameter is used to inform other nodes in the network about this node's internet connection bandwidth. Just enter any number (optionally followed by "kbit" or "mbit") and the batman-adv module will guess your appropriate gateway class. Use "/" to separate the down\(hy and upload rates. You can omit the upload rate and the module will assume an upload of download / 5.
+.IP "\fBlog\fP|\fBl\fP [\fB\-n\fP]\fP"
+batctl will read the batman-adv debug log which has to be compiled into the kernel module. If "\-n" is given batctl will not
+replace the MAC addresses with bat\-host names in the output.
+.br
+.IP "\fBgw_mode|gw\fP [\fBoff\fP|\fBclient\fP|\fBserver\fP] [\fBsel_class|bandwidth\fP]\fP"
+If no parameter is given the current gateway mode is displayed otherwise the parameter is used to set the gateway mode. The
+second (optional) argument specifies the selection class (if 'client' was the first argument) or the gateway bandwidth (if
+'server' was the first argument). If the node is a server this parameter is used to inform other nodes in the network about
+this node's internet connection bandwidth. Just enter any number (optionally followed by "kbit" or "mbit") and the batman-adv
+module will guess your appropriate gateway class. Use "/" to separate the down\(hy and upload rates. You can omit the upload
+rate and the module will assume an upload of download / 5.
 .RS 17
 default: 2000 \-> gateway class 20
 .RE
@@ -86,7 +114,8 @@ examples: 5000 \-> gateway class 49
  5mbit/1mbit
 .RE
 .RS 7
-If the node is a gateway client the parameter will decide which criterias to consider when the batman-adv module has to choose between different internet connections announced by the aforementioned servers.
+If the node is a gateway client the parameter will decide which criterias to consider when the batman-adv module has to choose
+between different internet connections announced by the aforementioned servers.
 .RE
 .RS 17
 default: 20 \-> late switch (TQ 20)
@@ -108,63 +137,62 @@ chooses the gateway with the best link quality but switches to another gateway a
 .RE
  XX \-> late switch connection
 .RS 7
-chooses the gateway with the best link quality but switches to another gateway as soon as a better one is found which is at least XX TQ better than the currently selected gateway (XX has to be a number between 3 and 256).
+chooses the gateway with the best link quality but switches to another gateway as soon as a better one is found which is at
+least XX TQ better than the currently selected gateway (XX has to be a number between 3 and 256).
 .RE
 .RE
 .br
-.IP "\fBgateways|gwl\fP     [\fB\-w\fP [\fI\interval\fP]][\fB\-n\fP]"
-Once started batctl will display the list of announced gateways in the network. Use the "\-w" option to let batctl refresh the list every second or add a number to let it refresh at a custom interval in seconds (with optional decimal places). If "\-n" was given batctl will not replace the mac addresses with bat\-host names in the output.
-.br
-.IP "\fBtranslocal\fP|\fBtl\fP    [\fB\-w\fP [\fI\interval\fP]][\fB\-n\fP]"
-Display the local translation table. batctl will refresh the list every second if the "\-w" option was given or add a number to let it refresh at a custom interval in seconds (with optional decimal places). Use "\-n" to let batctl not replace the MAC addresses with bat\-host names in the output.
-.br
-.IP "\fBtransglobal\fP|\fBtg\fP   [\fB\-w\fP [\fI\interval\fP]][\fB\-n\fP]"
-Display the global translation table. batctl will refresh the list every second if the "\-w" option was given or add a number to let it refresh at a custom interval in seconds (with optional decimal places). Use "\-n" to let batctl not replace the MAC addresses with bat\-host names in the output.
-.br
-.IP "\fBclaimtable\fP|\fBcl\fP   [\fB\-w\fP [\fI\interval\fP]][\fB\-n\fP]"
-Display the bridge loop avoidance claim table. batctl will refresh the list every second if the "\-w" option was given or add a number to let it refresh at a custom interval in seconds (with optional decimal places). Use "\-n" to let batctl not replace the MAC addresses with bat\-host names in the output.
-.br
-.IP "\fBbackbonetable\fP|\fBbbl\fP   [\fB\-w\fP [\fI\interval\fP]][\fB\-n\fP]"
-Display the bridge loop avoidance backbone table. batctl will refresh the list every second if the "\-w" option was given or add a number to let it refresh at a custom interval in seconds (with optional decimal places). Use "\-n" to let batctl not replace the MAC addresses with bat\-host names in the output.
-.br
-.IP "\fBvis_mode|vm\fP	  [\fBmode\fP]\fP"
-If no parameter is given the current vis mode is displayed otherwise the parameter is used to set the vis mode.
-.br
-.IP "\fBvis_data|vd dot\fP  [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-T\fP|\fB\-\-no-TT\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
-Display the visualisation data in graphviz \fBdot\fP(1) format. If
-"\-\-numbers" or "\-n" is given batctl will not replace the MAC
-addresses with bat-host names in the output. With "\-\-no-TT" or
-"\-T" the TT entries are not displayed, so the pure mesh topology can
-be seen. With "\-\-no-2nd" or "\-2" a dot cluster is not formed around
-primary and secondary addresses from the same device.
-.br
-.IP "\fBvis_data|vd json\fP [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-T\fP|\fB\-\-no-TT\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
-Display the visualisation data in JSON format. If "\-\-numbers" or
-"\-n" is given batctl will not replace the MAC addresses with bat-host
-names in the output. With "\-\-no-TT" or "\-T" the TT entries are
-not displayed, so the pure mesh topology can be seen. With
-"\-\-no-2nd" or "\-2" a dot cluster is not formed around primary and
-secondary addresses from the same device.
-.br
-.IP "\fBaggregation\fP|\fBag\fP   [\fB1\fP|\fB0\fP]"
-If no parameter is given the current aggregation setting is displayed. Otherwise the parameter is used to enable or disable packet aggregation.
+.IP "\fBvis_data|vd dot\fP [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-T\fP|\fB\-\-no-TT\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
+Display the visualisation data in graphviz \fBdot\fP(1) format. If "\-\-numbers" or "\-n" is given batctl will not replace
+the MAC addresses with bat-host names in the output. With "\-\-no-TT" or "\-T" the TT entries are not displayed, so the pure
+mesh topology can be seen. With "\-\-no-2nd" or "\-2" a dot cluster is not formed around primary and secondary addresses
+from the same device.
 .br
-.IP "\fBbonding\fP|\fBb\fP        [\fB1\fP|\fB0\fP]"
-If no parameter is given the current bonding mode setting is displayed. Otherwise the parameter is used to enable or disable the bonding mode.
-.br
-.IP "\fBbridge_loop_avoidance\fP|\fBbl\fP        [\fB1\fP|\fB0\fP]"
-If no parameter is given the current bridge loop avoidance setting is displayed. Otherwise the parameter is used to enable or disable the bridge loop avoidance.
-.br
-.IP "\fBfragmentation\fP|\fBf\fP   [\fB1\fP|\fB0\fP]"
-If no parameter is given the current fragmentation mode setting is displayed. Otherwise the parameter is used to enable or disable fragmentation.
-.br
-.IP "\fBap_isolation\fP|\fBap\fP   [\fB1\fP|\fB0\fP]"
-If no parameter is given the current ap isolation setting is displayed. Otherwise the parameter is used to enable or disable ap isolation.
+.PP
+.I \fBdebug tables:
+.IP
+The batman-adv kernel module comes with a variety of debug tables containing various information about the state of the mesh
+seen by each individual node. These tables are exported via debugfs and easily accessible via batctl. You will need debugfs
+support compiled into your kernel and preferrably have mounted the debugfs to a well-known mountpoint. If debugfs is not
+mounted batctl will attempt to do this step for you.
+
+All of the debug tables support the following options:
+.RS 10
+\-w     refresh the list every second or add a number to let it refresh at a custom interval in seconds (with optional decimal places)
+.RE
+.RS 10
+\-n     do not replace the MAC addresses with bat\-host names in the output
+.RE
+
+.RS 7
+The originator table also supports the "\-t" filter option to remove all originators from the output that have not been seen
+for the specified amount of seconds (with optional decimal places).
+
+List of debug tables:
+.RS 10
+\- originators|o
+.RE
+.RS 10
+\- gateways|gwl
+.RE
+.RS 10
+\- translocal|tl
+.RE
+.RS 10
+\- transglobal|tg
+.RE
+.RS 10
+\- claimtable|cl (compile time option)
+.RE
+.RS 10
+\- backbonetable|bbt (compile time option)
+.RE
+.RE
 .br
 .IP "\fBstatistics\fP|\fBs\fP"
-Retrieve traffic counters from batman-adv kernel module. The output may vary depending on which features have
-been compiled into the kernel module. For example, if the distributed arp table (short: dat) wasn't selected
-as an option at compile time its counters won't be shown.
+Retrieve traffic counters from batman-adv kernel module. The output may vary depending on which features have been compiled
+into the kernel module. For example, if the distributed arp table (short: dat) wasn't selected as an option at compile time
+its counters won't be shown.
 .br
 Each module subsystem has its own counters which are indicated by their prefixes:
 .RS 15
@@ -180,24 +208,19 @@ dat - distributed arp table counters
 All counters without a prefix concern payload (pure user data) traffic.
 .RE
 .br
-.IP "\fBping\fP|\fBp\fP           [\fB\-c count\fP][\fB\-i interval\fP][\fB\-t time\fP][\fB\-R\fP] \fBMAC_address\fP|\fBbat\-host_name\fP"
-Layer 2 ping of a MAC address or bat\-host name.  batctl will try to
-find the bat\-host name if the given parameter was not a MAC
-address. The "\-c" option tells batctl how man pings should be sent
-before the program exits. Without the "\-c" option batctl will continue
-pinging without end. Use CTRL + C to stop it.  With "\-i" and "\-t"
-you can set the default interval between pings and the timeout time
-for replies, both in seconds. When run with "\-R", the route taken by
-the ping messages will be recorded.
+.IP "\fBping\fP|\fBp\fP [\fB\-c count\fP][\fB\-i interval\fP][\fB\-t time\fP][\fB\-R\fP] \fBMAC_address\fP|\fBbat\-host_name\fP"
+Layer 2 ping of a MAC address or bat\-host name.  batctl will try to find the bat\-host name if the given parameter was
+not a MAC address. The "\-c" option tells batctl how man pings should be sent before the program exits. Without the "\-c"
+option batctl will continue pinging without end. Use CTRL + C to stop it.  With "\-i" and "\-t" you can set the default
+interval between pings and the timeout time for replies, both in seconds. When run with "\-R", the route taken by the ping
+messages will be recorded.
 .br
-.IP "\fBtraceroute\fP|\fBtr\fP    [\fB\-n\fP] \fBMAC_address\fP|\fBbat\-host_name\fP"
-Layer 2 traceroute to a MAC address or bat\-host name. batctl will try
-to find the bat\-host name if the given parameter was not a MAC
-address. batctl will send 3 packets to each host and display the
-response time. If "\-n" is given batctl will not replace the MAC
-addresses with bat\-host names in the output.
+.IP "\fBtraceroute\fP|\fBtr\fP [\fB\-n\fP] \fBMAC_address\fP|\fBbat\-host_name\fP"
+Layer 2 traceroute to a MAC address or bat\-host name. batctl will try to find the bat\-host name if the given parameter
+was not a MAC address. batctl will send 3 packets to each host and display the response time. If "\-n" is given batctl will
+not replace the MAC addresses with bat\-host names in the output.
 .br
-.IP "\fBtcpdump\fP|\fBtd\fP       [\fB\-c\fP][\fB\-n\fP][\fB\-p filter\fP][\fB\-x filter\fP] \fBinterface ...\fP"
+.IP "\fBtcpdump\fP|\fBtd\fP [\fB\-c\fP][\fB\-n\fP][\fB\-p filter\fP][\fB\-x filter\fP] \fBinterface ...\fP"
 batctl will display all packets that are seen on the given interface(s). A variety of options to filter the output
 are available: To only print packets that match the compatibility number of batctl specify the "\-c" (compat filter)
 option. If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output. To filter
@@ -231,27 +254,21 @@ except specified). The following packet types are available:
 Example: batctl td <interface> -p 129 \-> only display batman ogm packets and non batman packets
 .RE
 .br
-.IP "\fBbisect\fP           [\fB\-l MAC\fP][\fB\-t MAC\fP][\fB\-r MAC\fP][\fB\-s min\fP [\fB\- max\fP]][\fB\-o MAC\fP][\fB\-n\fP] \fBlogfile1\fP [\fBlogfile2\fP ... \fBlogfileN\fP]"
-Analyses the logfiles to build a small internal database of all sent
-sequence numbers and routing table changes. This database can then be
-analyzed in a number of different ways. With "\-l" the database can be
-used to search for routing loops. Use "\-t" to trace OGMs of a host
-throughout the network. Use "\-r" to display routing tables of the
-nodes. The option "\-s" can be used to limit the output to a range of
-sequence numbers, between min and max, or to one specific sequence
-number, min. Furthermore using "\-o" you can filter the output to a
-specified originator. If "\-n" is given batctl will not replace the
-MAC addresses with bat\-host names in the output.
+.IP "\fBbisect\fP [\fB\-l MAC\fP][\fB\-t MAC\fP][\fB\-r MAC\fP][\fB\-s min\fP [\fB\- max\fP]][\fB\-o MAC\fP][\fB\-n\fP] \fBlogfile1\fP [\fBlogfile2\fP ... \fBlogfileN\fP]"
+Analyses the logfiles to build a small internal database of all sent sequence numbers and routing table changes. This
+database can then be analyzed in a number of different ways. With "\-l" the database can be used to search for routing
+loops. Use "\-t" to trace OGMs of a host throughout the network. Use "\-r" to display routing tables of the nodes. The
+option "\-s" can be used to limit the output to a range of sequence numbers, between min and max, or to one specific
+sequence number, min. Furthermore using "\-o" you can filter the output to a specified originator. If "\-n" is given
+batctl will not replace the MAC addresses with bat\-host names in the output.
 .br
 .SH FILES
 .TP
 .I "\fBbat-hosts\fP"
-This file is similar to the /etc/hosts file. You can write one MAC
-address and one host name per line. batctl will search for bat-hosts
-in /etc, your home directory and the current directory. The found data
-is used to match MAC address to your provided host name or replace MAC
-addresses in debug output and logs. Host names are much easier to
-remember than MAC addresses.
+This file is similar to the /etc/hosts file. You can write one MAC address and one host name per line. batctl will search
+for bat-hosts in /etc, your home directory and the current directory. The found data is used to match MAC address to your
+provided host name or replace MAC addresses in debug output and logs. Host names are much easier to remember than MAC
+addresses.
 .SH SEE ALSO
 .BR ping (1),
 .BR traceroute (1),
@@ -259,9 +276,7 @@ remember than MAC addresses.
 .BR dmesg (1),
 .BR dot (1)
 .SH AUTHOR
-batctl was written by Andreas Langer <an.langer@gmx.de> and Marek
-Lindner <lindner_marek@yahoo.de>.
+batctl was written by Andreas Langer <an.langer@gmx.de> and Marek Lindner <lindner_marek@yahoo.de>.
 .PP
-This manual page was written by Simon Wunderlich
-<siwu@hrz.tu-chemnitz.de>, Marek Lindner <lindner_marek@yahoo.de> and
+This manual page was written by Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Marek Lindner <lindner_marek@yahoo.de> and
 Andrew Lunn <andrew@lunn.ch>
diff --git a/ping.c b/ping.c
index 85b4137..9f64a8f 100644
--- a/ping.c
+++ b/ping.c
@@ -44,8 +44,8 @@ char is_aborted = 0;
 
 void ping_usage(void)
 {
-	printf("Usage: batctl ping [options] mac|bat-host \n");
-	printf("options:\n");
+	printf("Usage: batctl [options] ping [parameters] mac|bat-host \n");
+	printf("parameters:\n");
 	printf(" \t -c ping packet count \n");
 	printf(" \t -h print this help\n");
 	printf(" \t -i interval in seconds\n");
diff --git a/sys.c b/sys.c
index 63315fe..caeb908 100644
--- a/sys.c
+++ b/sys.c
@@ -97,8 +97,8 @@ const struct settings_data batctl_settings[BATCTL_SETTINGS_NUM] = {
 
 static void interface_usage(void)
 {
-	printf("Usage: batctl interface [options] [add|del iface(s)] \n");
-	printf("options:\n");
+	printf("Usage: batctl [options] interface [parameters] [add|del iface(s)]\n");
+	printf("parameters:\n");
 	printf(" \t -h print this help\n");
 }
 
@@ -237,8 +237,8 @@ err:
 
 static void log_level_usage(void)
 {
-	printf("Usage: batctl [options] loglevel [level[ level[ level]]...]\n");
-	printf("options:\n");
+	printf("Usage: batctl [options] loglevel [parameters] [level[ level[ level]]...]\n");
+	printf("parameters:\n");
 	printf(" \t -h print this help\n");
 	printf("levels:\n");
 	printf(" \t none    Debug logging is disabled\n");
@@ -324,7 +324,7 @@ out:
 
 void settings_usage(int setting)
 {
-	printf("Usage: batctl [options] %s|%s",
+	printf("Usage: batctl [options] %s|%s [parameters]",
 	       (char *)batctl_settings[setting].opt_long, (char *)batctl_settings[setting].opt_short);
 
 	if (batctl_settings[setting].params == sysfs_param_enable)
@@ -334,7 +334,7 @@ void settings_usage(int setting)
 	else
 		printf("\n");
 
-	printf("options:\n");
+	printf("parameters:\n");
 	printf(" \t -h print this help\n");
 }
 
diff --git a/tcpdump.c b/tcpdump.c
index cbae9bb..1cd9a4e 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -59,8 +59,8 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 
 static void tcpdump_usage(void)
 {
-	printf("Usage: batctl tcpdump [options] interface [interface]\n");
-	printf("options:\n");
+	printf("Usage: batctl tcpdump [parameters] interface [interface]\n");
+	printf("parameters:\n");
 	printf(" \t -c compat filter - only display packets matching own compat version (%i)\n", BATADV_COMPAT_VERSION);
 	printf(" \t -h print this help\n");
 	printf(" \t -n don't convert addresses to bat-host names\n");
diff --git a/traceroute.c b/traceroute.c
index 31f77b0..c1aaad8 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -43,8 +43,8 @@
 
 void traceroute_usage(void)
 {
-	printf("Usage: batctl traceroute [options] mac|bat-host \n");
-	printf("options:\n");
+	printf("Usage: batctl [options] traceroute [parameters] mac|bat-host \n");
+	printf("parameters:\n");
 	printf(" \t -h print this help\n");
 	printf(" \t -n don't convert addresses to bat-host names\n");
 }
-- 
1.7.9.1

