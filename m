Return-Path: <apape@phoenixcontact.com>
From: Andreas Pape <apape@phoenixcontact.com>
In-Reply-To: <1467613514-32536-1-git-send-email-apape@phoenixcontact.com>
References: <1467613514-32536-1-git-send-email-apape@phoenixcontact.com>
Message-ID: <1467613514-32536-4-git-send-email-apape@phoenixcontact.com>
Date: Mon, 4 Jul 2016 08:25:12 +0200
content-transfer-encoding: quoted-printable
content-type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] [PATCH v6 3/5] batman-adv: drop unicast packets from
	other backbone gw
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

Additional dropping of unicast packets received from another backbone gw of
the same backbone network before being forwarded to the same backbone again
is necessary. It was observed in a test setup that in rare cases these
frames lead to looping unicast traffic backbone->mesh->backbone.

Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
Acked-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/routing.c |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 2bc9645..1511abe 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -877,14 +877,16 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 =09struct batadv_priv *bat_priv =3D netdev_priv(recv_if->soft_iface);
 =09struct batadv_unicast_packet *unicast_packet;
 =09struct batadv_unicast_4addr_packet *unicast_4addr_packet;
-=09u8 *orig_addr;
-=09struct batadv_orig_node *orig_node =3D NULL;
+=09u8 *orig_addr, *orig_addr_gw;
+=09struct batadv_orig_node *orig_node =3D NULL, *orig_node_gw =3D NULL;
 =09int check, hdr_size =3D sizeof(*unicast_packet);
 =09enum batadv_subtype subtype;
-=09bool is4addr;
+=09bool is4addr, is_gw;
+=09struct ethhdr *ethhdr;

 =09unicast_packet =3D (struct batadv_unicast_packet *)skb->data;
 =09unicast_4addr_packet =3D (struct batadv_unicast_4addr_packet *)skb->dat=
a;
+=09ethhdr =3D eth_hdr(skb);

 =09is4addr =3D unicast_packet->packet_type =3D=3D BATADV_UNICAST_4ADDR;
 =09/* the caller function should have already pulled 2 bytes */
@@ -907,6 +909,23 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,

 =09/* packet for me */
 =09if (batadv_is_my_mac(bat_priv, unicast_packet->dest)) {
+=09=09/* If this is a unicast packet from another backgone gw,
+=09=09 * drop it.
+=09=09 */
+=09=09orig_addr_gw =3D ethhdr->h_source;
+=09=09orig_node_gw =3D batadv_orig_hash_find(bat_priv, orig_addr_gw);
+=09=09if (orig_node_gw) {
+=09=09=09is_gw =3D batadv_bla_is_backbone_gw(skb, orig_node_gw,
+=09=09=09=09=09=09=09  hdr_size);
+=09=09=09batadv_orig_node_put(orig_node_gw);
+=09=09=09if (is_gw) {
+=09=09=09=09batadv_dbg(BATADV_DBG_BLA, bat_priv,
+=09=09=09=09=09   "Dropped unicast pkt received from another backbone gw %=
pM.\n",
+=09=09=09=09=09   orig_addr_gw);
+=09=09=09=09return NET_RX_DROP;
+=09=09=09}
+=09=09}
+
 =09=09if (is4addr) {
 =09=09=09subtype =3D unicast_4addr_packet->subtype;
 =09=09=09batadv_dat_inc_counter(bat_priv, subtype);
--
1.7.0.4



..................................................................
PHOENIX CONTACT ELECTRONICS GmbH

Sitz der Gesellschaft / registered office of the company: 31812 Bad Pyrmont
USt-Id-Nr.: DE811742156
Amtsgericht Hannover HRB 100528 / district court Hannover HRB 100528
Gesch=C3=A4ftsf=C3=BChrer / Executive Board: Ulrich Leidecker, Christoph Le=
ifer
__________________________________________________________________
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
