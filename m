Return-Path: <APape@phoenixcontact.com>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OFB1894E97.63E32850-ONC1257F57.004C41B6-C1257F57.004C4F9E@phoenixcontact.com>
Date: Fri, 12 Feb 2016 14:53:31 +0100
content-transfer-encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: prevent duplication of ARP
 replies in BLA setups when DAT does address resolution
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

From=202cc1e9eb153d0c2d64cb0fb0747063ba63472925 Mon Sep 17 00:00:00 2001
From: Andreas Pape <apape@phoenixcontact.com>
Date: Fri, 12 Feb 2016 13:19:25 +0100
Subject: [PATCH 3/4] batman-adv: prevent duplication of ARP replies in BLA
setups when DAT does address resolution

This patch covers the case of a bla setup with enabled dat if none of the
common gateways of the
same backbone has already knowledge of the searched ip address and
therefore has to ask via DAT some
of the other mesh nodes. A broadcast arp request is coming
from=20the backbone and each backbone gateway starts an address resolution
via other DAT mesh nodes.
In this case it should be prevented, that multiple answers from DAT
enabled mesh nodes reach the
backbone gateways leading to multiple replies in a common backbone again.

Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
---
 net/batman-adv/distributed-arp-table.c |   56
+++++++++++++++++++++++++++++++-
 1 files changed, 55 insertions(+), 1 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c
b/net/batman-adv/distributed-arp-table.c
index 4e64e6c..22976fb 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1080,6 +1080,8 @@ bool batadv_dat_snoop_incoming_arp_request(struct
batadv_priv *bat_priv,
        u8 *hw_src;
        struct sk_buff *skb_new;
        struct batadv_dat_entry *dat_entry =3D NULL;
+       struct batadv_unicast_4addr_packet *unicast_4addr_packet;
+       struct batadv_orig_node *orig_node =3D NULL;
        bool ret =3D false;
        unsigned short vid;
        int err;
@@ -1103,8 +1105,31 @@ bool batadv_dat_snoop_incoming_arp_request(struct
batadv_priv *bat_priv,
        batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);

        dat_entry =3D batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
-       if (!dat_entry)
+       if (!dat_entry) {
+               /* Check if this is a 4addr unicast DAT_DHT_GET frame from
+                * another backbone gw of the same backbone. If yes, drop
+                * it as this leads to multiplication of arp requests in
bla setups
+                * as long as there is no dat_entry fo this answer. In
this
+                * case better drop the DHT_GET. Normal bla code doesn't
take care of
+                * these packets as they are tunneled via unicast.
+                */
+               unicast_4addr_packet =3D (struct batadv_unicast_4addr_packet
*)skb->data;
+               orig_node =3D batadv_orig_hash_find(bat_priv,
unicast_4addr_packet->src);
+               if (orig_node) {
+                       if ((unicast_4addr_packet->u.packet_type =3D=3D
BATADV_UNICAST_4ADDR) &&
+                                       (unicast_4addr_packet->subtype =3D=
=3D
BATADV_P_DAT_DHT_GET) &&
+                                       (batadv_bla_is_backbone_gw(skb,
orig_node, hdr_size))) {
+                               batadv_dbg(BATADV_DBG_DAT, bat_priv,
"Doubled ARP request removed: "
+                                               "ARP MSG =3D [src: %pM-%pI4
dst: %pM-%pI4]; originator: %pM\n",
+                                               hw_src, &ip_src,
batadv_arp_hw_dst(skb, hdr_size), &ip_dst,
+ unicast_4addr_packet->src);
+                               ret =3D true;
+                       }
+                       batadv_orig_node_put(orig_node);
+               }
+
                goto out;
+       }

        skb_new =3D arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
                             bat_priv->soft_iface, ip_dst, hw_src,
@@ -1203,6 +1228,7 @@ bool batadv_dat_snoop_incoming_arp_reply(struct
batadv_priv *bat_priv,
        __be32 ip_src, ip_dst;
        u8 *hw_src, *hw_dst;
        bool dropped =3D false;
+       struct batadv_dat_entry *dat_entry =3D NULL;
        unsigned short vid;

        if (!atomic_read(&bat_priv->distributed_arp_table))
@@ -1222,12 +1248,38 @@ bool batadv_dat_snoop_incoming_arp_reply(struct
batadv_priv *bat_priv,
        hw_dst =3D batadv_arp_hw_dst(skb, hdr_size);
        ip_dst =3D batadv_arp_ip_dst(skb, hdr_size);

+       /* If ip_dst is already in cache and has the right mac address,
+        * drop this frame if this ARP reply is destined for us. We have
+        * most probably received already a reply from someone else.
Delivering
+        * this frame would lead to doubled receive of an ARP reply.
+        */
+       dat_entry =3D batadv_dat_entry_hash_find(bat_priv, ip_src, vid);
+       if ((dat_entry) && (batadv_compare_eth(hw_src,
dat_entry->mac_addr))) {
+               batadv_dbg(BATADV_DBG_DAT, bat_priv, "Doubled ARP reply
removed: "
+                               "ARP MSG =3D [src: %pM-%pI4 dst: %pM-%pI4];
dat_entry: %pM-%pI4\n",
+                               hw_src, &ip_src, hw_dst, &ip_dst,
dat_entry->mac_addr, &dat_entry->ip);
+               dropped =3D true;
+               goto out;
+       }
+
        /* Update our internal cache with both the IP addresses the node
got
         * within the ARP reply
         */
        batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
        batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);

+       /* If BLA is enabled, only forward ARP replies if we have claimed
the source of
+        * the ARP reply or if no one else of the same backbone has
already claimed
+        * that client. This prevents that different gateways to the same
backbone all
+        * forward the ARP reply leading to multiple replies in the
backbone.
+        */
+       if (!batadv_bla_check_local_claim(bat_priv, hw_src, vid)) {
+               batadv_dbg(BATADV_DBG_DAT, bat_priv, "Device %pM claimed
by another backbone"
+                               " gw. Drop ARP reply.\n", hw_src);
+               dropped =3D true;
+               goto out;
+       }
+
        /* if this REPLY is directed to a client of mine, let's deliver
the
         * packet to the interface
         */
@@ -1240,6 +1292,8 @@ bool batadv_dat_snoop_incoming_arp_reply(struct
batadv_priv *bat_priv,
 out:
        if (dropped)
                kfree_skb(skb);
+       if (dat_entry)
+               batadv_dat_entry_put(dat_entry);
        /* if dropped =3D=3D false -> deliver to the interface */
        return dropped;
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
