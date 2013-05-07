Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  7 May 2013 14:51:09 +0200
Message-Id: <1367931069-7177-10-git-send-email-sven@narfation.org>
In-Reply-To: <1367931069-7177-1-git-send-email-sven@narfation.org>
References: <1367931069-7177-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 5/9] batman-adv-devel: Enable Link-time
	optimization
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Sven Eckelmann <sven@narfation.org>

Link-time optimization allows to move parts of the optimization from the single
source file to the global source view. This is done by emitting the GIMPLE
representation in each object file and analyzing it again during the link step.

This reduces the binary size by around 6% on mipsel (this includes parts which
were also removed by garbage collection).

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batman-adv-devel/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/batman-adv-devel/Makefile b/batman-adv-devel/Makefile
index 6dc66b8..cad95c6 100644
--- a/batman-adv-devel/Makefile
+++ b/batman-adv-devel/Makefile
@@ -76,8 +76,8 @@ MAKE_BATCTL_ARGS += \
 	STRIP="/bin/true" \
 	batctl install
 
-TARGET_CFLAGS  += -ffunction-sections -fdata-sections
-TARGET_LDFLAGS += -Wl,--gc-sections
+TARGET_CFLAGS  += -ffunction-sections -fdata-sections -flto
+TARGET_LDFLAGS += -Wl,--gc-sections -fuse-linker-plugin
 
 ifneq ($(DEVELOPER)$(CONFIG_KMOD_BATMAN_ADV_DEVEL_BATCTL),)
 define Download/batctl
-- 
1.8.2.1

