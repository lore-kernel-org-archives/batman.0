Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 23 Nov 2011 11:35:44 +0100
Message-Id: <1322044544-15153-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: add biggest_unsigned_int(x) macro
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

in case of dynamic type variable, it could be needed to compute at compile time
its maximal value. This macro helps in doing that for unsigned integer types

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 main.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/main.h b/main.h
index 464439f..3c58235 100644
--- a/main.h
+++ b/main.h
@@ -210,6 +210,9 @@ static inline int compare_eth(const void *data1, const void *data2)
 /* Returns the smallest signed integer in two's complement with the sizeof x */
 #define smallest_signed_int(x) (1u << (7u + 8u * (sizeof(x) - 1u)))
 
+/* Returns the biggest unsigned integer with the sizeof x */
+#define biggest_unsigned_int(x) (~(x)0)
+
 /* Checks if a sequence number x is a predecessor/successor of y.
  * they handle overflows/underflows and can correctly check for a
  * predecessor/successor unless the variable sequence number has grown by
-- 
1.7.3.4

