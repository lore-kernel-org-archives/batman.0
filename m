Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 23 Dec 2011 13:15:52 +0100
Message-Id: <1324642552-23038-3-git-send-email-sven@narfation.org>
In-Reply-To: <1324642552-23038-1-git-send-email-sven@narfation.org>
References: <1324642552-23038-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batmand: Fix open-mesh.org URLs
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
 CHANGELOG     |    2 +-
 INSTALL       |   16 ++++++++--------
 man/batmand.8 |    2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 4a39e2d..9552e53 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -1,3 +1,3 @@
 For a reasonable up-to-date CHANGELOG visit:
 
-http://www.open-mesh.net/log/trunk
+http://git.open-mesh.org/?p=batmand.git;a=shortlog
diff --git a/INSTALL b/INSTALL
index 15f53b0..eae3eac 100644
--- a/INSTALL
+++ b/INSTALL
@@ -37,16 +37,16 @@ Remove the comment hash (#) leading this line in the Makefile:
 Compiling
 ---------
 
-You don't necessarily need to compile. May be your distribution
-or our download store offers precompiled packages. Check
-http://www.open-mesh.net/wiki/Download to get an overview.
+You don't necessarily need to compile. May be your distribution or our
+download store offers precompiled packages. Check
+http://www.open-mesh.org/wiki/open-mesh/Download to get an overview.
 
-Download and compile the latest stable sources from the download
-section http://www.open-mesh.net/wiki/Download by executing eg.:
+Download and compile the latest stable sources from the download section
+http://www.open-mesh.org/wiki/open-mesh/Download by executing eg.:
 
-$ wget http://downloads.open-mesh.net/batman/releases/batman-0.3.2/batman-0.3.2.tar.gz
-$ tar xzvf batman-0.3.2.tar.gz
-$ cd batmand-0.3.2
+$ wget http://downloads.open-mesh.org/batman/stable/sources/batmand/batmand-0.3.2.tar.gz
+$ tar xzvf batmand-0.3.2.tar.gz
+$ cd batman-0.3.2
 $ make
 
 After the compilation process is finished you'll find a executable
diff --git a/man/batmand.8 b/man/batmand.8
index 8b57fda..c26d62b 100644
--- a/man/batmand.8
+++ b/man/batmand.8
@@ -28,7 +28,7 @@ batmand \- better approach to mobile ad\(hyhoc networking
 .br
 .SH DESCRIPTION
 .B B.A.T.M.A.N
-means better approach to mobile ad\(hyhoc networking, this is a new routing protocol for multi\(hyhop ad\(hyhoc mesh networks. Go to http://www.open\-mesh.net/ to get more information.
+means better approach to mobile ad\(hyhoc networking, this is a new routing protocol for multi\(hyhop ad\(hyhoc mesh networks. Go to http://www.open\-mesh.org/ to get more information.
 .PP
 The following document will explain how to use the \fBbatman daemon\fP.
 .PP
-- 
1.7.7.3

