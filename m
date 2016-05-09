Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Mon,  9 May 2016 18:41:51 +0200
Message-Id: <1462812114-16577-1-git-send-email-sven@open-mesh.com>
In-Reply-To: <6307812.WAqRcEYAvX@bentobox>
References: <6307812.WAqRcEYAvX@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v7 1/4] batctl: Split list of objects in
	Makefile into separate lines
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

From: Sven Eckelmann <sven.eckelmann@open-mesh.com>

The line of objects which are required to compile batctl gets longer and
becomes harder to read. Instead save each object on its own line to make it
easier to edit and easier to solve conflicts when multiple patches modify
the list of objects.

Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>

Forwarded: https://patchwork.open-mesh.org/patch/16078/
---
 Makefile | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b82c0c6..a037847 100755
--- a/Makefile
+++ b/Makefile
@@ -24,7 +24,19 @@ export CONFIG_BATCTL_BISECT=n
 
 # batctl build
 BINARY_NAME = batctl
-OBJ = main.o bat-hosts.o functions.o sys.o debug.o ping.o traceroute.o tcpdump.o  hash.o debugfs.o ioctl.o list-batman.o translate.o
+OBJ += bat-hosts.o
+OBJ += debugfs.o
+OBJ += debug.o
+OBJ += functions.o
+OBJ += hash.o
+OBJ += ioctl.o
+OBJ += list-batman.o
+OBJ += main.o
+OBJ += ping.o
+OBJ += sys.o
+OBJ += tcpdump.o
+OBJ += traceroute.o
+OBJ += translate.o
 OBJ_BISECT = bisect_iv.o
 MANPAGE = man/batctl.8
 
-- 
2.8.1

