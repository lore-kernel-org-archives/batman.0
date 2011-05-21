Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2011 14:28:12 +0200
Message-Id: <1305980898-30494-8-git-send-email-sven@narfation.org>
In-Reply-To: <1305980898-30494-1-git-send-email-sven@narfation.org>
References: <1305980898-30494-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 08/14] batctl: Build binary before installing
	it
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
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index a06177d..c8cb62f 100755
--- a/Makefile
+++ b/Makefile
@@ -57,7 +57,7 @@ $(BINARY_NAME): $(OBJ) Makefile
 clean:
 	rm -f $(BINARY_NAME) $(OBJ) $(DEP)
 
-install:
+install: $(BINARY_NAME)
 	mkdir -p $(SBINDIR)
 	install -m 0755 $(BINARY_NAME) $(SBINDIR)
 
-- 
1.7.5.1

