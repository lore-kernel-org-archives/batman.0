Return-Path: <philipp.psurek@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Tue, 13 Jun 2017 10:26:00 +0200
Message-Id: <20170613082600.24910-3-philipp.psurek@gmail.com>
In-Reply-To: <20170613082600.24910-1-philipp.psurek@gmail.com>
References: <1496077749.5980.2.camel@gmail.com>
 <20170613082600.24910-1-philipp.psurek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batctl: suppress implicit-fallthrough
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
To: b.a.t.m.a.n@lists.open-mesh.org

GCC 7.1.0 complains about an intended fallthrough.
“__attribute__ ((fallthrough))” in this part of code would suppress this
warning. Because older GCC compiler don’t understand this statement attribute
and because there is already a comment in the source containing
“falls?[ \t-]*thr(ough|u)” we can suppress the warning with the
“-Wimplicit-fallthrough=2” warning option. Unintended fallthroughs without a
comment will trigger this warning.

Older GCC compiler don’t understand this warning option and exits with error.
There has to be a compiler recognition after that only GCC =>7.1.0 receives
this option.

Signed-off-by: Philipp Psurek <philipp.psurek@gmail.com>
---
 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 6bebb7d..29b7e2f 100755
--- a/Makefile
+++ b/Makefile
@@ -101,6 +101,11 @@ MKDIR ?= mkdir -p
 COMPILE.c = $(Q_CC)$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
 LINK.o = $(Q_LD)$(CC) $(CFLAGS) $(LDFLAGS) $(TARGET_ARCH)
 
+# Check for GCC >=7
+ifeq ($(shell $(CC) -x c++ --std=c++17 -E -P - <<< __cplusplus),201703L)
+       CFLAGS += -Wimplicit-fallthrough=2
+endif
+
 # standard install paths
 PREFIX = /usr/local
 SBINDIR = $(PREFIX)/sbin
-- 
2.13.0

