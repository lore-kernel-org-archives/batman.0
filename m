Return-Path: <xiyuyang19@fudan.edu.cn>
From: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Subject: [PATCH] batman-adv: Fix refcnt leak in
 batadv_store_throughput_override
Date: Wed, 15 Apr 2020 16:35:21 +0800
Message-Id: <1586939721-69731-1-git-send-email-xiyuyang19@fudan.edu.cn>
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

When batadv_store_throughput_override() returns, "hard_iface" becomes
invalid, so the refcount should be decreased to keep refcount balanced.

The issue happens in one error path of
batadv_store_throughput_override(). When batadv_parse_throughput()
returns NULL, the refcnt increased by batadv_hardif_get_by_netdev() is
not decreased, causing a refcnt leak.

Fix this issue by jumping to "out" label when batadv_parse_throughput()
returns NULL.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 net/batman-adv/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index c45962d8527b..97736696d042 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -1150,7 +1150,7 @@ static ssize_t batadv_store_throughput_override(struct kobject *kobj,
 	ret = batadv_parse_throughput(net_dev, buff, "throughput_override",
 				      &tp_override);
 	if (!ret)
-		return count;
+		goto out;
 
 	old_tp_override = atomic_read(&hard_iface->bat_v.throughput_override);
 	if (old_tp_override == tp_override)
-- 
2.7.4

