Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 2/2] vxlan: Copy needed_tailroom from lowerdev
Date: Thu, 26 Nov 2020 13:52:47 +0100
Message-Id: <20201126125247.1047977-2-sven@narfation.org>
In-Reply-To: <20201126125247.1047977-1-sven@narfation.org>
References: <20201126125247.1047977-1-sven@narfation.org>
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
To: netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, Sven Eckelmann <sven@narfation.org>

While vxlan doesn't need any extra tailroom, the lowerdev might need it. In
that case, copy it over to reduce the chance for additional (re)allocations
in the transmit path.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 drivers/net/vxlan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 25b5b5a2dfea..44bb02122526 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -3801,6 +3801,8 @@ static void vxlan_config_apply(struct net_device *dev,
 		needed_headroom = lowerdev->hard_header_len;
 		needed_headroom += lowerdev->needed_headroom;
 
+		dev->needed_tailroom = lowerdev->needed_tailroom;
+
 		max_mtu = lowerdev->mtu - (use_ipv6 ? VXLAN6_HEADROOM :
 					   VXLAN_HEADROOM);
 		if (max_mtu < ETH_MIN_MTU)
-- 
2.29.2

