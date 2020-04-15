Return-Path: <xiyuyang19@fudan.edu.cn>
From: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Subject: [PATCH] batman-adv: Fix refcnt leak in batadv_show_throughput_override
Date: Wed, 15 Apr 2020 16:31:50 +0800
Message-Id: <1586939510-69461-1-git-send-email-xiyuyang19@fudan.edu.cn>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yuanxzhang@fudan.edu.cn, kjlu@umn.edu, Xiyu Yang <xiyuyang19@fudan.edu.cn>, Xin Tan <tanxin.ctf@gmail.com>

batadv_show_throughput_override() invokes batadv_hardif_get_by_netdev(),
which gets a batadv_hard_iface object from net_dev with increased refcnt
and its reference is assigned to a local pointer 'hard_iface'.

When batadv_show_throughput_override() returns, "hard_iface" becomes
invalid, so the refcount should be decreased to keep refcount balanced.

The issue happens in the normal path of
batadv_show_throughput_override(), which forgets to decrease the refcnt
increased by batadv_hardif_get_by_netdev() before the function returns,
causing a refcnt leak.

Fix this issue by calling batadv_hardif_put() before the
batadv_show_throughput_override() returns in the normal path.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 net/batman-adv/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 97736696d042..0f962dcd239e 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -1190,6 +1190,7 @@ static ssize_t batadv_show_throughput_override(struct kobject *kobj,
 
 	tp_override = atomic_read(&hard_iface->bat_v.throughput_override);
 
+	batadv_hardif_put(hard_iface);
 	return sprintf(buff, "%u.%u MBit\n", tp_override / 10,
 		       tp_override % 10);
 }
-- 
2.7.4

