Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Aug 2015 18:35:47 +0200
Message-Id: <1439310948-32426-10-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1439310948-32426-1-git-send-email-antonio@meshcoding.com>
References: <1439310948-32426-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 09/10] batman-adv: remove broadcast packets
	scheduled for purged outgoing if
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
Cc: netdev@vger.kernel.org, Simon Wunderlich <simon@open-mesh.com>, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Simon Wunderlich <simon@open-mesh.com>

When an interface is purged, the broadcast packets scheduled for this
interface should get purged as well.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/send.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 0a01992..191076e 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -616,7 +616,8 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 		 * we delete only packets belonging to the given interface
 		 */
 		if ((hard_iface) &&
-		    (forw_packet->if_incoming != hard_iface))
+		    (forw_packet->if_incoming != hard_iface) &&
+		    (forw_packet->if_outgoing != hard_iface))
 			continue;
 
 		spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
-- 
2.5.0

