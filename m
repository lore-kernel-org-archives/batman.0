Return-Path: <mirq@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20110419104320.0675D1389B@rere.qmqm.pl>
Date: Tue, 19 Apr 2011 12:43:20 +0200 (CEST)
Subject: [B.A.T.M.A.N.] [PATCH] net: batman-adv: remove rx_csum ethtool_ops
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 net/batman-adv/soft-interface.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 1f6f756..f4d80ad 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -43,8 +43,6 @@ static void bat_get_drvinfo(struct net_device *dev,
 static u32 bat_get_msglevel(struct net_device *dev);
 static void bat_set_msglevel(struct net_device *dev, u32 value);
 static u32 bat_get_link(struct net_device *dev);
-static u32 bat_get_rx_csum(struct net_device *dev);
-static int bat_set_rx_csum(struct net_device *dev, u32 data);
 
 static const struct ethtool_ops bat_ethtool_ops = {
 	.get_settings = bat_get_settings,
@@ -52,8 +50,6 @@ static const struct ethtool_ops bat_ethtool_ops = {
 	.get_msglevel = bat_get_msglevel,
 	.set_msglevel = bat_set_msglevel,
 	.get_link = bat_get_link,
-	.get_rx_csum = bat_get_rx_csum,
-	.set_rx_csum = bat_set_rx_csum
 };
 
 int my_skb_head_push(struct sk_buff *skb, unsigned int len)
@@ -736,12 +732,3 @@ static u32 bat_get_link(struct net_device *dev)
 	return 1;
 }
 
-static u32 bat_get_rx_csum(struct net_device *dev)
-{
-	return 0;
-}
-
-static int bat_set_rx_csum(struct net_device *dev, u32 data)
-{
-	return -EOPNOTSUPP;
-}
-- 
1.7.2.5

