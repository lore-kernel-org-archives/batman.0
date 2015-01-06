Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue,  6 Jan 2015 12:10:04 +0100
Message-Id: <1420542605-28865-6-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1420542605-28865-1-git-send-email-antonio@meshcoding.com>
References: <1420542605-28865-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 5/6] batman-adv: fix multicast counter when
	purging originators
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@meshcoding.com>, Marek Lindner <mareklindner@neomailbox.ch>

From: Linus Lüssing <linus.luessing@c0d3.blue>

When purging an orig_node we should only decrease counter tracking the
number of nodes without multicast optimizations support if it was
increased through this orig_node before.

A not yet quite initialized orig_node (meaning it did not have its turn
in the mcast-tvlv handler so far) which gets purged would not adhere to
this and will lead to a counter imbalance.

Fixing this by adding a check whether the orig_node is mcast-initalized
before decreasing the counter in the mcast-orig_node-purging routine.

Introduced by 60432d756cf06e597ef9da511402dd059b112447
("batman-adv: Announce new capability via multicast TVLV")

Reported-by: Tobias Hachmer <tobias@hachmer.de>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/multicast.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index d3503fb..b24e4bb 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -740,7 +740,8 @@ void batadv_mcast_purge_orig(struct batadv_orig_node *orig)
 {
 	struct batadv_priv *bat_priv = orig->bat_priv;
 
-	if (!(orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST))
+	if (!(orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST) &&
+	    orig->capa_initialized & BATADV_ORIG_CAPA_HAS_MCAST)
 		atomic_dec(&bat_priv->mcast.num_disabled);
 
 	batadv_mcast_want_unsnoop_update(bat_priv, orig, BATADV_NO_FLAGS);
-- 
2.2.1

