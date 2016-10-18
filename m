Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 15:57:37 +0200
Message-Id: <20161018135743.3705-2-sven@narfation.org>
In-Reply-To: <2219629.dYY2ZvZvNG@bentobox>
References: <2219629.dYY2ZvZvNG@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v3 2/8] batman-adv: Add support for
	coccinelle in compat-patches
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

The kernel and backports already uses spatch from coccinelle for
development and backporting purposes. Thus we can cleanup many current
hacks using semantic patches. These are also a lot less frail than
traditional unified diffs.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v3:
 - no changes
v2:
 - new patch
---
 Makefile | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 7ef2569..99e67da 100644
--- a/Makefile
+++ b/Makefile
@@ -40,11 +40,19 @@ ifeq ($(shell cd $(KERNELPATH) && pwd),)
 $(warning $(KERNELPATH) is missing, please set KERNELPATH)
 endif
 
+ifeq ($(origin SPATCH), undefined)
+  SPATCH = spatch
+  ifeq ($(shell which $(SPATCH) 2>/dev/null),)
+    $(error $(SPATCH) (coccinelle) not found)
+  endif
+endif
+
 export KERNELPATH
 RM ?= rm -f
 MKDIR := mkdir -p
 PATCH_FLAGS = --batch --fuzz=0 --forward --strip=1 --unified --version-control=never -g0 --remove-empty-files --no-backup-if-mismatch --reject-file=-
 PATCH := patch $(PATCH_FLAGS) -i
+SPATCH_FLAGS := --in-place --relax-include-path --use-coccigrep
 CP := cp -fpR
 
 SOURCE = $(wildcard net/batman-adv/*.[ch]) net/batman-adv/Makefile
@@ -104,12 +112,17 @@ $(SOURCE_STAMP): $(SOURCE) compat-patches/* compat-patches/replacements.sh
 	@$(RM) $(SOURCE_BUILD)
 	@$(CP) $(SOURCE) $(BUILD_DIR)/net/batman-adv/
 	@set -e; \
-	patches="$$(ls -1 compat-patches/|grep '.patch$$'|sort)"; \
+	patches="$$(ls -1 compat-patches/|grep -e '.patch$$' -e '.cocci$$'|sort)"; \
 	for i in $${patches}; do \
-		echo '  COMPAT_PATCH '$${i};\
-		cd $(BUILD_DIR); \
-		$(PATCH) ../compat-patches/$${i}; \
-		cd - > /dev/null; \
+		echo '  COMPAT_PATCH '$${i}; \
+		if echo $${i}|grep '.patch$$'; then \
+			cd $(BUILD_DIR); \
+			$(PATCH) ../compat-patches/$${i}; \
+			cd - > /dev/null; \
+		fi; \
+		if echo $${i}|grep '.cocci$$'; then echo $$(pwd); \
+			$(SPATCH) $(SPATCH_FLAGS) --dir $(BUILD_DIR) --sp-file compat-patches/$${i} > /dev/null; \
+		fi; \
 	done
 	compat-patches/replacements.sh
 	touch $(SOURCE_STAMP)
-- 
2.9.3

