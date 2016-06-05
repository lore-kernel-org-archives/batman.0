Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  5 Jun 2016 20:47:00 +0200
Message-Id: <1465152428-17299-2-git-send-email-sven@narfation.org>
In-Reply-To: <1465152428-17299-1-git-send-email-sven@narfation.org>
References: <1465152428-17299-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 02/10] alfred: Split list of objects in
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

From: Sven Eckelmann <sven.eckelmann@open-mesh.com>

The line of objects which are required to compile alfred gets longer and
becomes harder to read. Instead save each object on its own line to make it
easier to edit and easier to solve conflicts when multiple patches modify
the list of objects.

Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
 Makefile      | 12 +++++++++++-
 gpsd/Makefile |  2 +-
 vis/Makefile  |  3 ++-
 3 files changed, 14 insertions(+), 3 deletions(-)
 mode change 100644 => 100755 Makefile
 mode change 100644 => 100755 gpsd/Makefile
 mode change 100644 => 100755 vis/Makefile

diff --git a/Makefile b/Makefile
old mode 100644
new mode 100755
index 939e9f8..1c364f7
--- a/Makefile
+++ b/Makefile
@@ -20,7 +20,17 @@
 
 # alfred build
 BINARY_NAME = alfred
-OBJ = main.o server.o client.o netsock.o send.o recv.o hash.o unix_sock.o util.o debugfs.o batadv_query.o
+OBJ += batadv_query.o
+OBJ += client.o
+OBJ += debugfs.o
+OBJ += hash.o
+OBJ += main.o
+OBJ += netsock.o
+OBJ += recv.o
+OBJ += send.o
+OBJ += server.o
+OBJ += unix_sock.o
+OBJ += util.o
 MANPAGE = man/alfred.8
 
 # alfred flags and options
diff --git a/gpsd/Makefile b/gpsd/Makefile
old mode 100644
new mode 100755
index 72e4445..bae5660
--- a/gpsd/Makefile
+++ b/gpsd/Makefile
@@ -20,7 +20,7 @@
 
 # alfred-gpsd build
 BINARY_NAME = alfred-gpsd
-OBJ = alfred-gpsd.o
+OBJ += alfred-gpsd.o
 MANPAGE = man/alfred-gpsd.8
 
 # alfred flags and options
diff --git a/vis/Makefile b/vis/Makefile
old mode 100644
new mode 100755
index accd1fa..52ca981
--- a/vis/Makefile
+++ b/vis/Makefile
@@ -20,7 +20,8 @@
 
 # batadv-vis build
 BINARY_NAME = batadv-vis
-OBJ = vis.o debugfs.o
+OBJ += debugfs.o
+OBJ += vis.o
 MANPAGE = man/batadv-vis.8
 
 # batadv-vis flags and options
-- 
2.8.1

