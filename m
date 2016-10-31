Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 31 Oct 2016 08:36:27 +0100
Message-Id: <20161031073629.31819-4-sven@narfation.org>
In-Reply-To: <1637163.TC9CcXIrIP@sven-edge>
References: <1637163.TC9CcXIrIP@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 4/6] batman-adv: Revert "compat: Move netlink
	const compat to coccinelle"
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

This reverts commit 2f9f52d1dfc417201028cc65f91aaddc5eaf493a.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile                             |  3 ++-
 compat-patches/0002-genl-const.INFO  | 15 ---------------
 compat-patches/0002-genl-const.cocci | 10 ----------
 compat-patches/replacements.sh       |  9 +++++++++
 4 files changed, 11 insertions(+), 26 deletions(-)
 delete mode 100644 compat-patches/0002-genl-const.INFO
 delete mode 100644 compat-patches/0002-genl-const.cocci
 create mode 100755 compat-patches/replacements.sh

diff --git a/Makefile b/Makefile
index e9c499f..67f1988 100644
--- a/Makefile
+++ b/Makefile
@@ -108,7 +108,7 @@ install: config $(SOURCE_STAMP)
 config:
 	$(PWD)/gen-compat-autoconf.sh $(PWD)/compat-autoconf.h
 
-$(SOURCE_STAMP): $(SOURCE) compat-patches/*
+$(SOURCE_STAMP): $(SOURCE) compat-patches/* compat-patches/replacements.sh
 	$(MKDIR) $(BUILD_DIR)/net/batman-adv/
 	@$(LN) ../Makefile $(BUILD_DIR)/Makefile
 	@$(RM) $(SOURCE_BUILD)
@@ -126,6 +126,7 @@ $(SOURCE_STAMP): $(SOURCE) compat-patches/*
 			$(SPATCH) $(SPATCH_FLAGS) --dir $(BUILD_DIR) --sp-file compat-patches/$${i} > /dev/null; \
 		fi; \
 	done
+	compat-patches/replacements.sh
 	touch $(SOURCE_STAMP)
 
 .PHONY: all clean install config
diff --git a/compat-patches/0002-genl-const.INFO b/compat-patches/0002-genl-const.INFO
deleted file mode 100644
index 192c5c6..0000000
--- a/compat-patches/0002-genl-const.INFO
+++ /dev/null
@@ -1,15 +0,0 @@
-Newer kernels make generic netlink ops and multicast groups
-const, but older can't have that. We therefore introduce
-__genl_const, which can be defined depending on the kernel.
-
-What kernel versions require this?
-
-XXX: try to SmPLify
-
-The struct genl_ops gave the *option* to make it const via:
-mcgrof@ergon ~/linux (git::master)$ git describe --contains f84f771d9
-v3.13-rc1~33^2~32^2~2
-
-The struct genl_multicast_group was *forced* to be const via:
-mcgrof@ergon ~/linux (git::master)$ git describe --contains 2a94fe48f
-v3.13-rc1~33^2^2
diff --git a/compat-patches/0002-genl-const.cocci b/compat-patches/0002-genl-const.cocci
deleted file mode 100644
index 36c71d6..0000000
--- a/compat-patches/0002-genl-const.cocci
+++ /dev/null
@@ -1,10 +0,0 @@
-@@
-attribute __genl_const;
-@@
-(
--const struct genl_multicast_group
-+__genl_const struct genl_multicast_group
-|
--const struct genl_ops
-+__genl_const struct genl_ops
-)
diff --git a/compat-patches/replacements.sh b/compat-patches/replacements.sh
new file mode 100755
index 0000000..7dcb953
--- /dev/null
+++ b/compat-patches/replacements.sh
@@ -0,0 +1,9 @@
+#! /bin/sh
+
+set -e
+
+# for kernel < 3.13 to make netlink compat code work
+sed -i \
+	-e 's/^static const struct genl_multicast_group batadv_netlink_mcgrps/static __genl_const struct genl_multicast_group batadv_netlink_mcgrps/' \
+	-e 's/^static const struct genl_ops batadv_netlink_ops/static __genl_const struct genl_ops batadv_netlink_ops/' \
+	build/net/batman-adv/netlink.c
-- 
2.10.1

