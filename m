Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  9 Oct 2016 08:57:35 +0200
Message-Id: <20161009065738.8279-8-sven@narfation.org>
In-Reply-To: <1647833.jYley1tZnH@sven-edge>
References: <1647833.jYley1tZnH@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH v2 08/11] batman-adv: compat: Remove
	replacement script
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
v2:
 - new patch
---
 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

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
-- 
2.9.3

