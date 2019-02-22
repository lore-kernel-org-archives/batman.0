Return-Path: <anders.roxell@linaro.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 22 Feb 2019 16:25:54 +0100
Message-Id: <20190222152554.30006-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix warning in function
 batadv_v_elp_get_throughput
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, davem@davemloft.net
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>

When CONFIG_CFG80211 isn't enabled the compiler correcly warns about
'sinfo.pertid' may be unused. It can also happen for other error
conditions that it not warn about.

net/batman-adv/bat_v_elp.c: In function ‘batadv_v_elp_get_throughput.isra.0’:
include/net/cfg80211.h:6370:13: warning: ‘sinfo.pertid’ may be used
 uninitialized in this function [-Wmaybe-uninitialized]
  kfree(sinfo->pertid);
        ~~~~~^~~~~~~~

Rework so that we only release '&sinfo' if cfg80211_get_station returns
zero.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 net/batman-adv/bat_v_elp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index a9b7919c9de5..d5df0114f08a 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -104,8 +104,10 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 
 		ret = cfg80211_get_station(real_netdev, neigh->addr, &sinfo);
 
-		/* free the TID stats immediately */
-		cfg80211_sinfo_release_content(&sinfo);
+		if (!ret) {
+			/* free the TID stats immediately */
+			cfg80211_sinfo_release_content(&sinfo);
+		}
 
 		dev_put(real_netdev);
 		if (ret == -ENOENT) {
-- 
2.19.2

