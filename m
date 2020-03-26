Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batman-adv: Fix spelling error in term buffer
Date: Thu, 26 Mar 2020 18:37:07 +0100
Message-Id: <20200326173707.9644-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

checkpatch warns about a typo in the word bufFer which was introduced in
commit 2191c1bcbc64 ("batman-adv: kernel doc for types.h").

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 6854cb2b..d8f754d1 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -711,7 +711,7 @@ struct batadv_priv_bla {
 
 /**
  * struct batadv_priv_debug_log - debug logging data
- * @log_buff: buffer holding the logs (ring bufer)
+ * @log_buff: buffer holding the logs (ring buffer)
  * @log_start: index of next character to read
  * @log_end: index of next character to write
  * @lock: lock protecting log_buff, log_start & log_end
-- 
2.20.1

