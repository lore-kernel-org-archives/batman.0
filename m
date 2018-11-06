Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue,  6 Nov 2018 10:01:50 +0100
Message-Id: <20181106090150.2905-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: enable MCAST by default at
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
To: b.a.t.m.a.n@lists.open-mesh.org

Thanks to rigorous testing in wireless community mesh networks several
issues with multicast entries in the translation table were found and
fixed in the last 1.5 years. Now we see the first larger networks
(a few hundred nodes) with a batman-adv version with multicast
optimizations enabled arising, with no TT / multicast optimization
related issues so far.

Therefore it seems safe to enable multicast optimizations by default not
only in kernel module builds but also for in-kernel builds.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index f75816f5..b70b96cd 100644
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

