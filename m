Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 22 Mar 2014 09:56:03 +0100
Message-Id: <1395478576-10999-4-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1395478576-10999-1-git-send-email-antonio@meshcoding.com>
References: <1395478576-10999-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 03/16] batman-adv: remove obsolete
	skb_reset_mac_header() in batadv_bla_tx()
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Linus Lüssing <linus.luessing@web.de>

Our .ndo_start_xmit handler (batadv_interface_tx()) can rely on having
the skb mac header pointer set correctly since the following commit
present in kernels >= 3.9:

"net: reset mac header in dev_start_xmit()" (6d1ccff627)

Therefore this commit removes the according, now redundant,
skb_reset_mac_header() call in batadv_bla_tx().

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/bridge_loop_avoidance.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 73d8372..70d781a 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1547,9 +1547,6 @@ int batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
 		goto allow;
 
-	/* in VLAN case, the mac header might not be set. */
-	skb_reset_mac_header(skb);
-
 	if (batadv_bla_process_claim(bat_priv, primary_if, skb))
 		goto handled;
 
-- 
1.8.3.2

