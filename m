Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon,  7 May 2012 23:49:06 +0800
Message-Id: <1336405746-9229-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: tcpdump - filter by compatibility
	number
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
 README       |    1 +
 functions.h  |    1 +
 man/batctl.8 |   40 +++++++++++++++++++++++++++++++---------
 tcpdump.c    |   11 ++++++++++-
 4 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/README b/README
index 0fe192f..24dc4cf 100644
--- a/README
+++ b/README
@@ -88,6 +88,7 @@ tcpdump layer 2 and/or layer 3 traffic on the given interface
 
 Usage: batctl tcpdump [options] interface [interface]
 options:
+         -c compat filter - only display packets matching own compat version (14)
          -h print this help
          -n don't convert addresses to bat-host names
          -p dump specific packet type
diff --git a/functions.h b/functions.h
index ea953dd..fe03dc0 100644
--- a/functions.h
+++ b/functions.h
@@ -48,4 +48,5 @@ enum {
 	USE_READ_BUFF = 0x10,
 	SILENCE_ERRORS = 0x20,
 	NO_OLD_ORIGS = 0x40,
+	COMPAT_FILTER = 0x80,
 };
diff --git a/man/batctl.8 b/man/batctl.8
index 4f2e1c6..c788f2d 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -175,15 +175,37 @@ address. batctl will send 3 packets to each host and display the
 response time. If "\-n" is given batctl will not replace the MAC
 addresses with bat\-host names in the output.
 .br
-.IP "\fBtcpdump\fP|\fBtd\fP       [\fB\-p filter\fP][\fB\-n\fP] \fBinterface ...\fP"
-batctl will display all packets that are seen on the given
-interface(s). The "\-p" options allows the filtering of certain packet
-types: 1 - batman ogm packets, 2 - batman icmp packets, 4 - unicast
-packets, 8 - broadcast packets, 16 - vis packets, and 32 - none batman
-packets. These numbers can be added to filter more than one packet
-type, e.g. use "\-p 3" to display batman ogm packets and batman icmp
-packets only. If "\-n" is given batctl will not replace the MAC
-addresses with bat\-host names in the output.
+.IP "\fBtcpdump\fP|\fBtd\fP       [\fB\-c\fP][\fB\-n\fP][\fB\-p filter\fP][\fB\-x filter\fP] \fBinterface ...\fP"
+batctl will display all packets that are seen on the given interface(s). A variety of options to filter the output
+are available: To only print packets that match the compatibility number of batctl specify the "\-c" (compat filter)
+option. If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output. To filter
+the shown packet types you can either use "\-p" (dump only specified packet types) or "\-x" (dump all packet types
+except specified). The following packet types are available:
+.RS 17
+1 - batman ogm packets
+.RE
+.RS 17
+2 - batman icmp packets
+.RE
+.RS 17
+4 - batman unicast packets
+.RE
+.RS 17
+8 - batman broadcast packets
+.RE
+.RS 16
+16 - batman vis packets
+.RE
+.RS 16
+32 - batman fragmented packets
+.RE
+.RS 16
+64 - batman tt / roaming packets
+.RE
+.RS 15
+128 - non batman packets
+.RE
+Example: batctl td <interface> -p 129 \-> only display batman ogm packets and non batman packets
 .br
 .IP "\fBbisect\fP           [\fB\-l MAC\fP][\fB\-t MAC\fP][\fB\-r MAC\fP][\fB\-s min\fP [\fB\- max\fP]][\fB\-o MAC\fP][\fB\-n\fP] \fBlogfile1\fP [\fBlogfile2\fP ... \fBlogfileN\fP]"
 Analyses the logfiles to build a small internal database of all sent
diff --git a/tcpdump.c b/tcpdump.c
index 72c9cf1..6672cf1 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -61,6 +61,7 @@ static void tcpdump_usage(void)
 {
 	printf("Usage: batctl tcpdump [options] interface [interface]\n");
 	printf("options:\n");
+	printf(" \t -c compat filter - only display packets matching own compat version (%i)\n", COMPAT_VERSION);
 	printf(" \t -h print this help\n");
 	printf(" \t -n don't convert addresses to bat-host names\n");
 	printf(" \t -p dump specific packet type\n");
@@ -491,6 +492,10 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 	case ETH_P_BATMAN:
 		batman_ogm_packet = (struct batman_ogm_packet *)(packet_buff + ETH_HLEN);
 
+		if ((read_opt & COMPAT_FILTER) &&
+		    (batman_ogm_packet->header.version != COMPAT_VERSION))
+			return;
+
 		switch (batman_ogm_packet->header.packet_type) {
 		case BAT_IV_OGM:
 			if (dump_level & DUMP_TYPE_BATOGM)
@@ -639,8 +644,12 @@ int tcpdump(int argc, char **argv)
 
 	dump_level = dump_level_all;
 
-	while ((optchar = getopt(argc, argv, "hnp:x:")) != -1) {
+	while ((optchar = getopt(argc, argv, "chnp:x:")) != -1) {
 		switch (optchar) {
+		case 'c':
+			read_opt |= COMPAT_FILTER;
+			found_args += 1;
+			break;
 		case 'h':
 			tcpdump_usage();
 			return EXIT_SUCCESS;
-- 
1.7.9.1

