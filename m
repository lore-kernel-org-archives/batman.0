Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  7 May 2013 14:51:08 +0200
Message-Id: <1367931069-7177-9-git-send-email-sven@narfation.org>
In-Reply-To: <1367931069-7177-1-git-send-email-sven@narfation.org>
References: <1367931069-7177-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 8/9] batman-adv-devel: Use section garbage
	collection to reduce binary size
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

The linker can identify unused sections of a binary when each symbol is stored
in a separate section. This mostly removes unused linker sections and reduces
the size by ~3% on mipsel.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batman-adv-devel/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/batman-adv-devel/Makefile b/batman-adv-devel/Makefile
index b9e2650..6dc66b8 100644
--- a/batman-adv-devel/Makefile
+++ b/batman-adv-devel/Makefile
@@ -76,6 +76,9 @@ MAKE_BATCTL_ARGS += \
 	STRIP="/bin/true" \
 	batctl install
 
+TARGET_CFLAGS  += -ffunction-sections -fdata-sections
+TARGET_LDFLAGS += -Wl,--gc-sections
+
 ifneq ($(DEVELOPER)$(CONFIG_KMOD_BATMAN_ADV_DEVEL_BATCTL),)
 define Download/batctl
   FILE:=$(PKG_BATCTL_FNAME)
-- 
1.8.2.1

