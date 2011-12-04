Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  4 Dec 2011 20:10:45 +0100
Message-Id: <1323025848-14024-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: Don't automatically build in
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
 Makefile |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 3374687..15f099e 100644
--- a/Makefile
+++ b/Makefile
@@ -33,12 +33,10 @@ REVISION= $(shell	if [ -d .git ]; then \
 				echo $$(git describe --always --dirty --match "v*" |sed 's/^v//' 2> /dev/null || echo "[unknown]"); \
 			fi)
 
-NUM_CPUS = $(shell nproc 2> /dev/null || echo 1)
-
 include $(PWD)/Makefile.kbuild
 
 all:
-	$(MAKE) -C $(KERNELPATH) REVISION=$(REVISION) M=$(PWD) PWD=$(PWD) -j $(NUM_CPUS) modules
+	$(MAKE) -C $(KERNELPATH) REVISION=$(REVISION) M=$(PWD) PWD=$(PWD) modules
 
 clean:
 	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) clean
-- 
1.7.7.3

