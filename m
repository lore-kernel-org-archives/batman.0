Return-Path: <apape@phoenixcontact.com>
From: Andreas Pape <apape@phoenixcontact.com>
In-Reply-To: <1462525107-19750-1-git-send-email-apape@phoenixcontact.com>
References: <1462525107-19750-1-git-send-email-apape@phoenixcontact.com>
Message-ID: <1462525107-19750-2-git-send-email-apape@phoenixcontact.com>
Date: Fri, 6 May 2016 10:58:22 +0200
content-transfer-encoding: quoted-printable
content-type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] [PATCHv3 1/6] batman-adv: prevent multiple ARP
	replies sent by gateways if dat enbled
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

If dat is enabled it must be made sure that only the backbone gw which has
claimed the remote destination for the ARP request answers the ARP request
directly if the MAC address is known due to the local dat table. This
prevents multiple ARP replies in a common backbone if more than one
gateway already knows the remote mac searched for in the ARP request.

Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
---
 net/batman-adv/bridge_loop_avoidance.c |   49 ++++++++++++++++++++++++++++=
++++
 net/batman-adv/bridge_loop_avoidance.h |   11 +++++++
 net/batman-adv/distributed-arp-table.c |   15 ++++++++++
 3 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge=
_loop_avoidance.c
index 748a9ea..2f46ce9 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -2045,3 +2045,52 @@ out:
 =09=09batadv_hardif_put(primary_if);
 =09return 0;
 }
+
+#ifdef CONFIG_BATMAN_ADV_DAT
+/**
+ * batadv_bla_handle_local_claim - check if address is claimed
+ *
+ * @bat_priv: the bat priv with all the soft interface information
+ * @addr: mac address of which the claim status is checked
+ * @vid: the VLAN ID
+ *
+ * addr is checked if this address is claimed by the local device itself.
+ *
+ * Return: true if bla is disabled or the mac is claimed by the device,
+ * false if the device addr is already claimed by another gateway
+ */
+bool batadv_bla_handle_local_claim(struct batadv_priv *bat_priv,
+=09=09=09=09   u8 *addr, unsigned short vid)
+{
+=09struct batadv_bla_claim search_claim;
+=09struct batadv_bla_claim *claim =3D NULL;
+=09struct batadv_hard_iface *primary_if =3D NULL;
+=09bool ret =3D true;
+
+=09if (!atomic_read(&bat_priv->bridge_loop_avoidance))
+=09=09return ret;
+
+=09primary_if =3D batadv_primary_if_get_selected(bat_priv);
+=09if (!primary_if)
+=09=09return ret;
+
+=09/* First look if the mac address is claimed */
+=09ether_addr_copy(search_claim.addr, addr);
+=09search_claim.vid =3D vid;
+
+=09claim =3D batadv_claim_hash_find(bat_priv, &search_claim);
+
+=09/* If there is a claim and we are not owner of the claim,
+=09 * return false.
+=09 */
+=09if (claim) {
+=09=09if (!batadv_compare_eth(claim->backbone_gw->orig,
+=09=09=09=09=09primary_if->net_dev->dev_addr))
+=09=09=09ret =3D false;
+=09=09batadv_claim_put(claim);
+=09}
+
+=09batadv_hardif_put(primary_if);
+=09return ret;
+}
+#endif
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge=
_loop_avoidance.h
index 0f01dae..cc07be9 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -47,6 +47,10 @@ void batadv_bla_update_orig_address(struct batadv_priv *=
bat_priv,
 void batadv_bla_status_update(struct net_device *net_dev);
 int batadv_bla_init(struct batadv_priv *bat_priv);
 void batadv_bla_free(struct batadv_priv *bat_priv);
+#ifdef CONFIG_BATMAN_ADV_DAT
+bool batadv_bla_handle_local_claim(struct batadv_priv *bat_priv, u8 *addr,
+=09=09=09=09   unsigned short vid);
+#endif

 #define BATADV_BLA_CRC_INIT=090
 #else /* ifdef CONFIG_BATMAN_ADV_BLA */
@@ -112,6 +116,13 @@ static inline void batadv_bla_free(struct batadv_priv =
*bat_priv)
 {
 }

+static inline
+bool batadv_bla_handle_local_claim(struct batadv_priv *bat_priv, u8 *addr,
+=09=09=09=09   unsigned short vid)
+{
+=09return true;
+}
+
 #endif /* ifdef CONFIG_BATMAN_ADV_BLA */

 #endif /* ifndef _NET_BATMAN_ADV_BLA_H_ */
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distri=
buted-arp-table.c
index 278800a..c11f035 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -48,6 +48,7 @@
 #include "originator.h"
 #include "send.h"
 #include "translation-table.h"
+#include "bridge_loop_avoidance.h"

 static void batadv_dat_purge(struct work_struct *work);

@@ -1003,6 +1004,20 @@ bool batadv_dat_snoop_outgoing_arp_request(struct ba=
tadv_priv *bat_priv,
 =09=09=09goto out;
 =09=09}

+=09=09/* If BLA is enabled, only send ARP replies if we have claimed
+=09=09 * the destination for the ARP request or if no one else of
+=09=09 * the backbone gws belonging to our backbone has claimed the
+=09=09 * destination.
+=09=09 */
+=09=09if (!batadv_bla_handle_local_claim(bat_priv,
+=09=09=09=09=09=09   dat_entry->mac_addr, vid)) {
+=09=09=09batadv_dbg(BATADV_DBG_DAT, bat_priv,
+=09=09=09=09   "Device %pM claimed by another backbone gw. Don't send ARP =
reply!",
+=09=09=09=09   dat_entry->mac_addr);
+=09=09=09ret =3D true;
+=09=09=09goto out;
+=09=09}
+
 =09=09skb_new =3D arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
 =09=09=09=09     bat_priv->soft_iface, ip_dst, hw_src,
 =09=09=09=09     dat_entry->mac_addr, hw_src);
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
