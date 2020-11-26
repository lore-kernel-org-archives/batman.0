Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batman-adv: Consider fragmentation for needed_headroom
Date: Thu, 26 Nov 2020 18:18:32 +0100
Message-Id: <20201126171832.1064799-1-sven@narfation.org>
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>

If a batman-adv packets has to be fragmented, then the original batman-adv
packet header is not stripped away. Instead, only a new header is added in
front of the packet after it was splitted.

This size must be considered to avoid cost intensive reallocations during
the transmission through the various device layers.

Reported-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hard-interface.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index f122e448..bbedb9a4 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -553,6 +553,9 @@ static void batadv_hardif_recalc_extra_skbroom(struct net_device *soft_iface)
 	needed_headroom = lower_headroom + (lower_header_len - ETH_HLEN);
 	needed_headroom += batadv_max_header_len();
 
+	/* fragmentation headers don't strip the unicast/... header */
+	needed_headroom += sizeof(struct batadv_frag_packet);
+
 	soft_iface->needed_headroom = needed_headroom;
 	soft_iface->needed_tailroom = lower_tailroom;
 }
-- 
2.29.2

