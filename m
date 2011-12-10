Return-Path: <pawlkt@gmail.com>
Message-ID: <4EE36653.4000504@gmail.com>
Date: Sat, 10 Dec 2011 15:01:55 +0100
From: Paul <pawlkt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030307000602030802000306"
Subject: [B.A.T.M.A.N.] bat_socket_read missing checks
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

This is a multi-part message in MIME format.
--------------030307000602030802000306
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Writing a icmp_packet_rr and then reading icmp_packet can lead to kernel
memory corruption, if __user *buf is just below TASK_SIZE.

-- 
Regards,
Paul



--------------030307000602030802000306
Content-Type: text/plain;
 name="patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="patch.txt"

diff --git a/icmp_socket.c b/icmp_socket.c
index 5bc8649..f6a6536 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -136,7 +136,9 @@ static ssize_t bat_socket_read(struct file *file, char __user *buf,
 
        spin_unlock_bh(&socket_client->lock);
 
-       error = __copy_to_user(buf, &socket_packet->icmp_packet,
+       //queue can contain packets larger than icmp_packet (like icmp_packet_rr),
+       //so we can't rely just on the access_ok above
+       error = copy_to_user(buf, &socket_packet->icmp_packet,
                               socket_packet->icmp_len);
 
        packet_len = socket_packet->icmp_len;

--------------030307000602030802000306--
