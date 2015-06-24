Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 24 Jun 2015 14:50:20 +0200
Message-Id: <1435150220-25157-2-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1435150220-25157-1-git-send-email-sw@simonwunderlich.de>
References: <1435150220-25157-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: remove broadcast
	packets scheduled for purged outgoing if
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

When an interface is purged, the broadcast packets scheduled for this
interface should get purged as well.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 send.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/send.c b/send.c
index 23635bd..a7e84b2 100644
--- a/send.c
+++ b/send.c
@@ -598,7 +598,8 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 		 * we delete only packets belonging to the given interface
 		 */
 		if ((hard_iface) &&
-		    (forw_packet->if_incoming != hard_iface))
+		    (forw_packet->if_incoming != hard_iface) &&
+		    (forw_packet->if_outgoing != hard_iface))
 			continue;
 
 		spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
-- 
2.1.4

