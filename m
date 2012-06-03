Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Jun 2012 22:19:12 +0200
Message-Id: <1338754762-28424-6-git-send-email-sven@narfation.org>
In-Reply-To: <1338754762-28424-1-git-send-email-sven@narfation.org>
References: <1338754762-28424-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 06/16] batman-adv: Prefix icmp_socket defines
	with BATADV_
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

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 icmp_socket.c |    2 +-
 icmp_socket.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/icmp_socket.c b/icmp_socket.c
index 8960ee6..1f6df39 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -282,7 +282,7 @@ int batadv_socket_setup(struct bat_priv *bat_priv)
 	if (!bat_priv->debug_dir)
 		goto err;
 
-	d = debugfs_create_file(ICMP_SOCKET, S_IFREG | S_IWUSR | S_IRUSR,
+	d = debugfs_create_file(BATADV_ICMP_SOCKET, S_IFREG | S_IWUSR | S_IRUSR,
 				bat_priv->debug_dir, bat_priv, &batadv_fops);
 	if (d)
 		goto err;
diff --git a/icmp_socket.h b/icmp_socket.h
index a62ab80..f88f9f0 100644
--- a/icmp_socket.h
+++ b/icmp_socket.h
@@ -20,7 +20,7 @@
 #ifndef _NET_BATMAN_ADV_ICMP_SOCKET_H_
 #define _NET_BATMAN_ADV_ICMP_SOCKET_H_
 
-#define ICMP_SOCKET "socket"
+#define BATADV_ICMP_SOCKET "socket"
 
 void batadv_socket_init(void);
 int batadv_socket_setup(struct bat_priv *bat_priv);
-- 
1.7.10

