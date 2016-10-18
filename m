Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 15:57:40 +0200
Message-Id: <20161018135743.3705-5-sven@narfation.org>
In-Reply-To: <2219629.dYY2ZvZvNG@bentobox>
References: <2219629.dYY2ZvZvNG@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v3 5/8] batman-adv: Remove replacement compat
	script
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v3:
 - no changes
v2:
 - new patch
---
 Makefile                       | 3 +--
 compat-patches/replacements.sh | 3 ---
 2 files changed, 1 insertion(+), 5 deletions(-)
 delete mode 100755 compat-patches/replacements.sh

diff --git a/Makefile b/Makefile
index 99e67da..7eea0ab 100644
--- a/Makefile
+++ b/Makefile
@@ -107,7 +107,7 @@ install: config $(SOURCE_STAMP)
 config:
 	$(PWD)/gen-compat-autoconf.sh $(PWD)/compat-autoconf.h
 
-$(SOURCE_STAMP): $(SOURCE) compat-patches/* compat-patches/replacements.sh
+$(SOURCE_STAMP): $(SOURCE) compat-patches/*
 	$(MKDIR) $(BUILD_DIR)/net/batman-adv/
 	@$(RM) $(SOURCE_BUILD)
 	@$(CP) $(SOURCE) $(BUILD_DIR)/net/batman-adv/
@@ -124,7 +124,6 @@ $(SOURCE_STAMP): $(SOURCE) compat-patches/* compat-patches/replacements.sh
 			$(SPATCH) $(SPATCH_FLAGS) --dir $(BUILD_DIR) --sp-file compat-patches/$${i} > /dev/null; \
 		fi; \
 	done
-	compat-patches/replacements.sh
 	touch $(SOURCE_STAMP)
 
 .PHONY: all clean install config
diff --git a/compat-patches/replacements.sh b/compat-patches/replacements.sh
deleted file mode 100755
index c7875c0..0000000
--- a/compat-patches/replacements.sh
+++ /dev/null
@@ -1,3 +0,0 @@
-#! /bin/sh
-
-set -e
-- 
2.9.3

