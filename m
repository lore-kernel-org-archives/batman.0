Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 17 Oct 2012 21:55:55 +0200
Message-Id: <1350503758-20685-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/4] alfred: Prepare makefile for distibutions
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

Distributions must be able to easily set CPPFLAGS, CFLAGS and LDFLAGS to have
full control about optimization or security related flags. It is also necessary
to be able to install all files.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile |   91 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 80 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 92299ac..9796528 100644
--- a/Makefile
+++ b/Makefile
@@ -1,12 +1,81 @@
-LDFLAGS=-ggdb -static
-CFLAGS=-O2 -Wall -ggdb
-BIN=alfred
-OBJS=main.o server.o client.o netsock.o send.o recv.o hash.o unix_sock.o util.o
-default:	all
-all:		$(BIN)
-$(BIN):	$(OBJS)
-	gcc $(LDFLAGS) $(OBJS) -o $(BIN)
-.c.o:	
-	gcc $(CFLAGS) -o $@ -c $<
+#!/usr/bin/make -f
+# -*- makefile -*-
+#
+# Copyright (C) 2012 B.A.T.M.A.N. contributors
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of version 2 of the GNU General Public
+# License as published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+# General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+# 02110-1301, USA
+#
+
+# alfred build
+BINARY_NAME = alfred
+OBJ = main.o server.o client.o netsock.o send.o recv.o hash.o unix_sock.o util.o
+
+# alfred flags and options
+CFLAGS += -pedantic -Wall -W -std=gnu99 -fno-strict-aliasing -MD
+LDLIBS +=
+
+# disable verbose output
+ifneq ($(findstring $(MAKEFLAGS),s),s)
+ifndef V
+	Q_CC = @echo '   ' CC $@;
+	Q_LD = @echo '   ' LD $@;
+	export Q_CC
+	export Q_LD
+endif
+endif
+
+# standard build tools
+CC ?= gcc
+RM ?= rm -f
+INSTALL ?= install
+MKDIR ?= mkdir -p
+COMPILE.c = $(Q_CC)$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
+LINK.o = $(Q_LD)$(CC) $(LDFLAGS) $(TARGET_ARCH)
+
+# standard install paths
+PREFIX = /usr/local
+SBINDIR = $(PREFIX)/sbin
+
+# try to generate revision
+REVISION= $(shell	if [ -d .git ]; then \
+				echo $$(git describe --always --dirty --match "v*" |sed 's/^v//' 2> /dev/null || echo "[unknown]"); \
+			fi)
+ifneq ($(REVISION),)
+CPPFLAGS += -DSOURCE_VERSION=\"$(REVISION)\"
+endif
+
+# default target
+all: $(BINARY_NAME)
+
+# standard build rules
+.SUFFIXES: .o .c
+.c.o:
+	$(COMPILE.c) -o $@ $<
+
+$(BINARY_NAME): $(OBJ)
+	$(LINK.o) $^ $(LDLIBS) -o $@
+
 clean:
-	rm -f $(BIN) $(OBJS)
+	$(RM) $(BINARY_NAME) $(OBJ) $(DEP)
+
+install: $(BINARY_NAME)
+	$(MKDIR) $(DESTDIR)$(SBINDIR)
+	$(INSTALL) -m 0755 $(BINARY_NAME) $(DESTDIR)$(SBINDIR)
+
+# load dependencies
+DEP = $(OBJ:.o=.d)
+-include $(DEP)
+
+.PHONY: all clean install
-- 
1.7.10.4

