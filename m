Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 21 May 2011 01:33:07 +0200
Message-Id: <1305934387-25000-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: use is_broadcast_ether_addr()
	instead of compare_eth(.., brd_addr)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

Instead of comparing mac addresses with the broadcast address by means
of compare_eth(), the is_broadcast_ether_addr() kernel function has to be
used.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 routing.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/routing.c b/routing.c
index 07f23ba..90ae6f0 100644
--- a/routing.c
+++ b/routing.c
@@ -661,7 +661,7 @@ void receive_bat_packet(const struct ethhdr *ethhdr,
 				hard_iface->net_dev->dev_addr))
 			is_my_oldorig = 1;
 
-		if (compare_eth(ethhdr->h_source, broadcast_addr))
+		if (is_broadcast_ether_addr(ethhdr->h_source))
 			is_broadcast = 1;
 	}
 	rcu_read_unlock();
-- 
1.7.3.4

