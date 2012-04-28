Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 28 Apr 2012 21:31:13 +0200
Message-Id: <1335641473-32316-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: remove biggest_unsigned_int()
	macro
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

As suggested by David S. Miller, this macro is not very useful. So we can remove
it and use its expanded version instead.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---


This patch should be committed into next because it has to be sent to David S.
Miller within the next pull request.

Thank you

 distributed-arp-table.h |    2 +-
 main.h                  |    3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 5e23577..6c0acde 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -29,7 +29,7 @@
 
 #include <linux/if_arp.h>
 
-#define DAT_ADDR_MAX biggest_unsigned_int(dat_addr_t)
+#define DAT_ADDR_MAX ((dat_addr_t)~(dat_addr_t)0)
 
 #define ARP_HW_SRC(skb, hdr_size) ((uint8_t *)(skb->data + hdr_size) + \
 				   ETH_HLEN + sizeof(struct arphdr))
diff --git a/main.h b/main.h
index 97d0258..426a0d5 100644
--- a/main.h
+++ b/main.h
@@ -241,9 +241,6 @@ static inline bool has_timed_out(unsigned long timestamp, unsigned int timeout)
 /* Returns the smallest signed integer in two's complement with the sizeof x */
 #define smallest_signed_int(x) (1u << (7u + 8u * (sizeof(x) - 1u)))
 
-/* Returns the biggest unsigned integer with the sizeof x */
-#define biggest_unsigned_int(x) (~(x)0)
-
 /* Checks if a sequence number x is a predecessor/successor of y.
  * they handle overflows/underflows and can correctly check for a
  * predecessor/successor unless the variable sequence number has grown by
-- 
1.7.9.4

