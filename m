Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 2/5] batman-adv: Fix spelling error in term buffer
Date: Mon, 27 Apr 2020 17:06:04 +0200
Message-Id: <20200427150607.31401-3-sw@simonwunderlich.de>
In-Reply-To: <20200427150607.31401-1-sw@simonwunderlich.de>
References: <20200427150607.31401-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

checkpatch warns about a typo in the word bufFer which was introduced in
commit 2191c1bcbc64 ("batman-adv: kernel doc for types.h").

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 4a17a66cc572..d152b8e81f61 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1086,7 +1086,7 @@ struct batadv_priv_bla {
  * struct batadv_priv_debug_log - debug logging data
  */
 struct batadv_priv_debug_log {
-	/** @log_buff: buffer holding the logs (ring bufer) */
+	/** @log_buff: buffer holding the logs (ring buffer) */
 	char log_buff[BATADV_LOG_BUF_LEN];
 
 	/** @log_start: index of next character to read */
-- 
2.20.1

