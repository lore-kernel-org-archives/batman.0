Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1496485913.22967.4.camel@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Sat, 03 Jun 2017 12:31:53 +0200
In-Reply-To: <1496484820.22967.2.camel@gmail.com>
References: <1496077749.5980.2.camel@gmail.com> <2479408.89UKcKX64H@prime>
 <1496459579.22954.6.camel@gmail.com> <1496484820.22967.2.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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

OK, sorry for the many posts ... there was some trouble recognizing the
used compiler with the last patch. This now really do the work:

diff --git a/Makefile b/Makefile
index 6bebb7d..7123d83 100755
--- a/Makefile
+++ b/Makefile
@@ -101,6 +101,11 @@ MKDIR ?= mkdir -p
 COMPILE.c = $(Q_CC)$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
 LINK.o = $(Q_LD)$(CC) $(CFLAGS) $(LDFLAGS) $(TARGET_ARCH)
 
+# Check for GCC >=7
+ifeq ($(shell $(CC) -x c++ --std=c++17 -E -P - <<< __cplusplus),201703L)
+	CFLAGS += -Wimplicit-fallthrough=2
+endif
+
 # standard install paths
 PREFIX = /usr/local
 SBINDIR = $(PREFIX)/sbin

