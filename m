Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 16 Jun 2015 14:44:34 +0200
Message-Id: <1434458675-3343-5-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1434458675-3343-1-git-send-email-linus.luessing@c0d3.blue>
References: <1434458675-3343-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 maint 4/5] batman-adv: Make MCAST
	capability changes atomic
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

Bitwise OR/AND assignments in C aren't guaranteed to be atomic. One
OGM handler might undo the set/clear of a specific bit from another
handler run in between.

Fix this by using the atomic set_bit()/clear_bit() functions.

Fixes: 77ec494490d6 ("batman-adv: Announce new capability via multicast TVLV")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 multicast.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/multicast.c b/multicast.c
index 09f2838..00612bf 100644
--- a/multicast.c
+++ b/multicast.c
@@ -684,7 +684,7 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 	    !(orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST)) {
 		if (orig_initialized)
 			atomic_dec(&bat_priv->mcast.num_disabled);
-		orig->capabilities |= BATADV_ORIG_CAPA_HAS_MCAST;
+		set_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities);
 	/* If mcast support is being switched off or if this is an initial
 	 * OGM without mcast support then increase the disabled mcast
 	 * node counter.
@@ -693,10 +693,10 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 		   (orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST ||
 		    !orig_initialized)) {
 		atomic_inc(&bat_priv->mcast.num_disabled);
-		orig->capabilities &= ~BATADV_ORIG_CAPA_HAS_MCAST;
+		clear_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities);
 	}
 
-	orig->capa_initialized |= BATADV_ORIG_CAPA_HAS_MCAST;
+	set_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capa_initialized);
 
 	if (orig_mcast_enabled && tvlv_value &&
 	    (tvlv_value_len >= sizeof(mcast_flags)))
-- 
1.7.10.4

