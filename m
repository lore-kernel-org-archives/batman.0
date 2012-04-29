Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 29 Apr 2012 10:57:35 +0200
Message-Id: <1335689867-8017-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1335689867-8017-1-git-send-email-ordex@autistici.org>
References: <1335689867-8017-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 03/15] batman-adv: add
	biggest_unsigned_int(x) macro
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

in case of dynamic type variable, it could be needed to compute at compile time
its maximal value. This macro helps in doing that for unsigned integer types

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/main.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index a2b18d0..d9ef4ca 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -221,6 +221,9 @@ static inline bool has_timed_out(unsigned long timestamp, unsigned int timeout)
 /* Returns the smallest signed integer in two's complement with the sizeof x */
 #define smallest_signed_int(x) (1u << (7u + 8u * (sizeof(x) - 1u)))
 
+/* Returns the biggest unsigned integer with the sizeof x */
+#define biggest_unsigned_int(x) (~(x)0)
+
 /* Checks if a sequence number x is a predecessor/successor of y.
  * they handle overflows/underflows and can correctly check for a
  * predecessor/successor unless the variable sequence number has grown by
-- 
1.7.9.4

