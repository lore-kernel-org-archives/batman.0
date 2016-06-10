Return-Path: <apape@phoenixcontact.com>
From: Andreas Pape <apape@phoenixcontact.com>
In-Reply-To: <1465557064-24406-1-git-send-email-apape@phoenixcontact.com>
References: <1465557064-24406-1-git-send-email-apape@phoenixcontact.com>
Message-ID: <1465557064-24406-3-git-send-email-apape@phoenixcontact.com>
Date: Fri, 10 Jun 2016 13:11:00 +0200
content-transfer-encoding: quoted-printable
content-type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] [PATCH v5 2/6] batman-adv: speed up dat by snooping
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

Speeding up dat address lookup is achieved by snooping all incoming ip
traffic. This especially increases the propability in bla setups that
a gateway into a common backbone network already has a fitting dat entry
to answer incoming ARP requests directly coming from the backbone
network thus further reducing ARP traffic in the mesh.

Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
---
 net/batman-adv/distributed-arp-table.c |   55 ++++++++++++++++++++++++++++=
++++
 net/batman-adv/distributed-arp-table.h |    9 +++++-
 net/batman-adv/soft-interface.c        |    3 ++
 3 files changed, 66 insertions(+), 1 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distri=
buted-arp-table.c
index b752f8d..998a4b8 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -27,6 +27,7 @@
 #include <linux/if_arp.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
+#include <linux/ip.h>
 #include <linux/in.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
@@ -362,6 +363,60 @@ out:
 =09=09batadv_dat_entry_put(dat_entry);
 }

+/**
+ * batadv_dat_entry_check - check and update a dat entry
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: socket buffer
+ * @vid: VLAN identifier
+ *
+ * snoops incoming socket buffer for dat cache updates, if dat is enabled.
+ * Can be called from other modules.
+ */
+void batadv_dat_entry_check(struct batadv_priv *bat_priv, struct sk_buff *=
skb,
+=09=09=09    unsigned short vid)
+{
+=09struct vlan_ethhdr *vhdr =3D NULL, tmp_vhdr;
+=09struct ethhdr *ethhdr =3D NULL;
+=09struct iphdr *iphdr =3D NULL, tmp_iphdr;
+
+=09if (!atomic_read(&bat_priv->distributed_arp_table))
+=09=09return;
+
+=09ethhdr =3D eth_hdr(skb);
+
+=09switch (ntohs(ethhdr->h_proto)) {
+=09case ETH_P_IP:
+=09=09iphdr =3D skb_header_pointer(skb, ETH_HLEN, sizeof(tmp_iphdr),
+=09=09=09=09=09   &tmp_iphdr);
+=09=09break;
+=09case ETH_P_8021Q:
+=09=09vhdr =3D skb_header_pointer(skb, 0, sizeof(tmp_vhdr),
+=09=09=09=09=09  &tmp_vhdr);
+=09=09if (!vhdr)
+=09=09=09return;
+=09=09if (ntohs(vhdr->h_vlan_encapsulated_proto) !=3D ETH_P_IP)
+=09=09=09return;
+=09=09iphdr =3D skb_header_pointer(skb, sizeof(tmp_vhdr),
+=09=09=09=09=09   sizeof(tmp_iphdr),
+=09=09=09=09=09   &tmp_iphdr);
+=09=09break;
+=09}
+
+=09if (!iphdr)
+=09=09return;
+=09/* don't add source address 0.0.0.0, which can occur during
+=09 * dhcp discover or request.
+=09 */
+=09if (ntohl(iphdr->saddr) =3D=3D 0)
+=09=09return;
+
+=09batadv_dbg(BATADV_DBG_DAT, bat_priv,
+=09=09   "Snooped IP address: %pI4 %pM (vid: %d)\n",
+=09=09   &iphdr->saddr, ethhdr->h_source,
+=09=09   BATADV_PRINT_VID(vid));
+=09batadv_dat_entry_add(bat_priv, iphdr->saddr, ethhdr->h_source, vid);
+}
+
 #ifdef CONFIG_BATMAN_ADV_DEBUG

 /**
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distri=
buted-arp-table.h
index 813ecea..cf1b93c 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -80,7 +80,8 @@ batadv_dat_init_own_addr(struct batadv_priv *bat_priv,
 int batadv_dat_init(struct batadv_priv *bat_priv);
 void batadv_dat_free(struct batadv_priv *bat_priv);
 int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset);
-
+void batadv_dat_entry_check(struct batadv_priv *bat_priv, struct sk_buff *=
skb,
+=09=09=09    unsigned short vid);
 /**
  * batadv_dat_inc_counter - increment the correct DAT packet counter
  * @bat_priv: the bat priv with all the soft interface information
@@ -173,6 +174,12 @@ static inline void batadv_dat_inc_counter(struct batad=
v_priv *bat_priv,
 {
 }

+static inline
+void batadv_dat_entry_check(struct batadv_priv *bat_priv, struct sk_buff *=
skb,
+=09=09=09    unsigned short vid)
+{
+}
+
 #endif /* CONFIG_BATMAN_ADV_DAT */

 #endif /* _NET_BATMAN_ADV_DISTRIBUTED_ARP_TABLE_H_ */
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interfac=
e.c
index 81665b1..a86748f 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -442,6 +442,9 @@ void batadv_interface_rx(struct net_device *soft_iface,
 =09=09goto dropped;
 =09}

+=09/* Snoop incoming traffic for dat update */
+=09batadv_dat_entry_check(bat_priv, skb, vid);
+
 =09/* skb->dev & skb->pkt_type are set here */
 =09skb->protocol =3D eth_type_trans(skb, soft_iface);

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
