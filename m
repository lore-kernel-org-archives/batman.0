Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 19 Sep 2018 14:22:04 +0200
Message-Id: <20180919122213.23108-3-sw@simonwunderlich.de>
In-Reply-To: <20180919122213.23108-1-sw@simonwunderlich.de>
References: <20180919122213.23108-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 02/11] batman-adv: Fix segfault when writing
 to throughput_override
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

The per hardif sysfs file "batman_adv/throughput_override" prints the
resulting change as info text when the users writes to this file. It uses
the helper function batadv_info to add it at the same time to the kernel
ring buffer and to the batman-adv debug log (when CONFIG_BATMAN_ADV_DEBUG
is enabled).

The function batadv_info requires as first parameter the batman-adv softif
net_device. This parameter is then used to find the private buffer which
contains the debug log for this batman-adv interface. But
batadv_store_throughput_override used as first argument the slave
net_device. This slave device doesn't have the batadv_priv private data
which is access by batadv_info.

Writing to this file with CONFIG_BATMAN_ADV_DEBUG enabled can either lead
to a segfault or to memory corruption.

Fixes: 0b5ecc6811bd ("batman-adv: add throughput override attribute to hard_ifaces")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index f2eef43bd2ec..3a76e8970c02 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -1090,8 +1090,9 @@ static ssize_t batadv_store_throughput_override(struct kobject *kobj,
 	if (old_tp_override == tp_override)
 		goto out;
 
-	batadv_info(net_dev, "%s: Changing from: %u.%u MBit to: %u.%u MBit\n",
-		    "throughput_override",
+	batadv_info(hard_iface->soft_iface,
+		    "%s: %s: Changing from: %u.%u MBit to: %u.%u MBit\n",
+		    "throughput_override", net_dev->name,
 		    old_tp_override / 10, old_tp_override % 10,
 		    tp_override / 10, tp_override % 10);
 
-- 
2.11.0

