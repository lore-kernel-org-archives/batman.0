Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun,  2 Feb 2014 22:53:11 +0800
Message-Id: <1391352791-19305-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: backport eth_hdr() compat fix to
	avoid kernel oops
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>

From: Linus Lüssing <linus.luessing@web.de>

Introduced by 41b38727749a94c1a65cf0f4be9bfe1cbaf0adeb
   ("batman-adv: fix potential kernel paging error for unicast transmissions")

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
CC: Linus Lüssing <linus.luessing@web.de>
---
 compat.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/compat.h b/compat.h
index a4ab202..deea92b 100644
--- a/compat.h
+++ b/compat.h
@@ -289,6 +289,17 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p) \
 }\
 static int __batadv_interface_set_mac_addr(x, y)
 
+#define batadv_interface_tx(x, y) \
+__batadv_interface_tx(struct sk_buff *skb, struct net_device *soft_iface); \
+static int batadv_interface_tx(struct sk_buff *skb, \
+			       struct net_device *soft_iface) \
+{ \
+	skb_reset_mac_header(skb); \
+	return __batadv_interface_tx(skb, soft_iface); \
+} \
+static int __batadv_interface_tx(struct sk_buff *skb, \
+				 struct net_device *soft_iface)
+
 #define netdev_master_upper_dev_link netdev_set_master
 #define netdev_upper_dev_unlink(slave, master) netdev_set_master(slave, NULL)
 #define netdev_master_upper_dev_get(dev) \
-- 
1.8.5.3

