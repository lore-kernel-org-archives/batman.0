Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri, 14 Aug 2015 17:23:50 +0200
Message-Id: <1439565830-9776-3-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1439565830-9776-1-git-send-email-linus.luessing@c0d3.blue>
References: <1439565830-9776-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint 3/3] batman-adv: Remove unnecessary
 braces for test_bit() in MCAST
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

Help! Help! \o/ I'm trapped in this commit message!!! :(

Fixes: 1798ad3f ("batman-adv: Fix broken MCAST capability check")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/multicast.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 8bdd69f..4541f08 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -740,7 +740,7 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 	 * is a completely new orig_node no need to decrease the counter.
 	 */
 	if (orig_mcast_enabled &&
-	    !(test_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities))) {
+	    !test_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities)) {
 		if (orig_initialized)
 			atomic_dec(&bat_priv->mcast.num_disabled);
 		set_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities);
@@ -798,7 +798,7 @@ void batadv_mcast_purge_orig(struct batadv_orig_node *orig)
 
 	spin_lock_bh(&orig->mcast_handler_lock);
 
-	if (!(test_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities)) &&
+	if (!test_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities) &&
 	    test_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capa_initialized))
 		atomic_dec(&bat_priv->mcast.num_disabled);
 
-- 
1.7.10.4

