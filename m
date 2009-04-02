From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu,  2 Apr 2009 16:23:12 +0200
Message-Id: <1238682192-25240-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Don't access random memory after forwarding
	broadcast
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

B.A.T.M.A.N. advanced iterates over every known interface when receiving
data and tries to forward as much as possible data from the same
interface as possible using a while-loop inside the outer loop.
When it receives a broadcast ethernet frame which needs to be forwarded
again it will try to send it to every known interface again. This loop
is inside the first one and used the same pos variable as the outer
loop. After the inner loop has finished it will point to a memory
location which is not part of the interface list, but the while loop
starts again and tries to access this memory region without knowing what
it is and to what it belongs. This could lead to a kernel oops or any
kind of other unspecified behavior of the kernel.
The inner loop should use a seperate position variable to iterate over
all interfaces for the broadcast.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/routing.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/batman-adv-kernelland/routing.c b/batman-adv-kernelland/routing.c
index 73e786e..89bfb3f 100644
--- a/batman-adv-kernelland/routing.c
+++ b/batman-adv-kernelland/routing.c
@@ -567,7 +567,7 @@ int receive_raw_packet(struct socket *raw_sock, unsigned char *packet_buff, int
 
 int packet_recv_thread(void *data)
 {
-	struct batman_if *batman_if;
+	struct batman_if *batman_if, *batman_bcastif;
 	struct ethhdr *ethhdr;
 	struct batman_packet *batman_packet;
 	struct unicast_packet *unicast_packet;
@@ -851,8 +851,8 @@ int packet_recv_thread(void *data)
 					interface_rx(soft_device, packet_buff + sizeof(struct ethhdr) + sizeof(struct bcast_packet), result - sizeof(struct ethhdr) - sizeof(struct bcast_packet));
 
 					/* rebroadcast packet */
-					list_for_each_entry_rcu(batman_if, &if_list, list) {
-						send_raw_packet(packet_buff + sizeof(struct ethhdr), result - sizeof(struct ethhdr), batman_if->net_dev->dev_addr, broadcastAddr, batman_if);
+					list_for_each_entry_rcu(batman_bcastif, &if_list, list) {
+						send_raw_packet(packet_buff + sizeof(struct ethhdr), result - sizeof(struct ethhdr), batman_bcastif->net_dev->dev_addr, broadcastAddr, batman_bcastif);
 					}
 
 					break;
-- 
1.6.2.1

