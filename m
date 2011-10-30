Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 30 Oct 2011 22:27:21 +0100
Message-Id: <1320010041-29605-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: report compat_version in version
	field in case of version mismatch
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 icmp_socket.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/icmp_socket.c b/icmp_socket.c
index ac3520e..defd692 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -217,7 +217,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 
 	if (icmp_packet->version != COMPAT_VERSION) {
 		icmp_packet->msg_type = PARAMETER_PROBLEM;
-		icmp_packet->ttl = COMPAT_VERSION;
+		icmp_packet->version = COMPAT_VERSION;
 		bat_socket_add_packet(socket_client, icmp_packet, packet_len);
 		goto free_skb;
 	}
-- 
1.7.5.4

