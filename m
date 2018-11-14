Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 14 Nov 2018 15:08:04 +0100
Message-Id: <20181114140804.18381-17-sw@simonwunderlich.de>
In-Reply-To: <20181114140804.18381-1-sw@simonwunderlich.de>
References: <20181114140804.18381-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 16/16] batman-adv: enable MCAST by default at
 compile time
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Linus Lüssing <linus.luessing@c0d3.blue>

Thanks to rigorous testing in wireless community mesh networks several
issues with multicast entries in the translation table were found and
fixed in the last 1.5 years. Now we see the first larger networks
(a few hundred nodes) with a batman-adv version with multicast
optimizations enabled arising, with no TT / multicast optimization
related issues so far.

Therefore it seems safe to enable multicast optimizations by default.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index d6b94559f888..c386e6981416 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -82,6 +82,7 @@ config BATMAN_ADV_NC
 config BATMAN_ADV_MCAST
 	bool "Multicast optimisation"
 	depends on BATMAN_ADV && INET && !(BRIDGE=m && BATMAN_ADV=y)
+	default y
 	help
 	  This option enables the multicast optimisation which aims to
 	  reduce the air overhead while improving the reliability of
-- 
2.11.0

