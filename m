Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1496484820.22967.2.camel@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Sat, 03 Jun 2017 12:13:40 +0200
In-Reply-To: <1496459579.22954.6.camel@gmail.com>
References: <1496077749.5980.2.camel@gmail.com> <2479408.89UKcKX64H@prime>
 <1496459579.22954.6.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: suppress implicit-fallthrough
 compiler warning
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org

Well, now it's a little bit tricky to suppress compiler warnings as
anything below 7.1.0 dislike “__attribute__ ((fallthrough));” with a
warning. One could tell the 7.1.0 with “-Wimplicit-fallthrough=2” to
suppress the warning because there is a “falls?[ \t-]*thr(ough|u)”
comment, but other compiles drop an unrecognised command line option
error.

This one is not possible:

diff --git a/tp_meter.c b/tp_meter.c
index 592a9ed..c1587cd 100644
--- a/tp_meter.c
+++ b/tp_meter.c
@@ -501,7 +501,9 @@ int tp_meter(char *mesh_iface, int argc, char **argv)
 	case BATADV_TP_REASON_CANCEL:
 		printf("CANCEL received: test aborted\n");
 		/* fall through and print the partial result */
+		#if (__STDC_VERSION__ == 201112L)
+		__attribute__ ((fallthrough));
+		#endif
 	case BATADV_TP_REASON_COMPLETE:
 		if (result.test_time > 0) {
 			throughput = result.total_bytes * 1000;

because batctl is compiled with “-std=gnu99” which is predefined in the
makefile. And I don't know if you like such code.

What actually works is this hack in the makefile:

--- a/Makefile
+++ b/Makefile
@@ -101,6 +101,11 @@ MKDIR ?= mkdir -p
 COMPILE.c = $(Q_CC)$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
 LINK.o = $(Q_LD)$(CC) $(CFLAGS) $(LDFLAGS) $(TARGET_ARCH)
 
+# Check for GCC >=7
+ifeq ($(shell $(CC) -x c -E -P - <<< __STDC_VERSION__),201112L)
+CFLAGS += -Wimplicit-fallthrough=2
+endif
+
 # standard install paths
 PREFIX = /usr/local
 SBINDIR = $(PREFIX)/sbin

I suggest to modify the makefile with this patch and make comments
on intended fallthroughs like you already did.
