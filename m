Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Thu, 30 Oct 2014 05:40:47 +0100
Message-Id: <1414644048-5792-3-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1414644048-5792-1-git-send-email-linus.luessing@c0d3.blue>
References: <1414644048-5792-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: fix multicast counter when
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
To: b.a.t.m.a.n@lists.open-mesh.org

When purging an orig_node we should only decrease counter tracking the
number of nodes without multicast optimizations support if it was
increased through this orig_node before.

A not yet quite initialized orig_node (meaning it did not have its turn
in the mcast-tvlv handler so far) which gets purged would not adhere to
this and will lead to a counter imbalance.

Fixing this by adding a check whether the orig_node is mcast-initalized
before decreasing the counter in the mcast-orig_node-purging routine.

Introduced by 77ec494490d60d89b42cd01d5dbf8dee04503623
("batman-adv: Announce new capability via multicast TVLV")

Reported-by: Tobias Hachmer <tobias@hachmer.de>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 multicast.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/multicast.c b/multicast.c
index 02c2e0c..fe57bde 100644
--- a/multicast.c
+++ b/multicast.c
@@ -741,7 +741,8 @@ void batadv_mcast_purge_orig(struct batadv_orig_node *orig)
 {
 	struct batadv_priv *bat_priv = orig->bat_priv;
 
-	if (!(orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST))
+	if (!(orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST) &&
+	    orig->capa_initialized & BATADV_ORIG_CAPA_HAS_MCAST)
 		atomic_dec(&bat_priv->mcast.num_disabled);
 
 	batadv_mcast_want_unsnoop_update(bat_priv, orig, BATADV_NO_FLAGS);
-- 
1.7.10.4

