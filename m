Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 28 Mar 2019 16:41:51 +0100
Message-Id: <20190328154152.20552-12-sw@simonwunderlich.de>
In-Reply-To: <20190328154152.20552-1-sw@simonwunderlich.de>
References: <20190328154152.20552-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 11/12] batman-adv: allow updating DAT entry
 timeouts on incoming ARP Replies
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Linus Lüssing <linus.luessing@c0d3.blue>

Currently incoming ARP Replies, for example via a DHT-PUT message, do
not update the timeout for an already existing DAT entry. These ARP
Replies are dropped instead.

This however defeats the purpose of the DHCPACK snooping, for instance.
Right now, a DAT entry in the DHT will be purged every five minutes,
likely leading to a mesh-wide ARP Request broadcast after this timeout.
Which then recreates the entry. The idea of the DHCPACK snooping is to
be able to update an entry before a timeout happens, to avoid ARP Request
flooding.

This patch fixes this issue by updating a DAT entry on incoming
ARP Replies even if a matching DAT entry already exists. While still
filtering the ARP Reply towards the soft-interface, to avoid duplicate
messages on the client device side.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Acked-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 81fc63fc1936..b0af3a11d406 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1434,7 +1434,6 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 			   hw_src, &ip_src, hw_dst, &ip_dst,
 			   dat_entry->mac_addr,	&dat_entry->ip);
 		dropped = true;
-		goto out;
 	}
 
 	/* Update our internal cache with both the IP addresses the node got
@@ -1443,6 +1442,9 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
 	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
 
+	if (dropped)
+		goto out;
+
 	/* If BLA is enabled, only forward ARP replies if we have claimed the
 	 * source of the ARP reply or if no one else of the same backbone has
 	 * already claimed that client. This prevents that different gateways
-- 
2.11.0

