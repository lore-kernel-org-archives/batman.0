Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 19 May 2010 21:00:00 +0200
Message-Id: <1274295600-16987-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Don't allocate icmp packet with
	GFP_KERNEL
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

A new buffer for a packet is created when a icmp packet is received.
This happens in a context with disabled irq. Thus we are not allowed to
sleep or call function which might sleep. kmalloc must be called with
GFP_ATOMIC instead of GFP_KERNEL to ensure that it does not sleep.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/icmp_socket.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batman-adv-kernelland/icmp_socket.c b/batman-adv-kernelland/icmp_socket.c
index 33d2714..becbb5b 100644
--- a/batman-adv-kernelland/icmp_socket.c
+++ b/batman-adv-kernelland/icmp_socket.c
@@ -292,7 +292,7 @@ static void bat_socket_add_packet(struct socket_client *socket_client,
 	struct socket_packet *socket_packet;
 	unsigned long flags;
 
-	socket_packet = kmalloc(sizeof(struct socket_packet), GFP_KERNEL);
+	socket_packet = kmalloc(sizeof(struct socket_packet), GFP_ATOMIC);
 
 	if (!socket_packet)
 		return;
-- 
1.7.1

