Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 21 Jan 2014 11:22:05 +0100
Message-Id: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix soft-interface MTU
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@meshcoding.com>

The current MTU computation always returns a value
smaller than 1500bytes even if the real interfaces
have an MTU large enough to compensate the batman-adv
overhead.

Fix the computation by properly returning the highest
admitted value.

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---

This patch is missing a Reported-by clause because I did not have
"russell"'s email address at hand.

Will be added later before being merged.

Cheers,


 hard-interface.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index 6792e03..0eb0b3b 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -244,7 +244,7 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	const struct batadv_hard_iface *hard_iface;
-	int min_mtu = ETH_DATA_LEN;
+	int min_mtu = INT_MAX;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
@@ -259,8 +259,6 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
 	}
 	rcu_read_unlock();
 
-	atomic_set(&bat_priv->packet_size_max, min_mtu);
-
 	if (atomic_read(&bat_priv->fragmentation) == 0)
 		goto out;
 
@@ -271,13 +269,21 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
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

