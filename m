Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 28 Jun 2012 11:34:22 +0200
Message-Id: <1340876067-28333-14-git-send-email-ordex@autistici.org>
In-Reply-To: <1340876067-28333-1-git-send-email-ordex@autistici.org>
References: <1340876067-28333-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 13/18] batman-adv: Prefix icmp_socket defines
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/icmp_socket.c |    2 +-
 net/batman-adv/icmp_socket.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index b285c31..4f45ca7 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -282,7 +282,7 @@ int batadv_socket_setup(struct bat_priv *bat_priv)
 	if (!bat_priv->debug_dir)
 		goto err;
 
-	d = debugfs_create_file(ICMP_SOCKET, S_IFREG | S_IWUSR | S_IRUSR,
+	d = debugfs_create_file(BATADV_ICMP_SOCKET, S_IFREG | S_IWUSR | S_IRUSR,
 				bat_priv->debug_dir, bat_priv, &batadv_fops);
 	if (!d)
 		goto err;
diff --git a/net/batman-adv/icmp_socket.h b/net/batman-adv/icmp_socket.h
index a62ab80..f88f9f0 100644
--- a/net/batman-adv/icmp_socket.h
+++ b/net/batman-adv/icmp_socket.h
@@ -20,7 +20,7 @@
 #ifndef _NET_BATMAN_ADV_ICMP_SOCKET_H_
 #define _NET_BATMAN_ADV_ICMP_SOCKET_H_
 
-#define ICMP_SOCKET "socket"
+#define BATADV_ICMP_SOCKET "socket"
 
 void batadv_socket_init(void);
 int batadv_socket_setup(struct bat_priv *bat_priv);
-- 
1.7.9.4

