Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue,  6 Jan 2015 12:10:03 +0100
Message-Id: <1420542605-28865-5-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1420542605-28865-1-git-send-email-antonio@meshcoding.com>
References: <1420542605-28865-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 4/6] batman-adv: fix counter for multicast
	supporting nodes
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

A miscounting of nodes having multicast optimizations enabled can lead
to multicast packet loss in the following scenario:

If the first OGM a node receives from another one has no multicast
optimizations support (no multicast tvlv) then we are missing to
increase the counter. This potentially leads to the wrong assumption
that we could safely use multicast optimizations.

Fixings this by increasing the counter if the initial OGM has the
multicast TVLV unset, too.

Introduced by 60432d756cf06e597ef9da511402dd059b112447
("batman-adv: Announce new capability via multicast TVLV")

Reported-by: Tobias Hachmer <tobias@hachmer.de>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/multicast.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index ab6bb2a..d3503fb 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -685,11 +685,13 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 		if (orig_initialized)
 			atomic_dec(&bat_priv->mcast.num_disabled);
 		orig->capabilities |= BATADV_ORIG_CAPA_HAS_MCAST;
-	/* If mcast support is being switched off increase the disabled
-	 * mcast node counter.
+	/* If mcast support is being switched off or if this is an initial
+	 * OGM without mcast support then increase the disabled mcast
+	 * node counter.
 	 */
 	} else if (!orig_mcast_enabled &&
-		   orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST) {
+		   (orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST ||
+		    !orig_initialized)) {
 		atomic_inc(&bat_priv->mcast.num_disabled);
 		orig->capabilities &= ~BATADV_ORIG_CAPA_HAS_MCAST;
 	}
-- 
2.2.1

