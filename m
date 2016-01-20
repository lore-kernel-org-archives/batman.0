Return-Path: <sven@open-mesh.com>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Wed, 20 Jan 2016 16:44:25 +0100
Message-Id: <1453304665-30753-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Ignore temporary files in
	git-status/git-add/...
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
Cc: Sven Eckelmann <sven@open-mesh.com>

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 .gitattributes | 2 ++
 .gitignore     | 8 ++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 .gitattributes
 create mode 100644 .gitignore

diff --git a/.gitattributes b/.gitattributes
new file mode 100644
index 0000000..eeef3e0
--- /dev/null
+++ b/.gitattributes
@@ -0,0 +1,2 @@
+/.gitignore export-ignore
+/.gitattributes export-ignore
diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..59c6a30
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,8 @@
+/compat-autoconf.h
+/compat-autoconf.h.tmp
+/net/batman-adv/.*
+/net/batman-adv/batman-adv.ko
+/net/batman-adv/batman-adv.mod.c
+/net/batman-adv/modules.order
+/net/batman-adv/Module.symvers
+/net/batman-adv/*.o
-- 
2.7.0.rc3

