Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 14 Sep 2012 12:40:54 +0200
Message-Id: <1347619254-22862-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH net] batman-adv: make batadv_test_bit()
	return 0 or 1 only
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Linus Lüssing <linus.luessing@web.de>

On some architectures test_bit() can return other values than 0 or 1:

With a generic x86 OpenWrt image in a kvm setup (batadv_)test_bit()
frequently returns -1 for me, leading to batadv_iv_ogm_update_seqnos()
wrongly signaling a protected seqno window.

This patch tries to fix this issue by making batadv_test_bit() return 0
or 1 only.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Acked-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bitarray.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/bitarray.h b/net/batman-adv/bitarray.h
index a081ce1..cebaae7 100644
--- a/net/batman-adv/bitarray.h
+++ b/net/batman-adv/bitarray.h
@@ -20,8 +20,8 @@
 #ifndef _NET_BATMAN_ADV_BITARRAY_H_
 #define _NET_BATMAN_ADV_BITARRAY_H_
 
-/* returns true if the corresponding bit in the given seq_bits indicates true
- * and curr_seqno is within range of last_seqno
+/* Returns 1 if the corresponding bit in the given seq_bits indicates true
+ * and curr_seqno is within range of last_seqno. Otherwise returns 0.
  */
 static inline int batadv_test_bit(const unsigned long *seq_bits,
 				  uint32_t last_seqno, uint32_t curr_seqno)
@@ -32,7 +32,7 @@ static inline int batadv_test_bit(const unsigned long *seq_bits,
 	if (diff < 0 || diff >= BATADV_TQ_LOCAL_WINDOW_SIZE)
 		return 0;
 	else
-		return  test_bit(diff, seq_bits);
+		return test_bit(diff, seq_bits) != 0;
 }
 
 /* turn corresponding bit on, so we can remember that we got the packet */
-- 
1.7.12

