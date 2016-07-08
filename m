Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Fri,  8 Jul 2016 11:38:35 +0200
Message-Id: <1467970715-18251-1-git-send-email-sven.eckelmann@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv-devel: Exchange include order for
	uapi header files
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

The build of netlink.c currently fails because the definition of
GENL_NAMESIZE and similar things are missing. This is is caused by an
incorrect order of backports and non-backports header files mixed up with
uapi and non-uapi header files. Parts of the header files would not get
included by include_next because it not anymore in the remaining search
paths.

Reported: Marek Lindner <marek.lindner@open-mesh.com>
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
Please check again - I might have forgotten something.
---
 batman-adv-devel/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/batman-adv-devel/Makefile b/batman-adv-devel/Makefile
index 60ac5fd..4fa20ab 100644
--- a/batman-adv-devel/Makefile
+++ b/batman-adv-devel/Makefile
@@ -64,10 +64,10 @@ PKG_EXTRA_CFLAGS:= \
 NOSTDINC_FLAGS = \
 	-I$(PKG_BUILD_DIR)/net/batman-adv \
 	-I$(PKG_BUILD_DIR)/include/ \
-	-I$(STAGING_DIR)/usr/include/mac80211-backport/uapi \
 	-I$(STAGING_DIR)/usr/include/mac80211-backport \
-	-I$(STAGING_DIR)/usr/include/mac80211/uapi \
+	-I$(STAGING_DIR)/usr/include/mac80211-backport/uapi \
 	-I$(STAGING_DIR)/usr/include/mac80211 \
+	-I$(STAGING_DIR)/usr/include/mac80211/uapi \
 	-include backport/backport.h \
 	-include $(PKG_BUILD_DIR)/compat-hacks.h \
 	-DBATADV_SOURCE_VERSION=\\\"$(PKG_BATMAN_SHORTREV)\\\" \
-- 
2.8.1

