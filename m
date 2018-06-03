Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sun,  3 Jun 2018 18:52:03 +0800
Message-Id: <20180603105203.29083-1-a@unstable.cc>
In-Reply-To: <20180525200312.13527-2-sven@narfation.org>
References: <20180525200312.13527-2-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: enable DAT by default at compile
 time
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
Cc: Antonio Quartulli <a@unstable.cc>

DAT (Distributed ARP Table) has been enabled by default
in the out-of-tree batman-adv kernel module for several
years already.
It can now be enabled in the kernel too.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---

This patch will obviously confict with
("batman-adv: Remove "default n" in Kconfig")

 net/batman-adv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index de8034d8..770894eb 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -60,7 +60,7 @@ config BATMAN_ADV_BLA
 config BATMAN_ADV_DAT
 	bool "Distributed ARP Table"
 	depends on BATMAN_ADV && INET
-	default n
+	default y
 	help
 	  This option enables DAT (Distributed ARP Table), a DHT based
 	  mechanism that increases ARP reliability on sparse wireless
-- 
2.17.1

