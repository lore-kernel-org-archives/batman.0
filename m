Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2011 15:45:06 +0200
Message-Id: <1305985517-3763-2-git-send-email-sven@narfation.org>
In-Reply-To: <1305985517-3763-1-git-send-email-sven@narfation.org>
References: <1305985517-3763-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 02/13] vis: Don't automatically build in
	parallel
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

Distributions like Gentoo and Debian have policies which make it
necessary to use some kind of environmental variable to control the
parallel build.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch depends on other patches submitted earlier:
 - vis: Remove obsolete creation of source packages
 - vis: Remove subversion/svk revision information

 Makefile |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 6867a5f..b3a7963 100644
--- a/Makefile
+++ b/Makefile
@@ -49,11 +49,7 @@ REVISION= $(shell      if [ -d .git ]; then \
                         fi)
 REVISION_VERSION=\"\ $(REVISION)\"
 
-NUM_CPUS = $(shell NUM_CPUS=`cat /proc/cpuinfo | grep -v 'model name' | grep processor | tail -1 | awk -F' ' '{print $$3}'`;echo `expr $$NUM_CPUS + 1`)
-
-
-all:
-	$(MAKE) -j $(NUM_CPUS) $(BINARY_NAME)
+all: $(BINARY_NAME)
 
 $(BINARY_NAME):	$(SRC_O) $(SRC_H) Makefile
 	$(Q_LD)$(CC) -o $@ $(SRC_O) $(LDFLAGS)
-- 
1.7.5.1

