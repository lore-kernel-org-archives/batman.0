Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  4 May 2011 10:06:29 +0200
Message-Id: <1304496393-16405-2-git-send-email-sven@narfation.org>
In-Reply-To: <1304496393-16405-1-git-send-email-sven@narfation.org>
References: <1304496393-16405-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: Rename bat_printk.c to
	compat.c
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile.kbuild          |    2 +-
 bat_printk.c => compat.c |    0
 2 files changed, 1 insertions(+), 1 deletions(-)
 rename bat_printk.c => compat.c (100%)

diff --git a/Makefile.kbuild b/Makefile.kbuild
index 0a35006..d469668 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -50,4 +50,4 @@ batman-adv-y += soft-interface.o
 batman-adv-y += translation-table.o
 batman-adv-y += unicast.o
 batman-adv-y += vis.o
-batman-adv-y += bat_printk.o
+batman-adv-y += compat.o
diff --git a/bat_printk.c b/compat.c
similarity index 100%
rename from bat_printk.c
rename to compat.c
-- 
1.7.4.4

