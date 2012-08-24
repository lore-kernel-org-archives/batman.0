Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 25 Aug 2012 01:39:17 +0200
Message-Id: <1345851557-8085-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1345851557-8085-1-git-send-email-lindner_marek@yahoo.de>
References: <1345851557-8085-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batctl: make bisect_* a compile time
	option
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 Makefile |   16 +++++++++++++---
 main.c   |    4 ++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index efe57c1..9b2d3ef 100755
--- a/Makefile
+++ b/Makefile
@@ -18,9 +18,14 @@
 # 02110-1301, USA
 #
 
+# changing the CONFIG_* line to 'y' enables the related feature
+# batctl advanced debugging tool bisect:
+export CONFIG_BATCTL_BISECT=n
+
 # batctl build
 BINARY_NAME = batctl
-OBJ = main.o bat-hosts.o functions.o sys.o debug.o ping.o traceroute.o tcpdump.o list-batman.o hash.o vis.o debugfs.o bisect_iv.o ioctl.o
+OBJ = main.o bat-hosts.o functions.o sys.o debug.o ping.o traceroute.o tcpdump.o  hash.o vis.o debugfs.o ioctl.o list-batman.o
+OBJ_BISECT = bisect_iv.o
 MANPAGE = man/batctl.8
 
 # batctl flags and options
@@ -38,6 +43,11 @@ endif
 endif
 
 # standard build tools
+ifeq ($(CONFIG_BATCTL_BISECT),y)
+OBJ += $(OBJ_BISECT)
+CFLAGS += -DBATCTL_BISECT
+endif
+
 CC ?= gcc
 RM ?= rm -f
 INSTALL ?= install
@@ -70,7 +80,7 @@ $(BINARY_NAME): $(OBJ)
 	$(LINK.o) $^ $(LDLIBS) -o $@
 
 clean:
-	$(RM) $(BINARY_NAME) $(OBJ) $(DEP)
+	$(RM) $(BINARY_NAME) $(OBJ) $(OBJ_BISECT) $(DEP)
 
 install: $(BINARY_NAME)
 	$(MKDIR) $(DESTDIR)$(SBINDIR)
@@ -79,7 +89,7 @@ install: $(BINARY_NAME)
 	$(INSTALL) -m 0644 $(MANPAGE) $(DESTDIR)$(MANDIR)/man8
 
 # load dependencies
-DEP = $(OBJ:.o=.d)
+DEP = $(OBJ:.o=.d) $(OBJ_BISECT:.o=.d)
 -include $(DEP)
 
 .PHONY: all clean install
diff --git a/main.c b/main.c
index 390736d..01a435b 100644
--- a/main.c
+++ b/main.c
@@ -85,7 +85,9 @@ void print_usage(void)
 	printf(" \tping|p                     <destination>     \tping another batman adv host via layer 2\n");
 	printf(" \ttraceroute|tr              <destination>     \ttraceroute another batman adv host via layer 2\n");
 	printf(" \ttcpdump|td                 <interface>       \ttcpdump layer 2 traffic on the given interface\n");
+#ifdef BATCTL_BISECT
 	printf(" \tbisect_iv                  <file1> .. <fileN>\tanalyze given batman iv log files for routing stability\n");
+#endif
 }
 
 int main(int argc, char **argv)
@@ -172,9 +174,11 @@ int main(int argc, char **argv)
 
 		ret = ioctl_statistics_get(mesh_iface);
 
+#ifdef BATCTL_BISECT
 	} else if ((strcmp(argv[1], "bisect_iv") == 0)) {
 
 		ret = bisect_iv(argc - 1, argv + 1);
+#endif
 
 	} else {
 
-- 
1.7.9.1

