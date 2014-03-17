Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 17 Mar 2014 14:22:45 +0100
Message-Id: <1395062574-28291-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1395062574-28291-1-git-send-email-antonio@meshcoding.com>
References: <1395062574-28291-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH next 02/11] batman-adv: don't mess up with
	the netdev refcounting if not needed
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

Looking for an interface and increasing its refcounter only
to check if it really exists is not really useful and makes
the code look more complex without a real gain.

Change batadv_mcast_has_bridge() accordingly and avoid to
use the pointer to the interface outside of the
rcu_read_lock/unlock context.

Introduced by e368857f66620b8483166e8e6556d9c87f9b3e71
("batman-adv: Multicast Listener Announcements via Translation Table")

Cc: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 multicast.c | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/multicast.c b/multicast.c
index d92de1e..af3fe49 100644
--- a/multicast.c
+++ b/multicast.c
@@ -156,16 +156,16 @@ static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_mcast_get_bridge - get the bridge interface on our soft interface
+ * batadv_mcast_has_bridge - check whether the soft-iface is bridged
  * @bat_priv: the bat priv with all the soft interface information
  *
- * Return the next bridge interface on top of our soft interface and increase
- * its refcount. If no such bridge interface exists, then return NULL.
+ * Check whether there is a bridge on top of our soft interface. Return
+ * true if so, false otherwise.
  */
-static struct net_device *
-batadv_mcast_get_bridge(struct batadv_priv *bat_priv)
+static bool batadv_mcast_has_bridge(struct batadv_priv *bat_priv)
 {
 	struct net_device *upper = bat_priv->soft_iface;
+	bool has_bridge = false;
 
 	rcu_read_lock();
 
@@ -174,30 +174,11 @@ batadv_mcast_get_bridge(struct batadv_priv *bat_priv)
 	} while (upper && !(upper->priv_flags & IFF_EBRIDGE));
 
 	if (upper)
-		dev_hold(upper);
+		has_bridge = true;
 
 	rcu_read_unlock();
 
-	return upper;
-}
-
-/**
- * batadv_mcast_has_bridge - check whether the soft-iface is bridged
- * @bat_priv: the bat priv with all the soft interface information
- *
- * Check whether there is a bridge on top of our soft interface. Return
- * true if so, false otherwise.
- */
-static bool batadv_mcast_has_bridge(struct batadv_priv *bat_priv)
-{
-	struct net_device *bridge;
-
-	bridge = batadv_mcast_get_bridge(bat_priv);
-	if (!bridge)
-		return false;
-
-	dev_put(bridge);
-	return true;
+	return has_bridge;
 }
 
 /**
-- 
1.8.3.2

