Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 16:17:27 +0200
Message-Id: <20161018141731.7970-5-sven@narfation.org>
In-Reply-To: <2403515.P9aVkiGJpp@bentobox>
References: <2403515.P9aVkiGJpp@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v3 5/9] batctl: Allow to disable automatic
	interface create/destroy
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

Users may not want to lose their configured batman-adv soft-interface when
they remove a single interface from it. The default configuration may not
working well enough in the network setup of the user and thus it should be
possible to avoid that it gets reset to it when a new interface is added
after the last one was removed.

This can be done by avoiding automatic creation of an interface when the
command "add" is used together with the option "-M". The add would fail
when the soft-interface disappeared for some reason and thus the
soft-interface would not be created again with the default configuration.
But more importantly, the "del" command can be informed with the option
"-M" to not try to remove the soft-interface in the first place.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v3:
 - rebased on current master
v2:
 - rename "new" command to "create" as requested by Linus Luessing and
   John Harrison
---
 man/batctl.8 |  4 +++-
 sys.c        | 12 +++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/man/batctl.8 b/man/batctl.8
index 37b5632..9ee0e31 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -52,10 +52,12 @@ performances, is also included.
 .br
 .TP
 .I \fBcommands:
-.IP "\fBinterface\fP|\fBif\fP [\fBadd\fP|\fBdel iface(s)\fP]"
+.IP "\fBinterface\fP|\fBif\fP [\fB-M\fP] [\fBadd\fP|\fBdel iface(s)\fP]"
 If no parameter is given or the first parameter is neither "add" nor "del" the current interface settings are displayed.
 In order to add or delete interfaces specify "add" or "del" as first argument and append the interface names you wish to
 add or delete. Multiple interfaces can be specified.
+The "\-M" option tells batctl to not automatically create the batman-adv interface on "add" or to destroy it when "del"
+removed all interfaces which belonged to it.
 .IP "\fBinterface\fP|\fBif\fP [\fBcreate\fP|\fBdestroy\fP]"
 A batman-adv interface without attached interfaces can be created using "create". The parameter "destroy" can be used to
 free all attached interfaces and remove batman-adv interface.
diff --git a/sys.c b/sys.c
index 190fd06..2cbccea 100644
--- a/sys.c
+++ b/sys.c
@@ -22,6 +22,7 @@
 
 #include <unistd.h>
 #include <stdio.h>
+#include <stdbool.h>
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
@@ -122,6 +123,7 @@ static void interface_usage(void)
 	fprintf(stderr, "Usage: batctl [options] interface [parameters] [add|del iface(s)]\n");
 	fprintf(stderr, "       batctl [options] interface [parameters] [create|destroy]\n");
 	fprintf(stderr, "parameters:\n");
+	fprintf(stderr, " \t -M disable automatic creation/removal of batman-adv interface\n");
 	fprintf(stderr, " \t -h print this help\n");
 }
 
@@ -385,12 +387,16 @@ int interface(char *mesh_iface, int argc, char **argv)
 	unsigned int cnt;
 	int rest_argc;
 	char **rest_argv;
+	bool manual_mode = false;
 
-	while ((optchar = getopt(argc, argv, "h")) != -1) {
+	while ((optchar = getopt(argc, argv, "hM")) != -1) {
 		switch (optchar) {
 		case 'h':
 			interface_usage();
 			return EXIT_SUCCESS;
+		case 'M':
+			manual_mode = true;
+			break;
 		default:
 			interface_usage();
 			return EXIT_FAILURE;
@@ -465,7 +471,7 @@ int interface(char *mesh_iface, int argc, char **argv)
 
 	/* get index of batman-adv interface - or try to create it */
 	ifmaster = if_nametoindex(mesh_iface);
-	if (!ifmaster && rest_argv[0][0] == 'a') {
+	if (!manual_mode && !ifmaster && rest_argv[0][0] == 'a') {
 		ret = create_interface(mesh_iface);
 		if (ret < 0) {
 			fprintf(stderr,
@@ -518,7 +524,7 @@ int interface(char *mesh_iface, int argc, char **argv)
 	}
 
 	/* check if there is no interface left and then destroy mesh_iface */
-	if (rest_argv[0][0] == 'd') {
+	if (!manual_mode && rest_argv[0][0] == 'd') {
 		cnt = count_interfaces(mesh_iface);
 		if (cnt == 0)
 			destroy_interface(mesh_iface);
-- 
2.9.3

