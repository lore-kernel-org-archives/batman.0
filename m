Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2011 15:45:10 +0200
Message-Id: <1305985517-3763-6-git-send-email-sven@narfation.org>
In-Reply-To: <1305985517-3763-1-git-send-email-sven@narfation.org>
References: <1305985517-3763-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 06/13] vis: Mark makefile targets without
	output as PHONY
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

Normally makefile targets should create an output with the same name as
the target. It is necessary to mark them as PHONY to prevent that the
virtual target like all, clean or install aren't executed when a file
with the same name exists.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch depends on other patches submitted earlier:
 - vis: Remove obsolete creation of source packages
 - vis: Remove subversion/svk revision information

 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index d9b011c..5cbff33 100755
--- a/Makefile
+++ b/Makefile
@@ -59,3 +59,5 @@ clean:
 install:
 	mkdir -p $(SBINDIR)
 	install -m 0755 $(BINARY_NAME) $(SBINDIR)
+
+.PHONY: all clean install
-- 
1.7.5.1

