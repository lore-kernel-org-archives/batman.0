Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 26 Jun 2016 11:16:09 +0200
Message-Id: <1466932573-23105-1-git-send-email-sven@narfation.org>
In-Reply-To: <10049349.EHEiaYmtBd@sven-edge>
References: <10049349.EHEiaYmtBd@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH net 1/5] batman-adv: replace WARN with rate
	limited output on non-existing VLAN
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

From: Simon Wunderlich <sw@simonwunderlich.de>

If a VLAN tagged frame is received and the corresponding VLAN is not
configured on the soft interface, it will splat a WARN on every packet
received. This is a quite annoying behaviour for some scenarios, e.g. if
bat0 is bridged with eth0, and there are arbitrary VLAN tagged frames
from Ethernet coming in without having any VLAN configuration on bat0.

The code should probably create vlan objects on the fly and
transparently transport these VLAN-tagged Ethernet frames, but until
this is done, at least the WARN splat should be replaced by a rate
limited output.

Fixes: 354136bcc3c4 ("batman-adv: fix kernel crash due to missing NULL checks")
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index feaf492b..72abab7 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -650,8 +650,10 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 
 	/* increase the refcounter of the related vlan */
 	vlan = batadv_softif_vlan_get(bat_priv, vid);
-	if (WARN(!vlan, "adding TT local entry %pM to non-existent VLAN %d",
-		 addr, BATADV_PRINT_VID(vid))) {
+	if (!vlan) {
+		net_ratelimited_function(batadv_info, soft_iface,
+					 "adding TT local entry %pM to non-existent VLAN %d\n",
+					 addr, BATADV_PRINT_VID(vid));
 		kfree(tt_local);
 		tt_local = NULL;
 		goto out;
-- 
2.8.1

