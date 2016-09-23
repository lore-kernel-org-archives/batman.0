Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 23 Sep 2016 16:35:57 +0200
Message-Id: <20160923143557.30828-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: Enable _GNU_SOURCE by default
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

alfred uses any netlink library which is (more or less) compatible with
libnl-3. This is for example libnl-tiny on OpenWrt.

Programs and libraries which are build against libnl-tiny must be build
with _GNU_SOURCE enabled to have some types in its headers defined. Thus
_GNU_SOURCE is enabled in the OpenWrt alfred package since 2016.3. But
sometimes using _GNU_SOURCE and sometimes not using it can have severe side
effects which are non-trivial to debug when the developer is not also using
the same _GNU_SOURCE preprocessor define. Thus enable _GNU_SOURCE by
default to have similar behavior (defines, type definitions, structure
members, ...) from headers like on OpenWrt.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile      | 1 +
 gpsd/Makefile | 1 +
 vis/Makefile  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 6daa904..552e690 100755
--- a/Makefile
+++ b/Makefile
@@ -36,6 +36,7 @@ MANPAGE = man/alfred.8
 
 # alfred flags and options
 CFLAGS += -pedantic -Wall -W -std=gnu99 -fno-strict-aliasing -MD -MP
+CPPFLAGS += -D_GNU_SOURCE
 LDLIBS += -lrt
 
 # Turn on alfred capability dropping by default - set this to n if you don't want/need it
diff --git a/gpsd/Makefile b/gpsd/Makefile
index bae5660..b6172d9 100755
--- a/gpsd/Makefile
+++ b/gpsd/Makefile
@@ -25,6 +25,7 @@ MANPAGE = man/alfred-gpsd.8
 
 # alfred flags and options
 CFLAGS += -pedantic -Wall -W -std=gnu99 -fno-strict-aliasing -MD -MP
+CPPFLAGS += -D_GNU_SOURCE
 
 # disable verbose output
 ifneq ($(findstring $(MAKEFLAGS),s),s)
diff --git a/vis/Makefile b/vis/Makefile
index fd99f49..22483a5 100755
--- a/vis/Makefile
+++ b/vis/Makefile
@@ -27,6 +27,7 @@ MANPAGE = man/batadv-vis.8
 
 # batadv-vis flags and options
 CFLAGS += -pedantic -Wall -W -std=gnu99 -fno-strict-aliasing -MD -MP
+CPPFLAGS += -D_GNU_SOURCE
 LDLIBS += -lrt
 
 # disable verbose output
-- 
2.9.3

