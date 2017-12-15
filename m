Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 15 Dec 2017 12:43:19 +0100
Message-Id: <20171215114320.13645-20-sw@simonwunderlich.de>
In-Reply-To: <20171215114320.13645-1-sw@simonwunderlich.de>
References: <20171215114320.13645-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 19/20] batman-adv: Add kernel-doc to
 functions in headers
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

Externally visible functions should be documented with kernel-doc. This
usually refers to non-static functions but also static inline files in
headers are visible in other files and should therefore be documented.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bitarray.h       |  7 +++-
 net/batman-adv/hard-interface.h |  6 +++
 net/batman-adv/hash.h           | 11 +++++-
 net/batman-adv/log.h            | 35 +++++++++++++++++-
 net/batman-adv/main.h           | 82 ++++++++++++++++++++++++++++++++++-------
 net/batman-adv/originator.h     |  9 ++++-
 6 files changed, 131 insertions(+), 19 deletions(-)

diff --git a/net/batman-adv/bitarray.h b/net/batman-adv/bitarray.h
index 25c2cca948e3..611a609da80b 100644
--- a/net/batman-adv/bitarray.h
+++ b/net/batman-adv/bitarray.h
@@ -49,7 +49,12 @@ static inline bool batadv_test_bit(const unsigned long *seq_bits,
 	return test_bit(diff, seq_bits) != 0;
 }
 
-/* turn corresponding bit on, so we can remember that we got the packet */
+/**
+ * batadv_set_bit() - Turn corresponding bit on, so we can remember that we got
+ *  the packet
+ * @seq_bits: bitmap of the packet receive window
+ * @n: relative sequence number of newly received packet
+ */
 static inline void batadv_set_bit(unsigned long *seq_bits, s32 n)
 {
 	/* if too old, just drop it */
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index f29974b487cc..52cdc7efbf97 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -132,6 +132,12 @@ static inline void batadv_hardif_put(struct batadv_hard_iface *hard_iface)
 	kref_put(&hard_iface->refcount, batadv_hardif_release);
 }
 
+/**
+ * batadv_primary_if_get_selected() - Get reference to primary interface
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: primary interface (with increased refcnt), otherwise NULL
+ */
 static inline struct batadv_hard_iface *
 batadv_primary_if_get_selected(struct batadv_priv *bat_priv)
 {
diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index 239f394512b9..29a2842c4ed8 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -123,8 +123,15 @@ static inline int batadv_hash_add(struct batadv_hashtable *hash,
 	return ret;
 }
 
-/* removes data from hash, if found. data could be the structure you use with
- * just the key filled, we just need the key for comparing.
+/**
+ * batadv_hash_remove() - Removes data from hash, if found
+ * @hash: hash table
+ * @compare: callback to determine if 2 hash elements are identical
+ * @choose: callback calculating the hash index
+ * @data: data passed to the aforementioned callbacks as argument
+ *
+ * ata could be the structure you use with  just the key filled, we just need
+ * the key for comparing.
  *
  * Return: returns pointer do data on success, so you can remove the used
  * structure yourself, or NULL on error
diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index 67e25121a4de..09d457e385fe 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -81,7 +81,14 @@ enum batadv_dbg_level {
 int batadv_debug_log(struct batadv_priv *bat_priv, const char *fmt, ...)
 __printf(2, 3);
 
-/* possibly ratelimited debug output */
+/**
+ * _batadv_dbg() - Store debug output with(out) ratelimiting
+ * @type: type of debug message
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ratelimited: whether output should be rate limited
+ * @fmt: format string
+ * @arg...: variable arguments
+ */
 #define _batadv_dbg(type, bat_priv, ratelimited, fmt, arg...)		\
 	do {								\
 		struct batadv_priv *__batpriv = (bat_priv);		\
@@ -100,11 +107,30 @@ static inline void _batadv_dbg(int type __always_unused,
 }
 #endif
 
+/**
+ * batadv_dbg() - Store debug output without ratelimiting
+ * @type: type of debug message
+ * @bat_priv: the bat priv with all the soft interface information
+ * @arg...: format string and variable arguments
+ */
 #define batadv_dbg(type, bat_priv, arg...) \
 	_batadv_dbg(type, bat_priv, 0, ## arg)
+
+/**
+ * batadv_dbg_ratelimited() - Store debug output with ratelimiting
+ * @type: type of debug message
+ * @bat_priv: the bat priv with all the soft interface information
+ * @arg...: format string and variable arguments
+ */
 #define batadv_dbg_ratelimited(type, bat_priv, arg...) \
 	_batadv_dbg(type, bat_priv, 1, ## arg)
 
+/**
+ * batadv_info() - Store message in debug buffer and print it to kmsg buffer
+ * @net_dev: the soft interface net device
+ * @fmt: format string
+ * @arg...: variable arguments
+ */
 #define batadv_info(net_dev, fmt, arg...)				\
 	do {								\
 		struct net_device *_netdev = (net_dev);                 \
@@ -112,6 +138,13 @@ static inline void _batadv_dbg(int type __always_unused,
 		batadv_dbg(BATADV_DBG_ALL, _batpriv, fmt, ## arg);	\
 		pr_info("%s: " fmt, _netdev->name, ## arg);		\
 	} while (0)
+
+/**
+ * batadv_err() - Store error in debug buffer and print it to kmsg buffer
+ * @net_dev: the soft interface net device
+ * @fmt: format string
+ * @arg...: variable arguments
+ */
 #define batadv_err(net_dev, fmt, arg...)				\
 	do {								\
 		struct net_device *_netdev = (net_dev);                 \
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 53f386bedd3b..69c2ab666961 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -300,40 +300,96 @@ static inline bool batadv_has_timed_out(unsigned long timestamp,
 	return time_is_before_jiffies(timestamp + msecs_to_jiffies(timeout));
 }
 
+/**
+ * batadv_atomic_dec_not_zero() - Decrease unless the number is 0
+ * @v: pointer of type atomic_t
+ *
+ * Return: non-zero if v was not 0, and zero otherwise.
+ */
 #define batadv_atomic_dec_not_zero(v)	atomic_add_unless((v), -1, 0)
 
-/* Returns the smallest signed integer in two's complement with the sizeof x */
+/**
+ * batadv_smallest_signed_int() - Returns the smallest signed integer in two's
+ *  complement with the sizeof x
+ * @x: type of integer
+ *
+ * Return: smallest signed integer of type
+ */
 #define batadv_smallest_signed_int(x) (1u << (7u + 8u * (sizeof(x) - 1u)))
 
-/* Checks if a sequence number x is a predecessor/successor of y.
- * they handle overflows/underflows and can correctly check for a
- * predecessor/successor unless the variable sequence number has grown by
- * more then 2**(bitwidth(x)-1)-1.
+/**
+ * batadv_seq_before() - Checks if a sequence number x is a predecessor of y
+ * @x: potential predecessor of @y
+ * @y: value to compare @x against
+ *
+ * It handles overflows/underflows and can correctly check for a predecessor
+ * unless the variable sequence number has grown by more then
+ * 2**(bitwidth(x)-1)-1.
+ *
  * This means that for a u8 with the maximum value 255, it would think:
- *  - when adding nothing - it is neither a predecessor nor a successor
- *  - before adding more than 127 to the starting value - it is a predecessor,
- *  - when adding 128 - it is neither a predecessor nor a successor,
- *  - after adding more than 127 to the starting value - it is a successor
+ *
+ * * when adding nothing - it is neither a predecessor nor a successor
+ * * before adding more than 127 to the starting value - it is a predecessor,
+ * * when adding 128 - it is neither a predecessor nor a successor,
+ * * after adding more than 127 to the starting value - it is a successor
+ *
+ * Return: true when x is a predecessor of y, false otherwise
  */
 #define batadv_seq_before(x, y) ({typeof(x)_d1 = (x); \
 				 typeof(y)_d2 = (y); \
 				 typeof(x)_dummy = (_d1 - _d2); \
 				 (void)(&_d1 == &_d2); \
 				 _dummy > batadv_smallest_signed_int(_dummy); })
+
+/**
+ * batadv_seq_after() - Checks if a sequence number x is a successor of y
+ * @x: potential sucessor of @y
+ * @y: value to compare @x against
+ *
+ * It handles overflows/underflows and can correctly check for a successor
+ * unless the variable sequence number has grown by more then
+ * 2**(bitwidth(x)-1)-1.
+ *
+ * This means that for a u8 with the maximum value 255, it would think:
+ *
+ * * when adding nothing - it is neither a predecessor nor a successor
+ * * before adding more than 127 to the starting value - it is a predecessor,
+ * * when adding 128 - it is neither a predecessor nor a successor,
+ * * after adding more than 127 to the starting value - it is a successor
+ *
+ * Return: true when x is a successor of y, false otherwise
+ */
 #define batadv_seq_after(x, y) batadv_seq_before(y, x)
 
-/* Stop preemption on local cpu while incrementing the counter */
+/**
+ * batadv_add_counter() - Add to per cpu statistics counter of soft interface
+ * @bat_priv: the bat priv with all the soft interface information
+ * @idx: counter index which should be modified
+ * @count: value to increase counter by
+ *
+ * Stop preemption on local cpu while incrementing the counter
+ */
 static inline void batadv_add_counter(struct batadv_priv *bat_priv, size_t idx,
 				      size_t count)
 {
 	this_cpu_add(bat_priv->bat_counters[idx], count);
 }
 
+/**
+ * batadv_inc_counter() - Increase per cpu statistics counter of soft interface
+ * @b: the bat priv with all the soft interface information
+ * @i: counter index which should be modified
+ */
 #define batadv_inc_counter(b, i) batadv_add_counter(b, i, 1)
 
-/* Define a macro to reach the control buffer of the skb. The members of the
- * control buffer are defined in struct batadv_skb_cb in types.h.
- * The macro is inspired by the similar macro TCP_SKB_CB() in tcp.h.
+/**
+ * BATADV_SKB_CB() - Get batadv_skb_cb from skb control buffer
+ * @__skb: skb holding the control buffer
+ *
+ * The members of the control buffer are defined in struct batadv_skb_cb in
+ * types.h. The macro is inspired by the similar macro TCP_SKB_CB() in tcp.h.
+ *
+ * Return: pointer to the batadv_skb_cb of the skb
  */
 #define BATADV_SKB_CB(__skb)       ((struct batadv_skb_cb *)&((__skb)->cb[0]))
 
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 0e0a12e600af..08e4bcf454c6 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -86,8 +86,13 @@ batadv_orig_node_vlan_get(struct batadv_orig_node *orig_node,
 			  unsigned short vid);
 void batadv_orig_node_vlan_put(struct batadv_orig_node_vlan *orig_vlan);
 
-/* hashfunction to choose an entry in a hash table of given size
- * hash algorithm from http://en.wikipedia.org/wiki/Hash_table
+/**
+ * batadv_choose_orig() - Return the index of the orig entry in the hash table
+ * @data: mac address of the originator node
+ * @size: the size of the hash table
+ *
+ * Return: the hash index where the object represented by @data should be
+ * stored at.
  */
 static inline u32 batadv_choose_orig(const void *data, u32 size)
 {
-- 
2.11.0

