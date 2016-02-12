Return-Path: <APape@phoenixcontact.com>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF8F259E43.DCC67654-ONC1257F57.004C278A-C1257F57.004C3956@phoenixcontact.com>
Date: Fri, 12 Feb 2016 14:52:34 +0100
content-transfer-encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Speed up dat by snooping
	received ip traffic
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

From=20cc88159dcf18f4b8310414d2d71635fad76bf5bb Mon Sep 17 00:00:00 2001
From: Andreas Pape <apape@phoenixcontact.com>
Date: Fri, 12 Feb 2016 11:03:10 +0100
Subject: [PATCH 2/4] batman-adv: Speed up dat by snooping received ip
traffic

This patch shall speed up dat by snooping all incoming ip traffic instead
of only relying on ARP handling. This shall especially increase the
probability
that a gateway into a backbone network already has a fitting dat entry to
answer
incoming arp requests directly coming from the backbone network.

Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
---
 net/batman-adv/distributed-arp-table.c |   18 ++++++++++++++++++
 net/batman-adv/distributed-arp-table.h |    8 +++++++-
 net/batman-adv/soft-interface.c        |   21 ++++++++++++++++++++-
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c
b/net/batman-adv/distributed-arp-table.c
index 93893bf..4e64e6c 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -362,6 +362,24 @@ out:
                batadv_dat_entry_put(dat_entry);
 }

+/**
+ * batadv_dat_entry_check - check and update a dat entry
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ip: ipv4 to add/edit
+ * @mac_addr: mac address to assign to the given ipv4
+ * @vid: VLAN identifier
+ *
+ * checks additionally, if dat is enabled. can be called from other
modules.
+ */
+void batadv_dat_entry_check(struct batadv_priv *bat_priv, __be32 ip,
+                                u8 *mac_addr, unsigned short vid)
+{
+       if(!atomic_read(&bat_priv->distributed_arp_table))
+               return;
+
+       batadv_dat_entry_add(bat_priv, ip, mac_addr, vid);
+}
+
 #ifdef CONFIG_BATMAN_ADV_DEBUG

 /**
diff --git a/net/batman-adv/distributed-arp-table.h
b/net/batman-adv/distributed-arp-table.h
index 813ecea..a2ab16b 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -80,7 +80,8 @@ batadv_dat_init_own_addr(struct batadv_priv *bat_priv,
 int batadv_dat_init(struct batadv_priv *bat_priv);
 void batadv_dat_free(struct batadv_priv *bat_priv);
 int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset);
-
+void batadv_dat_entry_check(struct batadv_priv *bat_priv, __be32 ip,
+                                u8 *mac_addr, unsigned short vid);
 /**
  * batadv_dat_inc_counter - increment the correct DAT packet counter
  * @bat_priv: the bat priv with all the soft interface information
@@ -173,6 +174,11 @@ static inline void batadv_dat_inc_counter(struct
batadv_priv *bat_priv,
 {
 }

+void batadv_dat_entry_check(struct batadv_priv *bat_priv, __be32 ip,
+                                u8 *mac_addr, unsigned short vid)
+{
+}
+
 #endif /* CONFIG_BATMAN_ADV_DAT */

 #endif /* _NET_BATMAN_ADV_DISTRIBUTED_ARP_TABLE_H_ */
diff --git a/net/batman-adv/soft-interface.c
b/net/batman-adv/soft-interface.c
index 0710379..41d7987 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -28,6 +28,7 @@
 #include <linux/fs.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
+#include <linux/ip.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
@@ -390,6 +391,7 @@ void batadv_interface_rx(struct net_device
*soft_iface,
        __be16 ethertype =3D htons(ETH_P_BATMAN);
        struct vlan_ethhdr *vhdr;
        struct ethhdr *ethhdr;
+       struct iphdr *iphdr;
        unsigned short vid;
        bool is_bcast;

@@ -412,11 +414,28 @@ void batadv_interface_rx(struct net_device
*soft_iface,
        ethhdr =3D eth_hdr(skb);

        switch (ntohs(ethhdr->h_proto)) {
+       case ETH_P_IP:
+               iphdr =3D (struct iphdr *)(skb->data + ETH_HLEN);
+               /* snoop incoming traffic for dat update using the source
mac
+                * and source ip to speed up dat.
+                * Question: does this break the fundamental idea of
dat????
+                */
+               batadv_dat_entry_check(bat_priv, iphdr->saddr,
ethhdr->h_source, vid);
+               break;
        case ETH_P_8021Q:
                vhdr =3D (struct vlan_ethhdr *)skb->data;

-               if (vhdr->h_vlan_encapsulated_proto !=3D ethertype)
+               if (vhdr->h_vlan_encapsulated_proto !=3D ethertype) {
+                       /* snoop incoming traffic for dat update also for
vlan
+                        * tagged frames.
+                        * Question: does this break the fundamental idea
of dat????
+                        */
+                       if (vhdr->h_vlan_encapsulated_proto =3D=3D ETH_P_IP=
) {
+                               iphdr =3D (struct iphdr *)(vhdr +
sizeof(struct vlan_ethhdr));
+                               batadv_dat_entry_check(bat_priv,
iphdr->saddr, vhdr->h_source, vid);
+                       }
                        break;
+               }

                /* fall through */
        case ETH_P_BATMAN:
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
