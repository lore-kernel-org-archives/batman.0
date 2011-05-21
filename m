Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2011 14:28:06 +0200
Message-Id: <1305980898-30494-2-git-send-email-sven@narfation.org>
In-Reply-To: <1305980898-30494-1-git-send-email-sven@narfation.org>
References: <1305980898-30494-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 02/14] batctl: Don't automatically build in
	parallel
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

Distributions like Gentoo and Debian have policies which make it
necessary to use some kind of environmental variable to control the
parallel build.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 3b9e853..61a81fb 100644
--- a/Makefile
+++ b/Makefile
@@ -53,10 +53,7 @@ REVISION= $(shell	if [ -d .git ]; then \
 
 REVISION_VERSION =\"\ $(REVISION)\"
 
-NUM_CPUS = $(shell nproc 2> /dev/null || echo 1)
-
-all:
-	$(MAKE) -j $(NUM_CPUS) $(BINARY_NAME)
+all: $(BINARY_NAME)
 
 $(BINARY_NAME): $(SRC_O) $(SRC_H) Makefile
 	$(Q_LD)$(CC) -o $@ $(SRC_O) $(LDFLAGS)
-- 
1.7.5.1

