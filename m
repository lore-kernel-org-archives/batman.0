Return-Path: <sashal@kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 06/27] batman-adv: Fix refcnt leak in batadv_store_throughput_override
Date: Thu, 14 May 2020 14:55:29 -0400
Message-Id: <20200514185550.21462-6-sashal@kernel.org>
In-Reply-To: <20200514185550.21462-1-sashal@kernel.org>
References: <20200514185550.21462-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Xiyu Yang <xiyuyang19@fudan.edu.cn>, Xin Tan <tanxin.ctf@gmail.com>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>, Sasha Levin <sashal@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

[ Upstream commit 6107c5da0fca8b50b4d3215e94d619d38cc4a18c ]

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

Fixes: 0b5ecc6811bd ("batman-adv: add throughput override attribute to hard_ifaces")
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index d3fb5396f9473..121e9e7d28cc5 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -1087,7 +1087,7 @@ static ssize_t batadv_store_throughput_override(struct kobject *kobj,
 	ret = batadv_parse_throughput(net_dev, buff, "throughput_override",
 				      &tp_override);
 	if (!ret)
-		return count;
+		goto out;
 
 	old_tp_override = atomic_read(&hard_iface->bat_v.throughput_override);
 	if (old_tp_override == tp_override)
-- 
2.20.1

