Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu,  6 Dec 2018 07:36:20 +0100
Message-Id: <20181206063620.5191-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Allow to disable depmod
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

On some build systems, the actual call to depmod is not expected and only
the installation of the module is expected. Just allow to overwrite this
call with a different (dummy) executable.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d665c0ba..08ac8f65 100644
--- a/Makefile
+++ b/Makefile
@@ -45,6 +45,7 @@ export KERNELPATH
 RM ?= rm -f
 CP := cp -fpR
 LN := ln -sf
+DEPMOD := depmod -a
 
 REVISION= $(shell	if [ -d "$(PWD)/.git" ]; then \
 				echo $$(git --git-dir="$(PWD)/.git" describe --always --dirty --match "v*" |sed 's/^v//' 2> /dev/null || echo "[unknown]"); \
@@ -90,7 +91,7 @@ clean:
 
 install: config
 	$(MAKE) -C $(KERNELPATH) $(BUILD_FLAGS) modules_install
-	depmod -a
+	$(DEPMOD)
 
 config:
 	$(PWD)/gen-compat-autoconf.sh $(PWD)/compat-autoconf.h
-- 
2.19.2

