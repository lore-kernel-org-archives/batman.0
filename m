Return-Path: <apape@phoenixcontact.com>
From: Andreas Pape <apape@phoenixcontact.com>
Message-ID: <1456492719-29748-1-git-send-email-apape@phoenixcontact.com>
Date: Fri, 26 Feb 2016 14:18:39 +0100
content-transfer-encoding: quoted-printable
content-type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] [PATCHv2 3/7] batman-adv: prevent duplication of ARP
	replies when DAT is used
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

If none of the backbone gateways in a bla setup has already knowledge of
the mac address searched for in an incoming ARP request from the backbone
it must be prevented that multiple ARP replies are generated and returned
to the backbone by the dat address resolution mechanism of other dat
enabled nodes of the mesh.

Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
---
 net/batman-adv/distributed-arp-table.c |   65 ++++++++++++++++++++++++++++=
+++-
 1 files changed, 64 insertions(+), 1 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distri=
buted-arp-table.c
index 0f899b9..f60fccb 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1081,6 +1081,8 @@ bool batadv_dat_snoop_incoming_arp_request(struct bat=
adv_priv *bat_priv,
 =09u8 *hw_src;
 =09struct sk_buff *skb_new;
 =09struct batadv_dat_entry *dat_entry =3D NULL;
+=09struct batadv_unicast_4addr_packet *unicast_4addr_packet;
+=09struct batadv_orig_node *orig_node =3D NULL;
 =09bool ret =3D false;
 =09unsigned short vid;
 =09int err;
@@ -1104,8 +1106,38 @@ bool batadv_dat_snoop_incoming_arp_request(struct ba=
tadv_priv *bat_priv,
 =09batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);

 =09dat_entry =3D batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
-=09if (!dat_entry)
+=09if (!dat_entry) {
+=09=09/* Check if this is a 4addr unicast DAT_DHT_GET frame from
+=09=09 * another backbone gw of the same backbone. If yes, drop
+=09=09 * it as this leads to multiplication of arp requests in bla
+=09=09 * setups as long as there is no dat_entry fo this answer.
+=09=09 * In this case better drop the DHT_GET. Normal bla code
+=09=09 * doesn't take care of these packets as they are tunneled
+=09=09 * via unicast.
+=09=09 */
+=09=09unicast_4addr_packet =3D
+=09=09=09=09(struct batadv_unicast_4addr_packet *)skb->data;
+=09=09orig_node =3D
+=09=09=09batadv_orig_hash_find(bat_priv,
+=09=09=09=09=09      unicast_4addr_packet->src);
+=09=09if (orig_node) {
+=09=09=09if ((unicast_4addr_packet->u.packet_type =3D=3D
+=09=09=09     BATADV_UNICAST_4ADDR) &&
+=09=09=09     (unicast_4addr_packet->subtype =3D=3D
+=09=09=09      BATADV_P_DAT_DHT_GET) &&
+=09=09=09     (batadv_bla_is_backbone_gw(skb, orig_node,
+=09=09=09=09=09=09=09hdr_size))) {
+=09=09=09=09batadv_dbg(BATADV_DBG_DAT, bat_priv, "Doubled ARP request remo=
ved: ARP MSG =3D [src: %pM-%pI4 dst: %pM-%pI4]; originator: %pM\n",
+=09=09=09=09=09   hw_src, &ip_src,
+=09=09=09=09=09   batadv_arp_hw_dst(skb, hdr_size),
+=09=09=09=09=09   &ip_dst, unicast_4addr_packet->src);
+=09=09=09=09ret =3D true;
+=09=09=09}
+=09=09=09batadv_orig_node_put(orig_node);
+=09=09}
+
 =09=09goto out;
+=09}

 =09skb_new =3D arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
 =09=09=09     bat_priv->soft_iface, ip_dst, hw_src,
@@ -1204,6 +1236,7 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batad=
v_priv *bat_priv,
 =09__be32 ip_src, ip_dst;
 =09u8 *hw_src, *hw_dst;
 =09bool dropped =3D false;
+=09struct batadv_dat_entry *dat_entry =3D NULL;
 =09unsigned short vid;

 =09if (!atomic_read(&bat_priv->distributed_arp_table))
@@ -1223,12 +1256,40 @@ bool batadv_dat_snoop_incoming_arp_reply(struct bat=
adv_priv *bat_priv,
 =09hw_dst =3D batadv_arp_hw_dst(skb, hdr_size);
 =09ip_dst =3D batadv_arp_ip_dst(skb, hdr_size);

+=09/* If ip_dst is already in cache and has the right mac address,
+=09 * drop this frame if this ARP reply is destined for us. We have
+=09 * most probably received already a reply from someone else. Delivering
+=09 * this frame would lead to doubled receive of an ARP reply.
+=09 */
+=09dat_entry =3D batadv_dat_entry_hash_find(bat_priv, ip_src, vid);
+=09if ((dat_entry) && (batadv_compare_eth(hw_src, dat_entry->mac_addr))) {
+=09=09batadv_dbg(BATADV_DBG_DAT, bat_priv, "Doubled ARP reply removed: ARP=
 MSG =3D [src: %pM-%pI4 dst: %pM-%pI4]; dat_entry: %pM-%pI4\n",
+=09=09=09   hw_src, &ip_src, hw_dst, &ip_dst,
+=09=09=09   dat_entry->mac_addr,=09&dat_entry->ip);
+=09=09dropped =3D true;
+=09=09goto out;
+=09}
+
 =09/* Update our internal cache with both the IP addresses the node got
 =09 * within the ARP reply
 =09 */
 =09batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
 =09batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);

+=09/* If BLA is enabled, only forward ARP replies if we have claimed the
+=09 * source of the ARP reply or if no one else of the same backbone has
+=09 * already claimed that client. This prevents that different gateways
+=09 * to the same backbone all forward the ARP reply leading to multiple
+=09 * replies in the backbone.
+=09 */
+=09if (!batadv_bla_handle_local_claim(bat_priv, hw_src, vid)) {
+=09=09batadv_dbg(BATADV_DBG_DAT, bat_priv,
+=09=09=09   "Device %pM claimed by another backbone gw. Drop ARP reply.\n",
+=09=09=09   hw_src);
+=09=09dropped =3D true;
+=09=09goto out;
+=09}
+
 =09/* if this REPLY is directed to a client of mine, let's deliver the
 =09 * packet to the interface
 =09 */
@@ -1241,6 +1302,8 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batad=
v_priv *bat_priv,
 out:
 =09if (dropped)
 =09=09kfree_skb(skb);
+=09if (dat_entry)
+=09=09batadv_dat_entry_put(dat_entry);
 =09/* if dropped =3D=3D false -> deliver to the interface */
 =09return dropped;
 }
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
