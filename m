Return-Path: <linux+b.a.t.m.a.n=lists.open-mesh.org@arm.linux.org.uk>
Date: Sat, 30 Nov 2013 19:15:53 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Message-ID: <20131130191553.GA16735@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [B.A.T.M.A.N.] [PATCH] Fix ARM BUILD_BUG_ON() errors with batman-adv
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
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <antonio@meshcoding.com>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org

From: Russell King <rmk+kernel@arm.linux.org.uk>

The following errors were observed on ARM during a randconfig build.
This patch addresses them by ensuring that the batadv_header structure
is appropriately packed; this structure contains three 8-bit elements
so there should be no undesired side effect from this packing.

net/batman-adv/main.c: In function 'batadv_init':
net/batman-adv/main.c:425:279: error: call to '__compiletime_assert_425' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct batadv_unicast_4addr_packet, src) != 10
net/batman-adv/main.c:426:267: error: call to '__compiletime_assert_426' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct batadv_unicast_packet, dest) != 4
net/batman-adv/main.c:427:275: error: call to '__compiletime_assert_427' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct batadv_unicast_tvlv_packet, dst) != 4
net/batman-adv/main.c:428:261: error: call to '__compiletime_assert_428' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct batadv_frag_packet, dest) != 4
net/batman-adv/main.c:429:271: error: call to '__compiletime_assert_429' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct batadv_icmp_packet, icmph.dst) != 4
net/batman-adv/main.c:430:277: error: call to '__compiletime_assert_430' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct batadv_icmp_packet_rr, icmph.dst) != 4

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 net/batman-adv/packet.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 207459b62966..4039f25794e0 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -171,7 +171,7 @@ struct batadv_header {
 	/* the parent struct has to add a byte after the header to make
 	 * everything 4 bytes aligned again
 	 */
-};
+} __attribute__((packed));
 
 /**
  * struct batadv_ogm_packet - ogm (routing protocol) packet
