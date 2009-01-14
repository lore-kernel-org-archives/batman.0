From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 14 Jan 2009 13:02:55 +0100
Message-Id: <1231934576-7289-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Change urls to new open-mesh third level
	domains
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Most of the urls are redirected by an 301 Moved permanently but some are
not at the moment. It should not hurt to have the new versions of them
everywhere.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-userspace/Makefile          |    2 +-
 batman-adv-userspace/man/batmand-adv.8 |    2 +-
 batman-experimental/INSTALL            |    4 ++--
 batman-experimental/doc/bmx.tex        |    2 +-
 batman/CHANGELOG                       |    2 +-
 batman/INSTALL                         |    4 ++--
 batman/Makefile                        |    2 +-
 battool/Makefile                       |    2 +-
 vis/Makefile                           |    2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/batman-adv-userspace/Makefile b/batman-adv-userspace/Makefile
index d71b5e6..9826dad 100644
--- a/batman-adv-userspace/Makefile
+++ b/batman-adv-userspace/Makefile
@@ -71,7 +71,7 @@ sources:
 
 	for i in $$( find . | grep $(SRC_FILES) | grep -v "\.svn" ); do [ -d $$i ] && mkdir -p $(FILE_NAME)/$$i ; [ -f $$i ] && cp -Lvp $$i $(FILE_NAME)/$$i ;done
 
-	$(BUILD_PATH)/wget --no-check-certificate -O changelog.html  https://dev.open-mesh.net/batman/log/$(LOG_BRANCH)/
+	$(BUILD_PATH)/wget -O changelog.html  http://www.open-mesh.net/batman/log/$(LOG_BRANCH)/
 	html2text -o changelog.txt -nobs -ascii changelog.html
 	awk '/View revision/,/10\/01\/06 20:23:03/' changelog.txt > $(FILE_NAME)/CHANGELOG
 
diff --git a/batman-adv-userspace/man/batmand-adv.8 b/batman-adv-userspace/man/batmand-adv.8
index 208541c..966f213 100644
--- a/batman-adv-userspace/man/batmand-adv.8
+++ b/batman-adv-userspace/man/batmand-adv.8
@@ -24,7 +24,7 @@ batmand-adv \- better approach to mobile ad-hoc networking, Layer 2 version batm
 .br
 .SH DESCRIPTION
 .B B.A.T.M.A.N
-means better approach to mobile ad-hoc networking, this is a new routing protocol for multi-hop ad-hoc mesh networks. Go to http://open-mesh.net/batman to get more information.
+means better approach to mobile ad-hoc networking, this is a new routing protocol for multi-hop ad-hoc mesh networks. Go to http://www.open-mesh.net/ to get more information.
 .PP
 Unlike batmand, batmand-adv operates on Layer 2, using Ethernet frames to encapsulate protocol and payload data and not UDP/IP. A batmand-adv mesh network is acting like a switch, and after starting the daemon you'll get a virtual network interface "bat0" which can be used like a usual LAN interface. Communication is tunneled directly to other batmand-adv participants.
 .PP
diff --git a/batman-experimental/INSTALL b/batman-experimental/INSTALL
index 3014b0f..fccb6e1 100644
--- a/batman-experimental/INSTALL
+++ b/batman-experimental/INSTALL
@@ -30,7 +30,7 @@ downloads.open-mesh.net is likely to offer precompiled packages
 for your system.
 
 Download and compile the latest stable sources from the download 
-section http://open-mesh.net/batman/downloads by executing eg.:
+section http://www.open-mesh.net/wiki/Download by executing eg.:
 
 �$ wget http://downloads.open-mesh.net/batman/stable/sources/batmand_0.2-current_sources.tgz
 �$ tar xzvf batmand_0.2-current_sources.tgz
@@ -94,7 +94,7 @@ batman for one (or several) interfaces and specify the netmask and IP address
 as well as other optionally parameters.
 
 Alternatively you can get the latest stable release (as well as development) 
-versions from �http://open-mesh.net/batman/downoads/
+versions from �http://www.open-mesh.net/wiki/Download
 
 For example to install batmand-0.2 on a freifunk WRT do:
 
diff --git a/batman-experimental/doc/bmx.tex b/batman-experimental/doc/bmx.tex
index e4fcb5c..6d1b945 100755
--- a/batman-experimental/doc/bmx.tex
+++ b/batman-experimental/doc/bmx.tex
@@ -1956,7 +1956,7 @@ Wesley Tsai (wesleyboy-at-gmail.com)
 
 \bibitem{svn-batmand-install} 
 {batmand subversion repository},\\
-{https://dev.open-mesh.net/svn/batman/trunk/batman/INSTALL}
+{http://downloads.open-mesh.net/svn/batman/trunk/batman/INSTALL}
 
 \bibitem{bmx-source-url}
 {batmand-experimental download URL},\\
diff --git a/batman/CHANGELOG b/batman/CHANGELOG
index 99d0e2a..40089f3 100644
--- a/batman/CHANGELOG
+++ b/batman/CHANGELOG
@@ -1,3 +1,3 @@
 For a reasonable up-to-date CHANGELOG visit:
 
-https://dev.open-mesh.net/batman/log/trunk
+https://www.open-mesh.net/batman/log/trunk
diff --git a/batman/INSTALL b/batman/INSTALL
index bf3434b..3f44760 100644
--- a/batman/INSTALL
+++ b/batman/INSTALL
@@ -32,7 +32,7 @@ downloads.open-mesh.net likely offers precompiled packages
 for your system.
 
 Download and compile the latest stable sources from the download
-section http://open-mesh.net/batman/downloads by executing eg.:
+section http://www.open-mesh.net/wiki/Download by executing eg.:
 
 $ wget http://downloads.open-mesh.net/batman/releases/batman-0.3.1/batman-0.3.1.tar.gz
 $ tar xzvf batman-0.3.1.tar.gz
@@ -94,7 +94,7 @@ batman for one (or several) interfaces and specify the netmask and IP address
 as well as other optionally parameters.
 
 Alternatively you can get the latest stable release (as well as development)
-versions from http://open-mesh.net/batman/downoads/
+versions from http://www.open-mesh.net/wiki/Download
 
 For example to install batmand-0.2 on a freifunk WRT do:
 
diff --git a/batman/Makefile b/batman/Makefile
index f956a2e..95eb682 100644
--- a/batman/Makefile
+++ b/batman/Makefile
@@ -89,7 +89,7 @@ sources:
 
 	for i in $$( find . | grep $(SRC_FILES) | grep -v "\.svn" ); do [ -d $$i ] && mkdir -p $(FILE_NAME)/$$i ; [ -f $$i ] && cp -Lvp $$i $(FILE_NAME)/$$i ;done
 
-	wget --no-check-certificate -O changelog.html  https://dev.open-mesh.net/batman/log/$(LOG_BRANCH)/
+	wget -O changelog.html  http://www.open-mesh.net/batman/log/$(LOG_BRANCH)/
 	html2text -o changelog.txt -nobs -ascii changelog.html
 	awk '/View revision/,/10\/01\/06 20:23:03/' changelog.txt > $(FILE_NAME)/CHANGELOG
 
diff --git a/battool/Makefile b/battool/Makefile
index 805e454..01afe84 100644
--- a/battool/Makefile
+++ b/battool/Makefile
@@ -81,7 +81,7 @@ sources:
 
 	for i in $$( find . | grep $(SRC_FILES) | grep -v "\.svn" ); do [ -d $$i ] && mkdir -p $(FILE_NAME)/$$i ; [ -f $$i ] && cp -Lvp $$i $(FILE_NAME)/$$i ;done
 
-	$(BUILD_PATH)/wget --no-check-certificate -O changelog.html  https://dev.open-mesh.net/batman/log/$(LOG_BRANCH)/
+	$(BUILD_PATH)/wget -O changelog.html  http://www.open-mesh.net/batman/log/$(LOG_BRANCH)/
 	html2text -o changelog.txt -nobs -ascii changelog.html
 	awk '/View revision/,/10\/01\/06 20:23:03/' changelog.txt > $(FILE_NAME)/CHANGELOG
 
diff --git a/vis/Makefile b/vis/Makefile
index e91b621..1b39f04 100644
--- a/vis/Makefile
+++ b/vis/Makefile
@@ -100,7 +100,7 @@ sources:
 	
 	for i in $$( find . | grep $(SRC_FILES) | grep -v "\.svn" ); do [ -d $$i ] && mkdir -p $(FILE_NAME)/$$i ; [ -f $$i ] && cp -Lvp $$i $(FILE_NAME)/$$i ;done
 	
-	$(BUILD_PATH)/wget --no-check-certificate -O changelog.html  https://dev.open-mesh.net/batman/log/$(LOG_BRANCH)/
+	$(BUILD_PATH)/wget -O changelog.html  http://www.open-mesh.net/batman/log/$(LOG_BRANCH)/
 	html2text -o changelog.txt -nobs -ascii changelog.html
 	awk '/View revision/,/10\/01\/06 20:23:03/' changelog.txt > $(FILE_NAME)/CHANGELOG
 		
-- 
1.6.0.6

