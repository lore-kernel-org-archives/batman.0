Return-Path: <APape@phoenixcontact.com>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF514CE6A6.70ACFF1A-ONC1257F57.004BE44C-C1257F57.004C213B@phoenixcontact.com>
Date: Fri, 12 Feb 2016 14:51:32 +0100
content-transfer-encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: Prevent mutliple ARP replies
 sent by gateways in bla setups with dat enabled
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

From=202b90abdf53e9ab09d9acfd141c7225de1ae16719 Mon Sep 17 00:00:00 2001
From: Andreas Pape <apape@phoenixcontact.com>
Date: Fri, 12 Feb 2016 10:05:57 +0100
Subject: [PATCH 1/4] batman-adv: Prevent mutliple ARP replies sent by
gateways in bla setups with dat enabled

This patch shall make sure that only the backbone gw which has claimed the
remote
destination for the ARP request answers the ARP request directly if the
MAC address
is known due to the local DAT table. This prevents multiple ARP replies in
a common
backbone if more than one gateway already knows the remote mac searched
for in the
ARP request.

Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
---
 net/batman-adv/bridge_loop_avoidance.c |   58
++++++++++++++++++++++++++++++++
 net/batman-adv/bridge_loop_avoidance.h |    6 +++
 net/batman-adv/distributed-arp-table.c |   14 ++++++++
 3 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c
b/net/batman-adv/bridge_loop_avoidance.c
index 0a6c8b8..c70363d 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1906,3 +1906,61 @@ out:
                batadv_hardif_put(primary_if);
        return 0;
 }
+
+/**
+ * batadv_check_local_claim
+ * @bat_priv: the bat priv with all the soft interface information
+ * @addr: mac address of which the claim status is checked
+ * @vid: the VLAN ID
+ *
+ * batadv_check_local_claim:
+ * addr is checked if this address is claimed by the local device itself.
+ * If the address is not claimed at all, claim it.
+ * returns true if bla is disabled or the mac is claimed by the device
+ * returns false if the device addr is already claimed by another gateway
+ */
+bool batadv_bla_check_local_claim(struct batadv_priv *bat_priv, uint8_t
*addr, unsigned short vid)
+{
+       struct batadv_bla_claim search_claim;
+       struct batadv_bla_claim *claim =3D NULL;
+       struct batadv_hard_iface *primary_if =3D NULL;
+       bool ret =3D true;
+
+       if (atomic_read(&bat_priv->bridge_loop_avoidance)) {
+
+               primary_if =3D batadv_primary_if_get_selected(bat_priv);
+               if (!primary_if)
+                       return ret;
+
+               /* First look if the mac address is claimed */
+               ether_addr_copy(search_claim.addr, addr);
+               search_claim.vid =3D vid;
+
+               claim =3D batadv_claim_hash_find(bat_priv,
+                                 &search_claim);
+
+               /* If there is a claim and we are not owner of the claim,
+                * return false;
+                */
+               if (claim) {
+                       if (!batadv_compare_eth(claim->backbone_gw->orig,
primary_if->net_dev->dev_addr)) {
+                               ret =3D false;
+                       }
+               } else {
+                       /* If there is no claim, claim the device */
+                       batadv_dbg(BATADV_DBG_BLA, bat_priv, "No claim
found for %pM. Claim mac for us.\n",
+                                       search_claim.addr);
+
+                       batadv_handle_claim(bat_priv,
+                                                      primary_if,
+ primary_if->net_dev->dev_addr, addr,
+                                                      vid);
+               }
+       }
+
+       if (claim)
+               batadv_claim_put(claim);
+       if (primary_if)
+               batadv_hardif_put(primary_if);
+       return ret;
+}
diff --git a/net/batman-adv/bridge_loop_avoidance.h
b/net/batman-adv/bridge_loop_avoidance.h
index 579f0fa..84c31bc 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -46,6 +46,7 @@ void batadv_bla_update_orig_address(struct batadv_priv
*bat_priv,
 void batadv_bla_status_update(struct net_device *net_dev);
 int batadv_bla_init(struct batadv_priv *bat_priv);
 void batadv_bla_free(struct batadv_priv *bat_priv);
+bool batadv_bla_check_local_claim(struct batadv_priv *bat_priv, u8 *addr,
unsigned short vid);

 #define BATADV_BLA_CRC_INIT    0
 #else /* ifdef CONFIG_BATMAN_ADV_BLA */
@@ -111,6 +112,11 @@ static inline void batadv_bla_free(struct batadv_priv
*bat_priv)
 {
 }

+bool batadv_bla_check_local_claim(struct batadv_priv *bat_priv, u8 *addr,
unsigned short vid)
+{
+       return true;
+}
+
 #endif /* ifdef CONFIG_BATMAN_ADV_BLA */

 #endif /* ifndef _NET_BATMAN_ADV_BLA_H_ */
diff --git a/net/batman-adv/distributed-arp-table.c
b/net/batman-adv/distributed-arp-table.c
index e96d7c7..93893bf 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -48,6 +48,7 @@
 #include "originator.h"
 #include "send.h"
 #include "translation-table.h"
+#include "bridge_loop_avoidance.h"

 static void batadv_dat_purge(struct work_struct *work);

@@ -1000,6 +1001,19 @@ bool batadv_dat_snoop_outgoing_arp_request(struct
batadv_priv *bat_priv,
                        goto out;
                }

+               /* If BLA is enabled, only send ARP REPLYs if we have
claimed
+                * the destination for the ARP REQUEST or if no one else
of
+                * the backbone gws belonging to our backbone has claimed
the
+                * destination.
+                */
+               if (!batadv_bla_check_local_claim(bat_priv,
dat_entry->mac_addr, vid)) {
+                       batadv_dbg(BATADV_DBG_DAT, bat_priv, "Device %pM
claimed by another "
+                                       "backbone gw. Don't send ARP reply
into common backbone !",
+                                       dat_entry->mac_addr);
+                       ret =3D true;
+                       goto out;
+               }
+
                skb_new =3D arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
                                     bat_priv->soft_iface, ip_dst, hw_src,
                                     dat_entry->mac_addr, hw_src);
--
1.7.0.4






..................................................................
PHOENIX CONTACT ELECTRONICS GmbH

Sitz der Gesellschaft / registered office of the company: 31812 Bad Pyrmont
USt-Id-Nr.: DE811742156
Amtsgericht Hannover HRB 100528 / district court Hannover HRB 100528
Gesch=C3=A4ftsf=C3=BChrer / Executive Board: Roland Bent, Dr. Martin Heubeck
___________________________________________________________________
Diese E-Mail enth=C3=A4lt vertrauliche und/oder rechtlich gesch=C3=BCtzte I=
nformationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail i=
rrt=C3=BCmlich erhalten haben, informieren Sie bitte sofort den Absender un=
d vernichten Sie diese Mail. Das unerlaubte Kopieren, jegliche anderweitige=
 Verwendung sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
---------------------------------------------------------------------------=
-------------------------
This e-mail may contain confidential and/or privileged information. If you =
are not the intended recipient (or have received this e-mail in error) plea=
se notify the sender immediately and destroy this e-mail. Any unauthorized =
copying, disclosure, distribution or other use of the material or parts the=
reof is strictly forbidden.
___________________________________________________________________
