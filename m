Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 14 Jan 2013 09:41:08 +1000
Message-Id: <1358120480-25960-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1358120480-25960-1-git-send-email-ordex@autistici.org>
References: <1358120480-25960-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 03/15] batman-adv: reduce local TT entry
	timeout to 10 minutes
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

The current timeout is set to one hour. However a client connected to the mesh
network will always generate traffic. In the worst case it will send ARP
requests every 4 or 5 minutes. On the other hand having a long timeout means
storing dead entries for one hour and it leads to very big trans-tables
containing useless clients.

This patch reduces the timeout to 10 minutes

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index c4fe41f..d04b209 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -41,7 +41,7 @@
  * -> TODO: check influence on BATADV_TQ_LOCAL_WINDOW_SIZE
  */
 #define BATADV_PURGE_TIMEOUT 200000 /* 200 seconds */
-#define BATADV_TT_LOCAL_TIMEOUT 3600000 /* in milliseconds */
+#define BATADV_TT_LOCAL_TIMEOUT 600000 /* in milliseconds */
 #define BATADV_TT_CLIENT_ROAM_TIMEOUT 600000 /* in milliseconds */
 #define BATADV_TT_CLIENT_TEMP_TIMEOUT 600000 /* in milliseconds */
 #define BATADV_DAT_ENTRY_TIMEOUT (5*60000) /* 5 mins in milliseconds */
-- 
1.8.0.2

