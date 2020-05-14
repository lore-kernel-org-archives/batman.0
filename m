Return-Path: <sashal@kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 07/39] batman-adv: Fix refcnt leak in batadv_v_ogm_process
Date: Thu, 14 May 2020 14:54:24 -0400
Message-Id: <20200514185456.21060-7-sashal@kernel.org>
In-Reply-To: <20200514185456.21060-1-sashal@kernel.org>
References: <20200514185456.21060-1-sashal@kernel.org>
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

[ Upstream commit 6f91a3f7af4186099dd10fa530dd7e0d9c29747d ]

batadv_v_ogm_process() invokes batadv_hardif_neigh_get(), which returns
a reference of the neighbor object to "hardif_neigh" with increased
refcount.

When batadv_v_ogm_process() returns, "hardif_neigh" becomes invalid, so
the refcount should be decreased to keep refcount balanced.

The reference counting issue happens in one exception handling paths of
batadv_v_ogm_process(). When batadv_v_ogm_orig_get() fails to get the
orig node and returns NULL, the refcnt increased by
batadv_hardif_neigh_get() is not decreased, causing a refcnt leak.

Fix this issue by jumping to "out" label when batadv_v_ogm_orig_get()
fails to get the orig node.

Fixes: 9323158ef9f4 ("batman-adv: OGMv2 - implement originators logic")
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/bat_v_ogm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index cec31769bb3fc..f0abbbdafe07f 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -734,7 +734,7 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 
 	orig_node = batadv_v_ogm_orig_get(bat_priv, ogm_packet->orig);
 	if (!orig_node)
-		return;
+		goto out;
 
 	neigh_node = batadv_neigh_node_get_or_create(orig_node, if_incoming,
 						     ethhdr->h_source);
-- 
2.20.1

