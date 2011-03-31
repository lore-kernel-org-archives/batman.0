Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 31 Mar 2011 18:11:37 +0200
Message-Id: <1301587899-9449-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batctl: Remove obsolete creation of
	source packages
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

The creation of source packages is now either done by the release team
using special scripts or through gitweb. It is not needed to provide the
source target inside the Makefile and may not work in the future anyway.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index a992e89..b5b4e2b 100644
--- a/Makefile
+++ b/Makefile
@@ -69,11 +69,8 @@ REVISION= $(shell	if [ -d .svn ]; then \
 
 REVISION_VERSION =\"\ $(REVISION)\"
 
-BAT_VERSION = $(shell grep "^\#define SOURCE_VERSION " $(SOURCE_VERSION_HEADER) | sed -e '1p' -n | awk -F '"' '{print $$2}' | awk '{print $$1}')
-FILE_NAME = $(PACKAGE_NAME)_$(BAT_VERSION)-rv$(REVISION)_$@
 NUM_CPUS = $(shell nproc 2> /dev/null || echo 1)
 
-
 all:
 	$(MAKE) -j $(NUM_CPUS) $(BINARY_NAME)
 
@@ -84,25 +81,9 @@ $(BINARY_NAME): $(SRC_O) $(SRC_H) Makefile
 	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -MD -c $< -o $@
 -include $(SRC_C:.c=.d)
 
-sources:
-	mkdir -p $(FILE_NAME)
-
-	for i in $$( find . | grep $(SRC_FILES) | grep -v "\.svn" ); do [ -d $$i ] && mkdir -p $(FILE_NAME)/$$i ; [ -f $$i ] && cp -Lvp $$i $(FILE_NAME)/$$i ;done
-
-	wget -O changelog.html  http://www.open-mesh.net/log/$(LOG_BRANCH)/
-	html2text -o changelog.txt -nobs -ascii changelog.html
-	awk '/View revision/,/10\/01\/06 20:23:03/' changelog.txt > $(FILE_NAME)/CHANGELOG
-
-	for i in $$( find man |	grep -v "\.svn" ); do [ -f $$i ] && groff -man -Thtml $$i > $(FILE_NAME)/$$i.html ;done
-
-	tar czvf $(FILE_NAME).tgz $(FILE_NAME)
-
 clean:
 	rm -f $(BINARY_NAME) *.o *.d
 
-clean-long:
-	rm -rf $(PACKAGE_NAME)_*
-
 install:
 	mkdir -p $(SBINDIR)
 	install -m 0755 $(BINARY_NAME) $(SBINDIR)
-- 
1.7.4.1

