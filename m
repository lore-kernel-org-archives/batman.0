Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Fri, 29 May 2015 11:05:23 +0200
Message-Id: <1432890328-8247-12-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1432890328-8247-1-git-send-email-antonio@meshcoding.com>
References: <1432890328-8247-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 11/16] batman-adv: Use safer default config
	for optional features
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@meshcoding.com>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

The current default settings for optional features in batman-adv seems to
be based around the idea that the user only compiles what he requires. They
will automatically enabled when they are compiled in. For example the
network coding part of batman-adv is by default disabled in the out-of-tree
module but will be enabled when the code is compiled during the module
build.

But distributions like Debian just enable all features of the batman-adv
kernel module and hope that more experimental features or features with
possible negative effects have to be enabled using some runtime
configuration interface.

The network_coding feature can help in specific setups but also has
drawbacks and is not disabled by default in the out-of-tree module.
Disabling by default in the runtime config seems to be also quite sane.

The bridge_loop_avoidance is the only feature which is disabled by default
but may be necessary even in simple setups. Packet loops may even be
created during the initial node setup when this is not enabled. This is
different than STP on bridges because mesh is usually used on Adhoc WiFi.
Having two nodes (by accident) in the same LAN segment and in the same mesh
network is rather common in this situation.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/network-coding.c | 2 +-
 net/batman-adv/soft-interface.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 89e1d47..4cb70bb 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -155,7 +155,7 @@ err:
  */
 void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv)
 {
-	atomic_set(&bat_priv->network_coding, 1);
+	atomic_set(&bat_priv->network_coding, 0);
 	bat_priv->nc.min_tq = 200;
 	bat_priv->nc.max_fwd_delay = 10;
 	bat_priv->nc.max_buffer_time = 200;
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index d85a45c..9426b83 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -732,7 +732,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->aggregated_ogms, 1);
 	atomic_set(&bat_priv->bonding, 0);
 #ifdef CONFIG_BATMAN_ADV_BLA
-	atomic_set(&bat_priv->bridge_loop_avoidance, 0);
+	atomic_set(&bat_priv->bridge_loop_avoidance, 1);
 #endif
 #ifdef CONFIG_BATMAN_ADV_DAT
 	atomic_set(&bat_priv->distributed_arp_table, 1);
-- 
2.4.2

