Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 31 Aug 2018 16:46:47 +0200
Message-Id: <20180831144648.24032-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: Fix segfault when
 writing to throughput_override
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

Fixes: c513176e4b7a ("batman-adv: add throughput override attribute to hard_ifaces")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index f2eef43b..3a76e897 100644
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
2.18.0

