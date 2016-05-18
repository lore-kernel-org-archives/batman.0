Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Wed, 18 May 2016 11:58:52 +0200
Message-Id: <1463565532-13354-1-git-send-email-sven.eckelmann@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Ignore auto-generated files in
	compat-sources
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index 59c6a30..4c03561 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,5 +1,7 @@
 /compat-autoconf.h
 /compat-autoconf.h.tmp
+/compat-sources/**/.*
+/compat-sources/**/*.o
 /net/batman-adv/.*
 /net/batman-adv/batman-adv.ko
 /net/batman-adv/batman-adv.mod.c
-- 
2.8.1

