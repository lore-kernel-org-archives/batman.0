Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Sat, 29 Nov 2014 19:07:46 +0100
Message-Id: <1417284466-32016-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Kconfig,
	Add missing DEBUG_FS dependency
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
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

BATMAN_ADV_DEBUG is using debugfs files for the debugging log. So it
depends on DEBUG_FS which is missing as dependency in the Kconfig file.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 net/batman-adv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index 11660a3aab5a..c6fc8f756c9a 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -62,6 +62,7 @@ config BATMAN_ADV_MCAST
 config BATMAN_ADV_DEBUG
 	bool "B.A.T.M.A.N. debugging"
 	depends on BATMAN_ADV
+	depends on DEBUG_FS
 	help
 	  This is an option for use by developers; most people should
 	  say N here. This enables compilation of support for
-- 
2.1.3

