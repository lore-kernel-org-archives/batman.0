Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  7 May 2013 14:51:07 +0200
Message-Id: <1367931069-7177-8-git-send-email-sven@narfation.org>
In-Reply-To: <1367931069-7177-1-git-send-email-sven@narfation.org>
References: <1367931069-7177-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 7/9] batman-adv-devel: Add missing TARGET_*
	flags to batctl compile
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

The compilation step of batctl completely dropped the TARGET_CFLAGS,
TARGET_CPPFLAGS and TARGET_LDFLAGS and therefore weren't compiled and linked
with the flags given by the OpenWRT build environment.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batman-adv-devel/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/batman-adv-devel/Makefile b/batman-adv-devel/Makefile
index 0958f38..b9e2650 100644
--- a/batman-adv-devel/Makefile
+++ b/batman-adv-devel/Makefile
@@ -85,7 +85,9 @@ $(eval $(call Download,batctl))
 
 BATCTL_EXTRACT = tar xzf "$(DL_DIR)/$(PKG_BATCTL_FNAME)" -C "$(BUILD_DIR)/$(PKG_NAME)"
 BATCTL_PATCH = $(call Build/DoPatch,"$(PKG_BATCTL_BUILD_DIR)","$(PATCH_DIR)","*batctl*")
-BATCTL_BUILD = $(MAKE) -C $(PKG_BATCTL_BUILD_DIR) $(MAKE_BATCTL_ARGS)
+BATCTL_BUILD =	CPPFLAGS="$(TARGET_CPPFLAGS)" CFLAGS="$(TARGET_CFLAGS)" \
+		LDFLAGS="$(TARGET_LDFLAGS)" \
+		$(MAKE) -C $(PKG_BATCTL_BUILD_DIR) $(MAKE_BATCTL_ARGS)
 BATCTL_INSTALL = $(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/local/sbin/batctl $(1)/usr/sbin/
 endif
 
-- 
1.8.2.1

