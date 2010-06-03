Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu,  3 Jun 2010 13:33:27 +0200
Message-Id: <1275564807-8725-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <20100603100437.GS5483@bicker>
References: <20100603100437.GS5483@bicker>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: return -EFAULT on copy_to_user
	errors
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
To: b.a.t.m.a.n@open-mesh.net
Cc: Dan Carpenter <error27@gmail.com>

From: Dan Carpenter <error27@gmail.com>

copy_to_user() returns the number of bites remaining but we want to
return a negative error code here.

Signed-off-by: Dan Carpenter <error27@gmail.com>
[sven.eckelmann@gmx.de: Move change from device.c to icmp_socket.c]
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 This patch is already applied in maint and must be applied in master.

 batman-adv-kernelland/icmp_socket.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batman-adv-kernelland/icmp_socket.c b/batman-adv-kernelland/icmp_socket.c
index bad87fd..08cca22 100644
--- a/batman-adv-kernelland/icmp_socket.c
+++ b/batman-adv-kernelland/icmp_socket.c
@@ -148,7 +148,7 @@ static ssize_t bat_socket_read(struct file *file, char __user *buf,
 	kfree(socket_packet);
 
 	if (error)
-		return error;
+		return -EFAULT;
 
 	return packet_len;
 }
-- 
1.7.1

