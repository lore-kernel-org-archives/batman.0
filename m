Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 19 May 2010 21:12:37 +0200
Message-Id: <1274296357-17903-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1274295600-16987-1-git-send-email-sven.eckelmann@gmx.de>
References: <1274295600-16987-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: Don't allocate icmp packet
	with GFP_KERNEL
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
This patch is created for maint and should be applied using `git am`.
Following patches should be applied before:
 * batman-adv: Move device for icmp injection to debugfs
 * batman-adv: Move tables from sysfs to debugfs
 * batman-adv: Call unregister_netdev on failures to get rtnl lock
 * batman-adv: Don't call free_netdev twice

 icmp_socket.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/icmp_socket.c b/icmp_socket.c
index eba8aa2..d74e2d6 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -284,7 +284,7 @@ static void bat_socket_add_packet(struct socket_client *socket_client,
 	struct socket_packet *socket_packet;
 	unsigned long flags;
 
-	socket_packet = kmalloc(sizeof(struct socket_packet), GFP_KERNEL);
+	socket_packet = kmalloc(sizeof(struct socket_packet), GFP_ATOMIC);
 
 	if (!socket_packet)
 		return;
-- 
1.7.1

