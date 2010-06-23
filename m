Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 23 Jun 2010 14:12:57 +0200
Message-Id: <1277295179-30503-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1277295179-30503-1-git-send-email-sven.eckelmann@gmx.de>
References: <1277295179-30503-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batctl:Use nproc to get number of
	available processors
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

The current way of getting the number of cpus uses different assumptions which
may or may not be true in the future:
 * /proc/cpuinfo exists
 * cpuinfo provides a list of all processing units
 * all processing units are available for the current process and its childs
 * the word 'processor' is only used in the cpu index and 'model name' lines
 * cpu index is strict monotonic increasing
 * lowest cpu index is 0 and highest cpu index is n-1 (n is the number of
    processing units)

At least the number of available processing units for the current process can
be shown to be wrong. on current systems by assigning a singe cpu to a process
and its childs:

$ numactl --physcpubind=0 nproc
1

$ numactl --physcpubind=0 sh -c 'NUM_CPUS=`cat /proc/cpuinfo | grep -v "model name" | grep processor | tail -1 | awk -F" " '\''{print $$3}'\''`;echo `expr $NUM_CPUS + 1`'
4

nproc is part of coreutils since version 8.1. On systems without nproc it will
just assume that a single processing unit is available.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batctl/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batctl/Makefile b/batctl/Makefile
index ab9c075..ef80d3c 100644
--- a/batctl/Makefile
+++ b/batctl/Makefile
@@ -67,7 +67,7 @@ REVISION_VERSION =\"\ rv$(REVISION)\"
 
 BAT_VERSION = $(shell grep "^\#define SOURCE_VERSION " $(SOURCE_VERSION_HEADER) | sed -e '1p' -n | awk -F '"' '{print $$2}' | awk '{print $$1}')
 FILE_NAME = $(PACKAGE_NAME)_$(BAT_VERSION)-rv$(REVISION)_$@
-NUM_CPUS = $(shell NUM_CPUS=`cat /proc/cpuinfo | grep -v 'model name' | grep processor | tail -1 | awk -F' ' '{print $$3}'`;echo `expr $$NUM_CPUS + 1`)
+NUM_CPUS = $(shell nproc 2> /dev/null || echo 1)
 
 
 all:
-- 
1.7.1

