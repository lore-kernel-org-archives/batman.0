Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 12 May 2016 18:41:23 +0200
Message-Id: <1463071283-20210-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: replace WARN with rate
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
To: b.a.t.m.a.n@lists.open-mesh.org

If a VLAN tagged frame is received and the corresponding VLAN is not
configured on the soft interface, it will splat a WARN on every packet
received. This is a quite annoying behaviour for some scenarios, e.g. if
bat0 is bridged with eth0, and there are arbitrary VLAN tagged frames
from Ethernet coming in without having any VLAN configuration on bat0.

The code should probably create vlan objects on the fly and
transparently transport these VLAN-tagged Ethernet frames, but until
this is done, at least the WARN splat should be replaced by a rate
limited output.

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 9b4551a..0236f80 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -650,8 +650,10 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 
 	/* increase the refcounter of the related vlan */
 	vlan = batadv_softif_vlan_get(bat_priv, vid);
-	if (WARN(!vlan, "adding TT local entry %pM to non-existent VLAN %d",
-		 addr, BATADV_PRINT_VID(vid))) {
+	if (!vlan) {
+		net_ratelimited_function(batadv_info, soft_iface,
+					 "adding TT local entry %pM to non-existent VLAN %d",
+					 addr, BATADV_PRINT_VID(vid));
 		kfree(tt_local);
 		tt_local = NULL;
 		goto out;
-- 
2.8.1

