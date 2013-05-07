Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  7 May 2013 14:51:01 +0200
Message-Id: <1367931069-7177-2-git-send-email-sven@narfation.org>
In-Reply-To: <1367931069-7177-1-git-send-email-sven@narfation.org>
References: <1367931069-7177-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/9] alfred: Add CFLAGS to the linker step
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
Cc: Sven Eckelmann <sven@narfation.org>

The GCC manual states for different parameters that the options for compilation
must also be used when linking. The options for compilation are stored in
CFLAGS and added to LINK.o to fix the behavior.

Option which need this are for example -fPIC/-fPIE or -flto.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile     | 2 +-
 vis/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 268a156..aeee2e8 100644
--- a/Makefile
+++ b/Makefile
@@ -42,7 +42,7 @@ RM ?= rm -f
 INSTALL ?= install
 MKDIR ?= mkdir -p
 COMPILE.c = $(Q_CC)$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
-LINK.o = $(Q_LD)$(CC) $(LDFLAGS) $(TARGET_ARCH)
+LINK.o = $(Q_LD)$(CC) $(CFLAGS) $(LDFLAGS) $(TARGET_ARCH)
 
 # standard install paths
 PREFIX = /usr/local
diff --git a/vis/Makefile b/vis/Makefile
index 5ec0423..8585f9a 100644
--- a/vis/Makefile
+++ b/vis/Makefile
@@ -42,7 +42,7 @@ RM ?= rm -f
 INSTALL ?= install
 MKDIR ?= mkdir -p
 COMPILE.c = $(Q_CC)$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
-LINK.o = $(Q_LD)$(CC) $(LDFLAGS) $(TARGET_ARCH)
+LINK.o = $(Q_LD)$(CC) $(CFLAGS) $(LDFLAGS) $(TARGET_ARCH)
 
 # standard install paths
 PREFIX = /usr/local
-- 
1.8.2.1

