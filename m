Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  7 Dec 2011 13:27:16 +0100
Message-Id: <1323260836-30163-1-git-send-email-sven@narfation.org>
In-Reply-To: <1323260777-30119-1-git-send-email-sven@narfation.org>
References: <1323260777-30119-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Don't try to read commit
	information from target kernel
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

It is possible that the kernel used to build the batman-adv module also
contains a .git directory. The makefile should not try to run git-describe
inside this kernel to prevent that wrong version information is stored in the
generated module.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 99fd366..e2276be 100644
--- a/Makefile
+++ b/Makefile
@@ -32,8 +32,8 @@ endif
 export KERNELPATH
 RM ?= rm -f
 
-REVISION= $(shell	if [ -d .git ]; then \
-				echo $$(git describe --always --dirty --match "v*" |sed 's/^v//' 2> /dev/null || echo "[unknown]"); \
+REVISION= $(shell	if [ -d "$(PWD)/.git" ]; then \
+				echo $$(git --git-dir="$(PWD)/.git" describe --always --dirty --match "v*" |sed 's/^v//' 2> /dev/null || echo "[unknown]"); \
 			fi)
 
 CONFIG_BATMAN_ADV=m
-- 
1.7.7.3

