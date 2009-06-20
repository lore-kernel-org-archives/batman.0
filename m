Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 20 Jun 2009 15:37:57 +0200
Message-Id: <1245505077-15016-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] [batctl] Remove references to old tool names
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


Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batctl/man/batctl.8 |    6 +++---
 batctl/ping.c       |    8 ++++----
 batctl/tcpdump.c    |    4 ++--
 batctl/traceroute.c |    4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/batctl/man/batctl.8 b/batctl/man/batctl.8
index 4cd206b..1222af9 100644
--- a/batctl/man/batctl.8
+++ b/batctl/man/batctl.8
@@ -2,7 +2,7 @@
 .\" First parameter, NAME, should be all caps
 .\" Second parameter, SECTION, should be 1-8, maybe w/ subsection
 .\" other parameters are allowed: see man(7), man(1)
-.TH BATTOOL 8 "Sep 17, 2007"
+.TH BATCTL 8 "Sep 17, 2007"
 .\" Please adjust this date whenever revising the manpage.
 .\"
 .\" Some roff macros, for reference:
@@ -77,7 +77,7 @@ timeout interval in seconds (default is 1 second)
 Traceroute sends 3 packets to each hop, awaits the answers and prints out the response times.
 
 .TP
-.RI \fBbatctl\ batdump\fP\ [\fIoptions\fP]\ [\fIinterface\fP]
+.RI \fBbatctl\ tcpdump\fP\ [\fIoptions\fP]\ [\fIinterface\fP]
 The following options are supported:
 .RSs
 .IPs "-a (all packets)"
@@ -104,7 +104,7 @@ prints more information about each packet
 .br
 .SH FILES
 .IPs bat-hosts
-This file is simliar to the /etc/hosts file. You can write one MAC address and one host name per line. The battool will analyze the file to find the matching MAC address to your provided host name. Host names are much easier to remember than MAC addresses.  ;)
+This file is simliar to the /etc/hosts file. You can write one MAC address and one host name per line. The batctl will analyze the file to find the matching MAC address to your provided host name. Host names are much easier to remember than MAC addresses.  ;)
 .SH SEE ALSO
 \fIbatmand-adv\fP (8)
 .SH AUTHOR
diff --git a/batctl/ping.c b/batctl/ping.c
index b273133..8f4eee8 100644
--- a/batctl/ping.c
+++ b/batctl/ping.c
@@ -46,8 +46,8 @@
 uint8_t Stop = 0;
 
 void batping_usage() {
-	printf("Battool module batping\n");
-	printf("Usage: battool batping|bp [options] mac|name\n");
+	printf("batctl module ping\n");
+	printf("Usage: batctl ping|bp [options] mac|name\n");
 	printf("\t-c count\n");
 	printf("\t-h help\n");
 	printf("\t-i interval in seconds\n");
@@ -197,7 +197,7 @@ int ping(int argc, char **argv)
 	/* remove new procmask from current procmask */
 	sigprocmask( SIG_UNBLOCK,&sigmask_new, &sigmask_old );
 
-	printf("batping %s\n", mac_string );
+	printf("ping %s\n", mac_string );
 	while( !Stop && loop_count != 0 ) {
 		if( loop_count > 0 )
 			loop_count--;
@@ -263,7 +263,7 @@ int ping(int argc, char **argv)
 		}
 		if( timeout.tv_sec > 0 ) sleep( loop_interval?loop_interval:1 );
 	}
-	printf("--- %s batping statistic ---\n",mac_string );
+	printf("--- %s ping statistic ---\n",mac_string );
 	printf("%d packets transmitted, %d received, %d%c packet loss\n", trans, recv, ( (trans - recv) * 100 / trans ),'%');
 	printf("rtt min/avg/max/mdev = %.3f/%.3f/%.3f/%.3f ms\n", min < 0.0 ? 0.000 : min, avg_count?(avg / avg_count):0.000 ,max, max - ( min < 0.0 ? 0.0:min) );
 	ret = EXIT_SUCCESS;
diff --git a/batctl/tcpdump.c b/batctl/tcpdump.c
index 5b100a5..e58aa30 100644
--- a/batctl/tcpdump.c
+++ b/batctl/tcpdump.c
@@ -50,8 +50,8 @@ uint8_t print_names = 1;
 struct list_head_first dump_if_list;
 
 void batdump_usage() {
-	printf("Battool module batdump\n");
-	printf("Usage: battool batdump|bd [option] interface\n");
+	printf("batctl module tcpdump\n");
+	printf("Usage: batctl tcpdump|bd [option] interface\n");
 	printf("\t-p packet type\n\t\t1=batman packets\n\t\t2=icmp packets\n\t\t3=unicast packets\n\t\t4=broadcast packets\n");
 	printf("\t-a all packet types\n");
 	printf("\t-d packet dump in hex\n");
diff --git a/batctl/traceroute.c b/batctl/traceroute.c
index 2018cab..67484a9 100644
--- a/batctl/traceroute.c
+++ b/batctl/traceroute.c
@@ -40,8 +40,8 @@
 
 
 void batroute_usage() {
-	printf("Battool module batroute\n");
-	printf("Usage: battool batroute|br mac|name\n");
+	printf("batctl module traceroute\n");
+	printf("Usage: batctl traceroute|br mac|name\n");
 	printf("\t-h help\n");
 	return;
 }
-- 
1.6.3.1

