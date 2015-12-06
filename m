Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  6 Dec 2015 16:15:52 +0100
Message-Id: <1449414952-21593-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] openwrt-feed-alfred: Switch to HTTPS version
	of links
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

open-mesh.org and its subdomains can only be accessed via HTTPS. HTTP-only
requests are currently redirected automatically to HTTPS but references to it
should be only https.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 alfred/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/alfred/Makefile b/alfred/Makefile
index 3dba9b3..48b2a8b 100644
--- a/alfred/Makefile
+++ b/alfred/Makefile
@@ -8,7 +8,7 @@
 include $(TOPDIR)/rules.mk
 
 #
-# The latest alfred git hash in PKG_REV can be obtained from http://git.open-mesh.org/alfred.git
+# The latest alfred git hash in PKG_REV can be obtained from https://git.open-mesh.org/alfred.git
 #
 PKG_NAME:=alfred
 PKG_VERSION:=2015.1
-- 
2.6.2

