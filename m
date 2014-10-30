Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Thu, 30 Oct 2014 05:40:46 +0100
Message-Id: <1414644048-5792-2-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1414644048-5792-1-git-send-email-linus.luessing@c0d3.blue>
References: <1414644048-5792-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: fix counter for multicast
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
To: b.a.t.m.a.n@lists.open-mesh.org

A miscounting of nodes having multicast optimizations enabled can lead
to multicast packet loss in the following scenario:

If the first OGM a node receives from another one has no multicast
optimizations support (no multicast tvlv) then we are missing to
increase the counter. This potentially leads to the wrong assumption
that we could safely use multicast optimizations.

Fixings this by increasing the counter if the initial OGM has the
multicast TVLV unset, too.

Introduced by 77ec494490d60d89b42cd01d5dbf8dee04503623
("batman-adv: Announce new capability via multicast TVLV")

Reported-by: Tobias Hachmer <tobias@hachmer.de>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 multicast.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/multicast.c b/multicast.c
index 96b66fd..02c2e0c 100644
--- a/multicast.c
+++ b/multicast.c
@@ -686,11 +686,13 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
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
1.7.10.4

