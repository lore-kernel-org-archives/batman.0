Date: Fri, 18 Jul 2008 13:18:28 +0200
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20080718111828.GA30595@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] Don't process the icmp packet further when
	we could not read it
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

__copy_from_user returns the number of bytes it could not read when it
fails. It makes no sense to process the data further if we don't have it
in a complete form.
access_ok will only check if it may be valid but not if it is definitly valid.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/batman-core/device.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/batman-adv-kernelland/batman-core/device.c b/batman-adv-kernelland/batman-core/device.c
index 6608f13..c401634 100644
--- a/batman-adv-kernelland/batman-core/device.c
+++ b/batman-adv-kernelland/batman-core/device.c
@@ -229,7 +229,9 @@ ssize_t bat_device_write(struct file *file, const char __user *buff, size_t len,
 	if (!access_ok(VERIFY_READ, buff, sizeof(struct icmp_packet)))
 		return -EFAULT;
 
-	__copy_from_user(&icmp_packet, buff, sizeof(icmp_packet));
+	if (__copy_from_user(&icmp_packet, buff, sizeof(icmp_packet))) {
+		return -EFAULT;
+	}
 
 	if ((icmp_packet.packet_type == BAT_ICMP) && (icmp_packet.msg_type == ECHO_REQUEST)) {
 
-- 
1.5.6.3


