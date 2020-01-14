Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 7/7] batman-adv: Disable CONFIG_BATMAN_ADV_SYSFS by default
Date: Tue, 14 Jan 2020 15:23:51 +0100
Message-Id: <20200114142351.26622-8-sw@simonwunderlich.de>
In-Reply-To: <20200114142351.26622-1-sw@simonwunderlich.de>
References: <20200114142351.26622-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The sysfs support in batman-adv is deprecated since a while and will be
removed completely next year.

All tools which were known to the batman-adv development team are
supporting the batman-adv netlink interface since a while. Thus
disabling CONFIG_BATMAN_ADV_SYSFS by default should not cause problems on
most systems. It is still possible to enable it in case it is still
required in a specific setup.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index 045b2b183213..c762758a4649 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -100,7 +100,6 @@ config BATMAN_ADV_DEBUG
 config BATMAN_ADV_SYSFS
 	bool "batman-adv sysfs entries"
 	depends on BATMAN_ADV
-	default y
 	help
 	  Say Y here if you want to enable batman-adv device configuration and
 	  status interface through sysfs attributes. It is replaced by the
-- 
2.20.1

