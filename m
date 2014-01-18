Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sat, 18 Jan 2014 19:31:57 +0100
Message-Id: <1390069917-5411-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1390069917-5411-1-git-send-email-linus.luessing@web.de>
References: <1390069917-5411-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv4 2/2] batman-adv: remove obsolete
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
To: b.a.t.m.a.n@lists.open-mesh.org

Our .ndo_start_xmit handler (batadv_interface_tx()) can rely on having
the skb ether header pointer set correctly since the following commit
present in kernels >= 3.9:

"net: reset mac header in dev_start_xmit()" (6d1ccff627)

Therefore this commit removes the according, now redundant,
skb_reset_mac_header() call in batadv_bla_tx().

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 bridge_loop_avoidance.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 5c0eda4..26ec489 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1535,9 +1535,6 @@ int batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
 		goto allow;
 
-	/* in VLAN case, the mac header might not be set. */
-	skb_reset_mac_header(skb);
-
 	if (batadv_bla_process_claim(bat_priv, primary_if, skb))
 		goto handled;
 
-- 
1.7.10.4

