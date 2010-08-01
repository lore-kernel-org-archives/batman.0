Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  1 Aug 2010 23:20:08 +0200
Message-Id: <1280697613-32001-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1280697613-32001-1-git-send-email-sven.eckelmann@gmx.de>
References: <1280697613-32001-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/7] batman-adv: Only clone skb data for
	multiple broadcasts
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
To: b.a.t.m.a.n@lists.open-mesh.org

batman-adv tries to resend broadcasts on all interfaces up to three
times. For each round and each interface it must provide a skb which
gets consumed by the sending function.

It is unnecessary to copy the data of each broadcast because the actual
data is either not shared or already copied by add_bcast_packet_to_list.
So it is enough to just copy the skb control data

Reported-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/send.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batman-adv/send.c b/batman-adv/send.c
index fb0bfbf..524c0a9 100644
--- a/batman-adv/send.c
+++ b/batman-adv/send.c
@@ -477,7 +477,7 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
 		/* send a copy of the saved skb */
-		skb1 = skb_copy(forw_packet->skb, GFP_ATOMIC);
+		skb1 = skb_clone(forw_packet->skb, GFP_ATOMIC);
 		if (skb1)
 			send_skb_packet(skb1,
 				batman_if, broadcast_addr);
-- 
1.7.1

