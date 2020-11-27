Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 1/3] batman-adv: Consider fragmentation for needed_headroom
Date: Fri, 27 Nov 2020 18:38:47 +0100
Message-Id: <20201127173849.19208-2-sw@simonwunderlich.de>
In-Reply-To: <20201127173849.19208-1-sw@simonwunderlich.de>
References: <20201127173849.19208-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
To: davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

If a batman-adv packets has to be fragmented, then the original batman-adv
packet header is not stripped away. Instead, only a new header is added in
front of the packet after it was split.

This size must be considered to avoid cost intensive reallocations during
the transmission through the various device layers.

Fixes: 7bca68c7844b ("batman-adv: Add lower layer needed_(head|tail)room to own ones")
Reported-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index dad99641df2a..33904595fc56 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -554,6 +554,9 @@ static void batadv_hardif_recalc_extra_skbroom(struct net_device *soft_iface)
 	needed_headroom = lower_headroom + (lower_header_len - ETH_HLEN);
 	needed_headroom += batadv_max_header_len();
 
+	/* fragmentation headers don't strip the unicast/... header */
+	needed_headroom += sizeof(struct batadv_frag_packet);
+
 	soft_iface->needed_headroom = needed_headroom;
 	soft_iface->needed_tailroom = lower_tailroom;
 }
-- 
2.20.1

