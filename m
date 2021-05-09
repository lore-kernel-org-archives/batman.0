Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [net-next v2 05/11] net: bridge: mcast: prepare is-router function for mcast router split
Date: Sun,  9 May 2021 21:45:03 +0200
Message-Id: <20210509194509.10849-6-linus.luessing@c0d3.blue>
In-Reply-To: <20210509194509.10849-1-linus.luessing@c0d3.blue>
References: <20210509194509.10849-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: netdev@vger.kernel.org
Cc: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, bridge@lists.linux-foundation.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org

In preparation for the upcoming split of multicast router state into
their IPv4 and IPv6 variants make br_multicast_is_router() protocol
family aware.

Note that for now br_ip6_multicast_is_router() uses the currently still
common ip4_mc_router_timer for now. It will be renamed to
ip6_mc_router_timer later when the split is performed.

While at it also renames the "1" and "2" constants in
br_multicast_is_router() to the MDB_RTR_TYPE_TEMP_QUERY and
MDB_RTR_TYPE_PERM enums.

Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_input.c     |  2 +-
 net/bridge/br_multicast.c |  5 +++--
 net/bridge/br_private.h   | 36 ++++++++++++++++++++++++++++++++----
 3 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 8875e95..1f50630 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -132,7 +132,7 @@ int br_handle_frame_finish(struct net *net, struct so=
ck *sk, struct sk_buff *skb
 		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
 		    br_multicast_querier_exists(br, eth_hdr(skb), mdst)) {
 			if ((mdst && mdst->host_joined) ||
-			    br_multicast_is_router(br)) {
+			    br_multicast_is_router(br, skb)) {
 				local_rcv =3D true;
 				br->dev->stats.multicast++;
 			}
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 7edbbc9..048b5b9 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1391,7 +1391,8 @@ static void br_multicast_local_router_expired(struc=
t timer_list *t)
 	spin_lock(&br->multicast_lock);
 	if (br->multicast_router =3D=3D MDB_RTR_TYPE_DISABLED ||
 	    br->multicast_router =3D=3D MDB_RTR_TYPE_PERM ||
-	    timer_pending(&br->ip4_mc_router_timer))
+	    br_ip4_multicast_is_router(br) ||
+	    br_ip6_multicast_is_router(br))
 		goto out;
=20
 	br_mc_router_state_change(br, false);
@@ -3622,7 +3623,7 @@ bool br_multicast_router(const struct net_device *d=
ev)
 	bool is_router;
=20
 	spin_lock_bh(&br->multicast_lock);
-	is_router =3D br_multicast_is_router(br);
+	is_router =3D br_multicast_is_router(br, NULL);
 	spin_unlock_bh(&br->multicast_lock);
 	return is_router;
 }
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 26e91d2..ac5ca5b 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -864,11 +864,39 @@ static inline bool br_group_is_l2(const struct br_i=
p *group)
 #define mlock_dereference(X, br) \
 	rcu_dereference_protected(X, lockdep_is_held(&br->multicast_lock))
=20
-static inline bool br_multicast_is_router(struct net_bridge *br)
+static inline bool br_ip4_multicast_is_router(struct net_bridge *br)
 {
-	return br->multicast_router =3D=3D 2 ||
-	       (br->multicast_router =3D=3D 1 &&
-		timer_pending(&br->ip4_mc_router_timer));
+	return timer_pending(&br->ip4_mc_router_timer);
+}
+
+static inline bool br_ip6_multicast_is_router(struct net_bridge *br)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	return timer_pending(&br->ip4_mc_router_timer);
+#else
+	return false;
+#endif
+}
+
+static inline bool
+br_multicast_is_router(struct net_bridge *br, struct sk_buff *skb)
+{
+	if (br->multicast_router =3D=3D MDB_RTR_TYPE_PERM)
+		return true;
+
+	if (br->multicast_router =3D=3D MDB_RTR_TYPE_TEMP_QUERY) {
+		if (skb) {
+			if (skb->protocol =3D=3D htons(ETH_P_IP))
+				return br_ip4_multicast_is_router(br);
+			else if (skb->protocol =3D=3D htons(ETH_P_IPV6))
+				return br_ip6_multicast_is_router(br);
+		} else {
+			return br_ip4_multicast_is_router(br) ||
+			       br_ip6_multicast_is_router(br);
+		}
+	}
+
+	return false;
 }
=20
 static inline bool
--=20
2.31.0
