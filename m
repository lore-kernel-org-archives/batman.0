Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 12 Jul 2016 17:08:06 +0800
Message-Id: <1468314486-29592-3-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <1468314486-29592-1-git-send-email-mareklindner@neomailbox.ch>
References: <1468314486-29592-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: retrieve B.A.T.M.A.N. V WiFi
	neighbor stats from real interface
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/bat_v_elp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 51fc08d..7ed3360 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -75,6 +75,7 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 {
 	struct batadv_hard_iface *hard_iface = neigh->if_incoming;
 	struct ethtool_link_ksettings link_settings;
+	struct net_device *real_netdev;
 	struct station_info sinfo;
 	u32 throughput;
 	int ret;
@@ -94,8 +95,13 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 			/* unsupported WiFi driver version */
 			goto default_throughput;
 
-		ret = cfg80211_get_station(hard_iface->net_dev,
-					   neigh->addr, &sinfo);
+		real_netdev = batadv_get_real_netdev(hard_iface->net_dev);
+		if (!real_netdev)
+			goto default_throughput;
+
+		ret = cfg80211_get_station(real_netdev, neigh->addr, &sinfo);
+
+		dev_put(real_netdev);
 		if (ret == -ENOENT) {
 			/* Node is not associated anymore! It would be
 			 * possible to delete this neighbor. For now set
-- 
2.8.0.rc3

