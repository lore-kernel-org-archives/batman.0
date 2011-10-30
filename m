Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 30 Oct 2011 16:40:46 +0100
Message-Id: <1319989246-3670-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1850275.SO2QzbpOTm@sven-laptop.home.narfation.org>
References: <1850275.SO2QzbpOTm@sven-laptop.home.narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: explain the weird TTL for ICMP
	packets
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

A comment may clear this up ...

Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 icmp_socket.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/icmp_socket.c b/icmp_socket.c
index ac3520e..7b832d2 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -216,6 +216,8 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	icmp_packet->uid = socket_client->index;
 
 	if (icmp_packet->version != COMPAT_VERSION) {
+		/* report the kernel modules COMPAT_VERSION through the ttl
+		 * field if it differs from the version in the copied packet. */
 		icmp_packet->msg_type = PARAMETER_PROBLEM;
 		icmp_packet->ttl = COMPAT_VERSION;
 		bat_socket_add_packet(socket_client, icmp_packet, packet_len);
-- 
1.7.7.1

