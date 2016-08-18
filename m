Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Thu, 18 Aug 2016 04:17:47 +0200
Message-Id: <20160818021747.15601-2-linus.luessing@c0d3.blue>
In-Reply-To: <20160818021747.15601-1-linus.luessing@c0d3.blue>
References: <20160818021747.15601-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC PATCH 2/2] batman-adv: Allow selecting BATMAN V
	if CFG80211 is not built
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

With the new stub for cfg80211_get_station(), we can now build the
BATMAN V protocol even with a kernel that was built without any
wireless support.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

---
ToDo: compat-code
---
 net/batman-adv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index 833bb14..01ea6e3 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -17,7 +17,7 @@ config BATMAN_ADV
 
 config BATMAN_ADV_BATMAN_V
 	bool "B.A.T.M.A.N. V protocol (experimental)"
-	depends on BATMAN_ADV && CFG80211=y || (CFG80211=m && BATMAN_ADV=m)
+	depends on BATMAN_ADV && !(CFG80211=m && BATMAN_ADV=y)
 	default n
 	help
 	  This option enables the B.A.T.M.A.N. V protocol, the successor
-- 
2.1.4

