Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 10 Dec 2011 15:28:34 +0100
Message-Id: <1323527316-15071-1-git-send-email-sven@narfation.org>
In-Reply-To: <4EE36653.4000504@gmail.com>
References: <4EE36653.4000504@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCHv2 1/3] batman-adv: bat_socket_read missing
	checks
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
Cc: Paul Kot <pawlkt@gmail.com>

From: Paul Kot <pawlkt@gmail.com>

Writing a icmp_packet_rr and then reading icmp_packet can lead to kernel
memory corruption, if __user *buf is just below TASK_SIZE.

Signed-off-by: Paul Kot <pawlkt@gmail.com>
[sven@narfation.org: made it checkpatch clean]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 icmp_socket.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/icmp_socket.c b/icmp_socket.c
index 5bc8649..a53502a 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -136,8 +136,8 @@ static ssize_t bat_socket_read(struct file *file, char __user *buf,
 
 	spin_unlock_bh(&socket_client->lock);
 
-	error = __copy_to_user(buf, &socket_packet->icmp_packet,
-			       socket_packet->icmp_len);
+	error = copy_to_user(buf, &socket_packet->icmp_packet,
+			     socket_packet->icmp_len);
 
 	packet_len = socket_packet->icmp_len;
 	kfree(socket_packet);
-- 
1.7.7.3

