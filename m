Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 10 Dec 2011 16:36:01 +0100
Message-Id: <1323531361-16575-1-git-send-email-sven@narfation.org>
In-Reply-To: <1323527316-15071-1-git-send-email-sven@narfation.org>
References: <1323527316-15071-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 1/2] batman-adv: Only write requested
	number of byte to user buffer
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

Don't write more than the requested number of bytes of an batman-adv icmp
packet to the userspace buffer. Otherwise unrelated userspace memory might get
overwritten by the kernel.

Reported-by: Paul Kot <pawlkt@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Marek pointed out that it is better to merge patch 1 and 2. I think it doesn't
make sense to leave Paul Kot as author because it doesn't look like his patch
at all.

And thanks to Andrew for s/overridden/overwritten/

 icmp_socket.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/icmp_socket.c b/icmp_socket.c
index 5bc8649..66923d2 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -136,10 +136,9 @@ static ssize_t bat_socket_read(struct file *file, char __user *buf,
 
 	spin_unlock_bh(&socket_client->lock);
 
-	error = __copy_to_user(buf, &socket_packet->icmp_packet,
-			       socket_packet->icmp_len);
+	packet_len = min(count, socket_packet->icmp_len);
+	error = copy_to_user(buf, &socket_packet->icmp_packet, packet_len);
 
-	packet_len = socket_packet->icmp_len;
 	kfree(socket_packet);
 
 	if (error)
-- 
1.7.7.3

