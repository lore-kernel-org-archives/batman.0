Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 15 Sep 2016 15:52:48 +0200
Message-Id: <20160915135249.1925-2-sven@narfation.org>
In-Reply-To: <20160915135249.1925-1-sven@narfation.org>
References: <20160915135249.1925-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH next v2 2/3] batman-adv: Use simple script to
	patch minor compat problems
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

Unified diff base patches have the problem that they fix only a single line
and depend on the surrounding. This approach can fail relative often when
the surrounding code will be changed often. Thus semantic patches (like
spatch from coccinelle) or simple find+replace scripts are better for this
approach.

Introduce a simple script file which will store these kind of find+replace
instructions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - introduce this patch to support the patch 3

 Makefile                       | 3 ++-
 compat-patches/replacements.sh | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)
 create mode 100755 compat-patches/replacements.sh

diff --git a/Makefile b/Makefile
index b105290..7ef2569 100644
--- a/Makefile
+++ b/Makefile
@@ -99,7 +99,7 @@ install: config $(SOURCE_STAMP)
 config:
 	$(PWD)/gen-compat-autoconf.sh $(PWD)/compat-autoconf.h
 
-$(SOURCE_STAMP): $(SOURCE) compat-patches/*
+$(SOURCE_STAMP): $(SOURCE) compat-patches/* compat-patches/replacements.sh
 	$(MKDIR) $(BUILD_DIR)/net/batman-adv/
 	@$(RM) $(SOURCE_BUILD)
 	@$(CP) $(SOURCE) $(BUILD_DIR)/net/batman-adv/
@@ -111,6 +111,7 @@ $(SOURCE_STAMP): $(SOURCE) compat-patches/*
 		$(PATCH) ../compat-patches/$${i}; \
 		cd - > /dev/null; \
 	done
+	compat-patches/replacements.sh
 	touch $(SOURCE_STAMP)
 
 .PHONY: all clean install config
diff --git a/compat-patches/replacements.sh b/compat-patches/replacements.sh
new file mode 100755
index 0000000..c7875c0
--- /dev/null
+++ b/compat-patches/replacements.sh
@@ -0,0 +1,3 @@
+#! /bin/sh
+
+set -e
-- 
2.9.3

