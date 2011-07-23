Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 23 Jul 2011 13:16:42 +0200
Message-Id: <1311419802-31283-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batmand: Fix build of batgat module with
	linux 3.0
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch depends on the patches currently stored in the branch
pu/nonblock_ioctl

Btw. findstring sounds a little bit... error-prone

 linux/modules/Makefile        |    8 ++++----
 linux/modules/Makefile.kbuild |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/linux/modules/Makefile b/linux/modules/Makefile
index eccb601..2aa20e1 100644
--- a/linux/modules/Makefile
+++ b/linux/modules/Makefile
@@ -10,8 +10,8 @@ endif
 
 
 UNAME:=$(shell uname -r)
-LINUX26=2.6
-LINUX_VERSION:=$(findstring $(LINUX26),$(UNAME))
+LINUX24=2.4
+LINUX_VERSION:=$(findstring $(LINUX24),$(UNAME))
 REVISION:=	$(shell if [ -d .svn ]; then \
 						if which svn > /dev/null; then \
 							svn info | grep "Rev:" | sed -e '1p' -n | awk '{print $$4}'; \
@@ -30,14 +30,14 @@ REVISION:=	$(shell if [ -d .svn ]; then \
 
 include $(PWD)/Makefile.kbuild
 
-ifneq ($(LINUX_VERSION),$(LINUX26))
+ifeq ($(LINUX_VERSION),$(LINUX24))
 TARGET:=batgat
 INCLUDE:=-I/lib/modules/$(UNAME)/build/include -I/usr/src/kernel-headers-$(UNAME)/include
 EXTRA_CFLAGS+=-D__KERNEL__ -DMODULE -O2 -Wall $(INCLUDE)
 CC:=gcc
 endif
 
-ifeq ($(LINUX_VERSION),$(LINUX26))
+ifneq ($(LINUX_VERSION),$(LINUX24))
 
 all:
 	$(MAKE) -C $(KERNELPATH) REVISION=$(REVISION) M=$(PWD) PWD=$(PWD) modules
diff --git a/linux/modules/Makefile.kbuild b/linux/modules/Makefile.kbuild
index 91982a5..18ac9a7 100644
--- a/linux/modules/Makefile.kbuild
+++ b/linux/modules/Makefile.kbuild
@@ -2,10 +2,10 @@ ifeq ($(MAKING_MODULES),1)
 -include $(TOPDIR)/Rules.make
 endif
 
-LINUX26:=2.6
+LINUX24:=2.4
 EXTRA_CFLAGS +=-DREVISION_VERSION=\"\ rv$(REVISION)\"
 
-ifeq ($(strip $(findstring $(LINUX26),$(LINUX_VERSION))),$(LINUX26))
+ifneq ($(strip $(findstring $(LINUX24),$(LINUX_VERSION))),$(LINUX24))
 
 obj-m += batgat.o
 batgat-objs := gateway.o hash.o
-- 
1.7.6

