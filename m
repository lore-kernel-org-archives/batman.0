Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 17 Feb 2014 21:48:40 +0100
Message-Id: <1392670129-2498-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392670129-2498-1-git-send-email-antonio@meshcoding.com>
References: <1392670129-2498-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 01/10] batman-adv: fix soft-interface MTU
	computation
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

The current MTU computation always returns a value
smaller than 1500bytes even if the real interfaces
have an MTU large enough to compensate the batman-adv
overhead.

Fix the computation by properly returning the highest
admitted value.

Introduced by a19d3d85e1b854e4a483a55d740a42458085560d
("batman-adv: limit local translation table max size")

Reported-by: Russell Senior <russell@personaltelco.net>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/hard-interface.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 3d417d3..b851cc5 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -241,7 +241,7 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	const struct batadv_hard_iface *hard_iface;
-	int min_mtu = ETH_DATA_LEN;
+	int min_mtu = INT_MAX;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
@@ -256,8 +256,6 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
 	}
 	rcu_read_unlock();
 
-	atomic_set(&bat_priv->packet_size_max, min_mtu);
-
 	if (atomic_read(&bat_priv->fragmentation) == 0)
 		goto out;
 
@@ -268,13 +266,21 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
 	min_mtu = min_t(int, min_mtu, BATADV_FRAG_MAX_FRAG_SIZE);
 	min_mtu -= sizeof(struct batadv_frag_packet);
 	min_mtu *= BATADV_FRAG_MAX_FRAGMENTS;
-	atomic_set(&bat_priv->packet_size_max, min_mtu);
-
-	/* with fragmentation enabled we can fragment external packets easily */
-	min_mtu = min_t(int, min_mtu, ETH_DATA_LEN);
 
 out:
-	return min_mtu - batadv_max_header_len();
+	/* report to the other components the maximum amount of bytes that
+	 * batman-adv can send over the wire (without considering the payload
+	 * overhead). For example, this value is used by TT to compute the
+	 * maximum local table table size
+	 */
+	atomic_set(&bat_priv->packet_size_max, min_mtu);
+
+	/* the real soft-interface MTU is computed by removing the payload
+	 * overhead from the maximum amount of bytes that was just computed.
+	 *
+	 * However batman-adv does not support MTUs bigger than ETH_DATA_LEN
+	 */
+	return min_t(int, min_mtu - batadv_max_header_len(), ETH_DATA_LEN);
 }
 
 /* adjusts the MTU if a new interface with a smaller MTU appeared. */
-- 
1.8.5.3

