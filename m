Return-Path: <APape@phoenixcontact.com>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OFDCB0C675.8A026ED2-ONC1257E0D.002690BF-C1257E0D.0026F071@phoenixcontact.com>
Date: Thu, 19 Mar 2015 08:05:19 +0100
Content-Type: text/plain; charset="utf-8"
content-transfer-encoding: quoted-printable
Subject: [B.A.T.M.A.N.] [PATCH] dat optimization test
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

From=20e0b37ee6d7d82648768dc98a95c3a61d7edf86dd Mon Sep 17 00:00:00 2001
From: Andreas Pape <apape@phoenixcontact.com>
Date: Wed, 18 Mar 2015 11:03:22 +0100
Subject: [PATCH] dat optimization test


Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
---
 bridge_loop_avoidance.c |   60 +++++++++++++++++++++++++++++++++
 bridge_loop_avoidance.h |    6 +++
 distributed-arp-table.c |   85=20
++++++++++++++++++++++++++++++++++++++++++++++-
 distributed-arp-table.h |    7 +++-
 routing.c               |    6 ++-
 soft-interface.c        |   17 ++++++++-
 6 files changed, 175 insertions(+), 6 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 6927589..bdc8ac9 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1712,3 +1712,63 @@ out:
                batadv_hardif_free_ref(primary_if);
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
+bool batadv_check_local_claim(struct batadv_priv *bat_priv, uint8_t=20
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
+               /* First look if the mac address is is already claimed */
+               ether_addr_copy(search_claim.addr, addr);
+               search_claim.vid =3D vid;
+
+               claim =3D batadv_claim_hash_find(bat_priv,
+                                 &search_claim);
+
+               /* If there is a claim and we are not owner of the claim,=20
+                * return false.
+                */
+               if (claim) {
+                       if (!batadv_compare_eth(claim->backbone_gw->orig,=20
primary_if->net_dev->dev_addr)) {
+                               ret =3D false;
+                       }
+               } else {
+                       /* If there is no claim, claim the device
+                        * Question: is this likey to happen?
+                        */
+                       batadv_dbg(BATADV_DBG_BLA, bat_priv, "No claim=20
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
+               batadv_claim_free_ref(claim);
+       if (primary_if)
+               batadv_hardif_free_ref(primary_if);
+       return ret;
+}
diff --git a/bridge_loop_avoidance.h b/bridge_loop_avoidance.h
index 43c985d..85f6ecb 100644
--- a/bridge_loop_avoidance.h
+++ b/bridge_loop_avoidance.h
@@ -37,6 +37,7 @@ void batadv_bla_update_orig_address(struct batadv_priv=20
*bat_priv,
                                    struct batadv_hard_iface *oldif);
 int batadv_bla_init(struct batadv_priv *bat_priv);
 void batadv_bla_free(struct batadv_priv *bat_priv);
+bool batadv_check_local_claim(struct batadv_priv *bat_priv, uint8_t=20
*addr, unsigned short vid);
=20
 #define BATADV_BLA_CRC_INIT    0
 #else /* ifdef CONFIG_BATMAN_ADV_BLA */
@@ -103,6 +104,11 @@ static inline void batadv_bla_free(struct batadv_priv=
=20
*bat_priv)
 {
 }
=20
+bool batadv_check_local_claim(struct batadv_priv *bat_priv, uint8_t=20
*addr, unsigned short vid)
+{
+       return true;
+}
+
 #endif /* ifdef CONFIG_BATMAN_ADV_BLA */
=20
 #endif /* ifndef _NET_BATMAN_ADV_BLA_H_ */
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 107ad62..69b4484 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -23,6 +23,7 @@
 #include "main.h"
 #include "hash.h"
 #include "distributed-arp-table.h"
+#include "bridge_loop_avoidance.h"
 #include "hard-interface.h"
 #include "originator.h"
 #include "send.h"
@@ -327,6 +328,24 @@ out:
                batadv_dat_entry_free_ref(dat_entry);
 }
=20
+/**
+ * batadv_dat_entry_check - check and update a dat entry
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ip: ipv4 to add/edit
+ * @mac_addr: mac address to assign to the given ipv4
+ * @vid: VLAN identifier
+ *
+ * checks additionally, if dat is enabled. can be called from other=20
modules.
+ */
+void batadv_dat_entry_check(struct batadv_priv *bat_priv, __be32 ip,
+                                uint8_t *mac_addr, unsigned short vid)
+{
+       if(!atomic_read(&bat_priv->distributed_arp_table))
+               return;
+
+       batadv_dat_entry_add(bat_priv, ip, mac_addr, vid);
+}
+
 #ifdef CONFIG_BATMAN_ADV_DEBUG
=20
 /**
@@ -959,6 +978,16 @@ bool batadv_dat_snoop_outgoing_arp_request(struct=20
batadv_priv *bat_priv,
                        ret =3D true;
                        goto out;
                }
+               /* If BLA is enabled, only send ARP REPLYs if we have=20
claimed
+                * the destination for the ARP request or if no one else=20
has already
+                * claimed that client.
+                */
+               if (!batadv_check_local_claim(bat_priv,=20
dat_entry->mac_addr, vid)) {
+                       batadv_dbg(BATADV_DBG_DAT, bat_priv, "Device %pM=20
claimed by another backbone gw. Don't send ARP reply.\n",
+                                       dat_entry->mac_addr);
+                       ret =3D true;
+                       goto out;
+               }
=20
                skb_new =3D arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
                                     bat_priv->soft_iface, ip_dst, hw_src,
@@ -1008,6 +1037,8 @@ bool batadv_dat_snoop_incoming_arp_request(struct=20
batadv_priv *bat_priv,
        uint8_t *hw_src;
        struct sk_buff *skb_new;
        struct batadv_dat_entry *dat_entry =3D NULL;
+       struct batadv_unicast_4addr_packet *unicast_4addr_packet;
+       struct batadv_orig_node *orig_node =3D NULL;
        bool ret =3D false;
        unsigned short vid;
        int err;
@@ -1031,8 +1062,31 @@ bool batadv_dat_snoop_incoming_arp_request(struct=20
batadv_priv *bat_priv,
        batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
=20
        dat_entry =3D batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
-       if (!dat_entry)
+       if (!dat_entry) {
+
+               /* Check if this is a 4addr unicast DAT_DHT_GET frame from=
=20
another
+                * backbone gw. If yes, drop it as this leads to=20
multiplication of arp requests in bla setups
+                * as long as there is no dat_entry for the answer. In=20
this case better drop the DHT_GET.
+                * Normal bla code doesn't take care of these packets as=20
they are tunneled via unicast.
+                */
+               unicast_4addr_packet =3D (struct batadv_unicast_4addr_packe=
t=20
*)skb->data;
+               orig_node =3D batadv_orig_hash_find(bat_priv,=20
unicast_4addr_packet->src);
+
+               if (orig_node) {
+                       if ((unicast_4addr_packet->u.packet_type =3D=3D=20
BATADV_UNICAST_4ADDR) &&
+                                       (unicast_4addr_packet->subtype =3D=
=3D=20
BATADV_P_DAT_DHT_GET) &&
+                                       (batadv_bla_is_backbone_gw(skb,=20
orig_node, hdr_size))) {
+                               batadv_dbg(BATADV_DBG_DAT, bat_priv,
+                                               "Doubled ARP request=20
removed: ARP MSG =3D [src: %pM-%pI4 dst: %pM-%pI4]; originator: %pM\n",
+                                               hw_src, &ip_src,
+                                               batadv_arp_hw_dst(skb,=20
hdr_size), &ip_dst, unicast_4addr_packet->src);
+                               ret =3D true;
+                       }
+                       batadv_orig_node_free_ref(orig_node);
+               }
+
                goto out;
+       }
=20
        skb_new =3D arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
                             bat_priv->soft_iface, ip_dst, hw_src,
@@ -1128,6 +1182,7 @@ bool batadv_dat_snoop_incoming_arp_reply(struct=20
batadv_priv *bat_priv,
        __be32 ip_src, ip_dst;
        uint8_t *hw_src, *hw_dst;
        bool ret =3D false;
+       struct batadv_dat_entry *dat_entry =3D NULL;
        unsigned short vid;
=20
        if (!atomic_read(&bat_priv->distributed_arp_table))
@@ -1147,12 +1202,38 @@ bool batadv_dat_snoop_incoming_arp_reply(struct=20
batadv_priv *bat_priv,
        hw_dst =3D batadv_arp_hw_dst(skb, hdr_size);
        ip_dst =3D batadv_arp_ip_dst(skb, hdr_size);
=20
+       /* If ip_dst is already in cache and has the right mac address,
+        * drop the frame if we are the destination of ARP reply
+        * as we most probably already delivered a corresponding arp reply=
=20
*/
+       dat_entry =3D batadv_dat_entry_hash_find(bat_priv, ip_src, vid);
+       if ((dat_entry) &&
+                       (batadv_compare_eth(hw_src,=20
dat_entry->mac_addr))){
+                       batadv_dbg(BATADV_DBG_DAT, bat_priv,
+                                  "Doubled ARP reply removed: ARP MSG =3D=
=20
[src: %pM-%pI4 dst: %pM-%pI4]; dat_entry: %pM-%pI4\n",
+                                  hw_src, &ip_src,
+                                  hw_dst, &ip_dst, dat_entry->mac_addr,=20
&dat_entry->ip);
+                       ret =3D true;
+                       goto out;
+       }
+
        /* Update our internal cache with both the IP addresses the node=20
got
         * within the ARP reply
         */
        batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
        batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
=20
+       /* If BLA is enabled, only forward ARP REPLYs if we have claimed
+        * the source of the ARP reply or if no one else of the same=20
backbone has already
+        * claimed that client. This prevents that different gateways to=20
the same backbone
+        * all forward the ARP reply leading to multiple replies in the=20
backbone.
+        */
+       if (!batadv_check_local_claim(bat_priv, hw_src, vid)) {
+               batadv_dbg(BATADV_DBG_DAT, bat_priv, "Device %pM claimed=20
by another backbone gw. Drop ARP reply.\n",
+                               hw_src);
+               ret =3D true;
+               goto out;
+       }
+
        /* if this REPLY is directed to a client of mine, let's deliver=20
the
         * packet to the interface
         */
@@ -1160,6 +1241,8 @@ bool batadv_dat_snoop_incoming_arp_reply(struct=20
batadv_priv *bat_priv,
 out:
        if (ret)
                kfree_skb(skb);
+       if (dat_entry)
+               batadv_dat_entry_free_ref(dat_entry);
        /* if ret =3D=3D false -> packet has to be delivered to the interfa=
ce=20
*/
        return ret;
 }
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 2fe0764..ed9c5c2 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -73,7 +73,8 @@ batadv_dat_init_own_addr(struct batadv_priv *bat_priv,
 int batadv_dat_init(struct batadv_priv *bat_priv);
 void batadv_dat_free(struct batadv_priv *bat_priv);
 int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset);
-
+void batadv_dat_entry_check(struct batadv_priv *bat_priv, __be32 ip,
+                                uint8_t *mac_addr, unsigned short vid);
 /**
  * batadv_dat_inc_counter - increment the correct DAT packet counter
  * @bat_priv: the bat priv with all the soft interface information
@@ -161,6 +162,10 @@ static inline void batadv_dat_free(struct batadv_priv=
=20
*bat_priv)
 {
 }
=20
+void batadv_dat_entry_check(struct batadv_priv *bat_priv, __be32 ip,
+                                uint8_t *mac_addr, unsigned short vid)
+{
+}
 static inline void batadv_dat_inc_counter(struct batadv_priv *bat_priv,
                                          uint8_t subtype)
 {
diff --git a/routing.c b/routing.c
index da83982..6f60538 100644
--- a/routing.c
+++ b/routing.c
@@ -1061,8 +1061,10 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
        /* don't hand the broadcast up if it is from an originator
         * from the same backbone.
         */
-       if (batadv_bla_is_backbone_gw(skb, orig_node, hdr_size))
-               goto out;
+       if (batadv_bla_is_backbone_gw(skb, orig_node, hdr_size)) {
+               kfree_skb(skb);
+               goto rx_success;
+       }
=20
        if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb,=20
hdr_size))
                goto rx_success;
diff --git a/soft-interface.c b/soft-interface.c
index 78d63e3..5eb3191 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -358,8 +358,9 @@ void batadv_interface_rx(struct net_device=20
*soft_iface,
        struct batadv_bcast_packet *batadv_bcast_packet;
        struct batadv_priv *bat_priv =3D netdev_priv(soft_iface);
        __be16 ethertype =3D htons(ETH_P_BATMAN);
-       struct vlan_ethhdr *vhdr;
+       struct vlan_ethhdr *vhdr =3D NULL;
        struct ethhdr *ethhdr;
+       struct iphdr *iphdr;
        unsigned short vid;
        bool is_bcast;
=20
@@ -382,11 +383,23 @@ void batadv_interface_rx(struct net_device=20
*soft_iface,
        ethhdr =3D eth_hdr(skb);
=20
        switch (ntohs(ethhdr->h_proto)) {
+       case ETH_P_IP:
+               iphdr =3D (struct iphdr *)(skb->data + ETH_HLEN);
+               /* snoop incoming traffic for dat update using the source=20
mac and source ip */
+               batadv_dat_entry_check(bat_priv, iphdr->saddr,=20
ethhdr->h_source, vid);
+               break;
        case ETH_P_8021Q:
                vhdr =3D (struct vlan_ethhdr *)skb->data;
=20
-               if (vhdr->h_vlan_encapsulated_proto !=3D ethertype)
+               if (vhdr->h_vlan_encapsulated_proto !=3D ethertype) {
+                       /* snoop incoming traffic for dat update using the=
=20
source mac and source ip.
+                        * Consider also vlan tagged frames */
+                       if (vhdr->h_vlan_encapsulated_proto =3D=3D ETH_P_IP=
) {
+                               iphdr =3D (struct iphdr *)(vhdr +=20
sizeof(struct vlan_ethhdr));
+                               batadv_dat_entry_check(bat_priv,=20
iphdr->saddr, vhdr->h_source, vid);
+                       }
                        break;
+               }
=20
                /* fall through */
        case ETH_P_BATMAN:
--=20
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
