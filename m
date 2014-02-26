Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 26 Feb 2014 13:00:49 +0100
Message-Id: <1393416049-3916-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: use the proper location in
	ether_addr_copy()
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@meshcoding.com>

Introduced by: 513b2d107a4d88f62b9394926e377d2c6250775f
("batman-adv: prefer ether_addr_copy to memcpy")

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---

change from v1:
- added Reported-by clause

 icmp_socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/icmp_socket.c b/icmp_socket.c
index bf07dfd..161ef8f 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -230,7 +230,7 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 		icmp_packet_rr = (struct batadv_icmp_packet_rr *)icmp_header;
 		if (packet_len == sizeof(*icmp_packet_rr)) {
 			addr = neigh_node->if_incoming->net_dev->dev_addr;
-			ether_addr_copy(icmp_packet_rr->rr, addr);
+			ether_addr_copy(icmp_packet_rr->rr[0], addr);
 		}
 
 		break;
-- 
1.8.4.5

