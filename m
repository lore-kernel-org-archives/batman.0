Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 31 Oct 2016 08:36:29 +0100
Message-Id: <20161031073629.31819-6-sven@narfation.org>
In-Reply-To: <1637163.TC9CcXIrIP@sven-edge>
References: <1637163.TC9CcXIrIP@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 6/6] batman-adv: Revert "Add support for
	coccinelle in compat-patches"
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

The coccinelle in Debian Jessie seems to be broken. It fails to parse
the patches and thus makes it impossible to use the out-of-tree
module in these systems. Therefore drop it for now.

This reverts commit cd6361c9f4ea19e1318c6549f863a21921154896.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index 67f1988..b852a17 100644
--- a/Makefile
+++ b/Makefile
@@ -40,19 +40,11 @@ ifeq ($(shell cd $(KERNELPATH) && pwd),)
 $(warning $(KERNELPATH) is missing, please set KERNELPATH)
 endif
 
-ifeq ($(origin SPATCH), undefined)
-  SPATCH = spatch
-  ifeq ($(shell which $(SPATCH) 2>/dev/null),)
-    $(error $(SPATCH) (coccinelle) not found)
-  endif
-endif
-
 export KERNELPATH
 RM ?= rm -f
 MKDIR := mkdir -p
 PATCH_FLAGS = --batch --fuzz=0 --forward --strip=1 --unified --version-control=never -g0 --remove-empty-files --no-backup-if-mismatch --reject-file=-
 PATCH := patch $(PATCH_FLAGS) -i
-SPATCH_FLAGS := --in-place --relax-include-path --use-coccigrep --very-quiet
 CP := cp -fpR
 LN := ln -sf
 
@@ -114,17 +106,12 @@ $(SOURCE_STAMP): $(SOURCE) compat-patches/* compat-patches/replacements.sh
 	@$(RM) $(SOURCE_BUILD)
 	@$(CP) $(SOURCE) $(BUILD_DIR)/net/batman-adv/
 	@set -e; \
-	patches="$$(ls -1 compat-patches/|grep -e '.patch$$' -e '.cocci$$'|sort)"; \
+	patches="$$(ls -1 compat-patches/|grep '.patch$$'|sort)"; \
 	for i in $${patches}; do \
-		echo '  COMPAT_PATCH '$${i}; \
-		if echo $${i}|grep '.patch$$'; then \
-			cd $(BUILD_DIR); \
-			$(PATCH) ../compat-patches/$${i}; \
-			cd - > /dev/null; \
-		fi; \
-		if echo $${i}|grep '.cocci$$'; then echo $$(pwd); \
-			$(SPATCH) $(SPATCH_FLAGS) --dir $(BUILD_DIR) --sp-file compat-patches/$${i} > /dev/null; \
-		fi; \
+		echo '  COMPAT_PATCH '$${i};\
+		cd $(BUILD_DIR); \
+		$(PATCH) ../compat-patches/$${i}; \
+		cd - > /dev/null; \
 	done
 	compat-patches/replacements.sh
 	touch $(SOURCE_STAMP)
-- 
2.10.1

