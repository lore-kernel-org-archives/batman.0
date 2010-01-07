Return-Path: <andrew@lunn.ch>
Date: Thu, 7 Jan 2010 07:15:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100107061536.GF7597@lunn.ch>
References: <1262454706-6137-1-git-send-email-sven.eckelmann@gmx.de>
	<20100104105146.GA25037@lunn.ch> <20100104191155.GA32331@lunn.ch>
	<201001071259.14064.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201001071259.14064.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Correct smaller typographical errors
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

On Thu, Jan 07, 2010 at 12:59:13PM +0800, Marek Lindner wrote:
> On Tuesday 05 January 2010 03:11:55 Andrew Lunn wrote:
> > Here is the re-worked batctl.8 file. I made quite a lot of
> > changes. Since the diff will be bigger than the plain file, here is
> > the plain file.
> 
> Applied in rev 1533. Thanks for the review!
> 
> By the way, batctl vis still has "-h" as an option which does not show the 
> help output. This is rather unusual. Do you mind choosing another letter ? 
> I asked that before but maybe it got lost in the stream of mails.  :)

batctl: VIS subcommand uses -h for help/usage.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Index: batctl/vis.c
===================================================================
--- batctl/vis.c	(revision 1534)
+++ batctl/vis.c	(working copy)
@@ -55,9 +55,9 @@
 
 static void usage(void)
 {
-	printf("batctl vis dot {--no-HNA|-h} {--no-2nd|-2} {--numbers|-n}\n");
+	printf("batctl vis dot {-h}{--no-HNA|-H} {--no-2nd|-2} {--numbers|-n}\n");
 	printf("or\n");
-	printf("batctl vis json {--no-HNA|-h} {--no-2nd|-2} {--numbers|-n}\n");
+	printf("batctl vis json {-h}{--no-HNA|-H} {--no-2nd|-2} {--numbers|-n}\n");
 }
 
 static void dot_print_tq(char *orig, char *from, const long tq)
@@ -271,18 +271,18 @@
 	while (1) {
 		int option_index = 0;
 		static struct option long_options[] = {
-			{"no-HNA", 0, 0, 'h'},
+			{"no-HNA", 0, 0, 'H'},
 			{"no-2nd", 0, 0, '2'},
 			{"numbers", 0, 0, 'n'},
 			{0, 0, 0, 0}
 		};
 
-		c = getopt_long(argc, argv, "h2n", long_options, &option_index);
+		c = getopt_long(argc, argv, "hH2n", long_options, &option_index);
 		if (c == -1)
 			break;
 
 		switch (c) {
-		case 'h':
+		case 'H':
 			with_HNA = false;
 			break;
 		case '2':
@@ -291,6 +291,7 @@
 		case 'n':
 			with_names = false;
 			break;
+		case 'h':
 		default:
 			usage();
 			return -1;
Index: batctl/man/batctl.8
===================================================================
--- batctl/man/batctl.8	(revision 1534)
+++ batctl/man/batctl.8	(working copy)
@@ -99,18 +99,18 @@
 displayed only once (useful for scripts). If "\-n" is given batctl
 will not replace the MAC addresses with bat\-host names in the output.
 .br
-.IP "\fBvis dot\fP         [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-h\fP|\fB\-\-no-HNA\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
+.IP "\fBvis dot\fP         [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-H\fP|\fB\-\-no-HNA\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
 Display the visualisation data in graphviz \fBdot\fP(1) format. If
 "\-\-numbers" or "\-n" is given batctl will not replace the MAC
 addresses with bat-host names in the output. With "\-\-no-HNA" or
-"\-h" the HNA entries are not displayed, so the pure mesh topology can
+"\-H" the HNA entries are not displayed, so the pure mesh topology can
 be seen. With "\-\-no-2nd" or "\-2" a dot cluster is not formed around
 primary and secondary addresses from the same device.
 .br
-.IP "\fBvis json\fP        [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-h\fP|\fB\-\-no-HNA\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
+.IP "\fBvis json\fP        [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-H\fP|\fB\-\-no-HNA\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
 Display the visualisation data in JSON format. If "\-\-numbers" or
 "\-n" is given batctl will not replace the MAC addresses with bat-host
-names in the output. With "\-\-no-HNA" or "\-h" the HNA entries are
+names in the output. With "\-\-no-HNA" or "\-H" the HNA entries are
 not displayed, so the pure mesh topology can be seen. With
 "\-\-no-2nd" or "\-2" a dot cluster is not formed around primary and
 secondary addresses from the same device.
