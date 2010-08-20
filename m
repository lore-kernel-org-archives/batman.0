Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 20 Aug 2010 17:32:38 +0200
Message-Id: <1282318358-16121-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Don't write in not allocated
	packet_buff
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

Each net_device in a system will automatically managed as a possible
batman_if and holds different informations like a buffer with a prepared
originator messages. To reduce the memory usage, the packet_buff will
only be allocated when the interface is really added/enabled for
batman-adv.

The function to update the hw address information inside the packet_buff
just assumes that the packet_buff is always initialised and thus the
kernel will just oops when we try to change the hw address of a not
already fully enabled interface.

We must always check if the packet_buff is allocated before we try to
change information inside of it.

Reported-by: Tim Glaremin <Tim.Glaremin@web.de>
Reported-by: Lemonde <zukky@bb.banban.jp>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: stable <stable@kernel.org>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/hard-interface.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index eb26026..9d0a47c 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -138,6 +138,9 @@ static bool hardif_is_iface_up(struct batman_if *batman_if)
 
 static void update_mac_addresses(struct batman_if *batman_if)
 {
+	if (!batman_if || !batman_if->packet_buff)
+		return;
+
 	addr_to_string(batman_if->addr_str, batman_if->net_dev->dev_addr);
 
 	memcpy(((struct batman_packet *)(batman_if->packet_buff))->orig,
@@ -397,6 +400,7 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 	batman_if->net_dev = net_dev;
 	batman_if->soft_iface = NULL;
 	batman_if->if_status = IF_NOT_IN_USE;
+	batman_if->packet_buff = NULL;
 	INIT_LIST_HEAD(&batman_if->list);
 
 	check_known_mac_addr(batman_if->net_dev->dev_addr);
-- 
1.7.1

