Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu,  8 Jan 2015 16:15:11 +0100
Message-Id: <1420730120-9844-7-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1420730120-9844-1-git-send-email-antonio@meshcoding.com>
References: <1420730120-9844-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 06/15] batman-adv: kernel doc fixes for
	main.{c, h}
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
Cc: netdev@vger.kernel.org, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Martin Hundebøll <martin@hundeboll.net>

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/main.c | 4 ++--
 net/batman-adv/main.h | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index d1183e8..2cdd25a 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -651,7 +651,7 @@ static struct batadv_tvlv_handler
 /**
  * batadv_tvlv_container_free_ref - decrement the tvlv container refcounter and
  *  possibly free it
- * @tvlv_handler: the tvlv container to free
+ * @tvlv: the tvlv container to free
  */
 static void batadv_tvlv_container_free_ref(struct batadv_tvlv_container *tvlv)
 {
@@ -800,7 +800,7 @@ void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
  *  requested packet size
  * @packet_buff: packet buffer
  * @packet_buff_len: packet buffer size
- * @packet_min_len: requested packet minimum size
+ * @min_packet_len: requested packet minimum size
  * @additional_packet_len: requested additional packet size on top of minimum
  *  size
  *
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index a1fcd88..2a59b04 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -92,9 +92,8 @@
 /* numbers of originator to contact for any PUT/GET DHT operation */
 #define BATADV_DAT_CANDIDATES_NUM 3
 
-/**
- * BATADV_TQ_SIMILARITY_THRESHOLD - TQ points that a secondary metric can differ
- *  at most from the primary one in order to be still considered acceptable
+/* BATADV_TQ_SIMILARITY_THRESHOLD - TQ points that a secondary metric can differ
+ * at most from the primary one in order to be still considered acceptable
  */
 #define BATADV_TQ_SIMILARITY_THRESHOLD 50
 
-- 
2.2.1

