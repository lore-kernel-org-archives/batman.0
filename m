Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 14 Aug 2015 18:25:16 +0200
Message-Id: <1439569516-17290-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: mention libcap in the README
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

Reported-by: Florian Steinel <alfred@open-mesh.org.flonet.net>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 README | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 7cef9f6..938a275 100644
--- a/README
+++ b/README
@@ -29,8 +29,9 @@ alfred depends on:
  * librt (usually part of libc)
  * IPv6 support in the kernel/host system
 
-and if distributing GPS information:
- * libgps
+and optionally:
+ * libgps - if you want to distribute GPS information
+ * libcap - if you want extra security by dropping unneeded privileges
 
 To compile alfred, simply type:
 
@@ -53,6 +54,10 @@ CONFIG_ALFRED_GPSD=n:
  $ make CONFIG_ALFRED_GPSD=n
  $ make CONFIG_ALFRED_GPSD=n install
 
+If don't want to compile with libcap to drop privileges, use:
+
+ $ make CONFIG_ALFRED_CAPABILITIES=n
+ $ make CONFIG_ALFRED_CAPABILITIES=n install
 
 Usage
 -----
-- 
2.1.4

