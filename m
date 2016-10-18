Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 15:57:39 +0200
Message-Id: <20161018135743.3705-4-sven@narfation.org>
In-Reply-To: <2219629.dYY2ZvZvNG@bentobox>
References: <2219629.dYY2ZvZvNG@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v3 4/8] batman-adv: compat: Move netlink
	const compat to coccinelle
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
 - removed compat-include/linux/netlink.h changes which are already in master
v2:
 - new patch
---
 compat-patches/0002-genl-const.INFO  | 15 +++++++++++++++
 compat-patches/0002-genl-const.cocci | 10 ++++++++++
 compat-patches/replacements.sh       |  6 ------
 3 files changed, 25 insertions(+), 6 deletions(-)
 create mode 100644 compat-patches/0002-genl-const.INFO
 create mode 100644 compat-patches/0002-genl-const.cocci

diff --git a/compat-patches/0002-genl-const.INFO b/compat-patches/0002-genl-const.INFO
new file mode 100644
index 0000000..192c5c6
--- /dev/null
+++ b/compat-patches/0002-genl-const.INFO
@@ -0,0 +1,15 @@
+Newer kernels make generic netlink ops and multicast groups
+const, but older can't have that. We therefore introduce
+__genl_const, which can be defined depending on the kernel.
+
+What kernel versions require this?
+
+XXX: try to SmPLify
+
+The struct genl_ops gave the *option* to make it const via:
+mcgrof@ergon ~/linux (git::master)$ git describe --contains f84f771d9
+v3.13-rc1~33^2~32^2~2
+
+The struct genl_multicast_group was *forced* to be const via:
+mcgrof@ergon ~/linux (git::master)$ git describe --contains 2a94fe48f
+v3.13-rc1~33^2^2
diff --git a/compat-patches/0002-genl-const.cocci b/compat-patches/0002-genl-const.cocci
new file mode 100644
index 0000000..36c71d6
--- /dev/null
+++ b/compat-patches/0002-genl-const.cocci
@@ -0,0 +1,10 @@
+@@
+attribute __genl_const;
+@@
+(
+-const struct genl_multicast_group
++__genl_const struct genl_multicast_group
+|
+-const struct genl_ops
++__genl_const struct genl_ops
+)
diff --git a/compat-patches/replacements.sh b/compat-patches/replacements.sh
index 7dcb953..c7875c0 100755
--- a/compat-patches/replacements.sh
+++ b/compat-patches/replacements.sh
@@ -1,9 +1,3 @@
 #! /bin/sh
 
 set -e
-
-# for kernel < 3.13 to make netlink compat code work
-sed -i \
-	-e 's/^static const struct genl_multicast_group batadv_netlink_mcgrps/static __genl_const struct genl_multicast_group batadv_netlink_mcgrps/' \
-	-e 's/^static const struct genl_ops batadv_netlink_ops/static __genl_const struct genl_ops batadv_netlink_ops/' \
-	build/net/batman-adv/netlink.c
-- 
2.9.3

