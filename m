Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Thu, 14 Feb 2019 16:51:00 +0100
Message-Id: <20190214155100.10070-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: allow snooping gratuitous ARP
 Replies
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Daniel Ehlers <sargon@toppoint.de>, Matthias Schiffer <mschiffer@universe-factory.net>, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>

A gratuitous ARP Reply has the following format (example):

Sender MAC: 00:12:34:56:78:9A
Sender IP:  192.168.2.3
Target MAC: FF:FF:FF:FF:FF:FF
Target IP:  192.168.2.3

A gratuitous ARP Reply is commonly used to update an ARP table in the
network in an unsolicited way. Here, the host with the MAC address
00:12:34:56:78:9A announces that it is now the owner of 192.168.2.3.
Gratuitous ARP Replies are usually used for redundancy or for IP address
handovers between hosts.

So far, gratuitous ARP Replies were ignored for DAT processing as it
contains a broadcast MAC address. This patch changes this and allows
snooping such ARP messages, too.

Special care needs to be taken with the target MAC, to not accidentally
add this broadcast MAC to the DAT cache.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

---
Gratuitous ARP Replies were ignored since this commit:

ab361a9ccc5 ("batman-adv: filter ARP packets with invalid MAC addresses in DAT")

Daniel Ehlers is currently working on a distributed DHCP server for mesh
networks. For cases like these it would be helpful if userspace programs
were able to add entries to the DAT, too. Sending gratuitous ARP Replies
would be one easy way for userspace tools to do so.

This patch was verified in VMs with gratuitous ARP Replies generated via
"mausezahn". Sending such packets with a 00:00:00:00:00:00 ethernet
frame destination address even allows updating the DAT without actually
broadcasting the original frame into the mesh.

[0]: https://github.com/sargon/ddhcpd,
[1]: https://media.freifunk.net/search/?q=ddhcp
---
 net/batman-adv/distributed-arp-table.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 310a4f35..c8923c7d 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -373,9 +373,12 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 				 u8 *mac_addr, unsigned short vid)
 {
-	struct batadv_dat_entry *dat_entry;
+	struct batadv_dat_entry *dat_entry = NULL;
 	int hash_added;
 
+	if (is_multicast_ether_addr(mac_addr))
+		goto out;
+
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip, vid);
 	/* if this entry is already known, just update it */
 	if (dat_entry) {
@@ -1117,8 +1120,7 @@ static u16 batadv_arp_get_type(struct batadv_priv *bat_priv,
 	/* don't care about the destination MAC address in ARP requests */
 	if (arphdr->ar_op != htons(ARPOP_REQUEST)) {
 		hw_dst = batadv_arp_hw_dst(skb, hdr_size);
-		if (is_zero_ether_addr(hw_dst) ||
-		    is_multicast_ether_addr(hw_dst))
+		if (is_zero_ether_addr(hw_dst))
 			goto out;
 	}
 
-- 
2.11.0

