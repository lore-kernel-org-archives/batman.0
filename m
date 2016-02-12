Return-Path: <APape@phoenixcontact.com>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF4C91F5B8.1DBDF49E-ONC1257F57.004C552D-C1257F57.004C60E3@phoenixcontact.com>
Date: Fri, 12 Feb 2016 14:54:15 +0100
content-transfer-encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: free skb when dropping
 broadcast packet received from another backbone gw
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

From=201cf69fc5b7ffac3193ad8fa4439586c865c5acab Mon Sep 17 00:00:00 2001
From: Andreas Pape <apape@phoenixcontact.com>
Date: Fri, 12 Feb 2016 14:00:53 +0100
Subject: [PATCH 4/4] batman-adv: free skb when dropping broadcast packet
received from another backbone gw

skb should be freed in batadv_recv_bcast_packet if packet shall be dropped
due to
reception from another backbone gateway of the same backbone.

Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
---
 net/batman-adv/routing.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 4dd646a..128ed28 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1104,8 +1104,10 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
        /* don't hand the broadcast up if it is from an originator
         * from the same backbone.
         */
-       if (batadv_bla_is_backbone_gw(skb, orig_node, hdr_size))
-               goto out;
+       if (batadv_bla_is_backbone_gw(skb, orig_node, hdr_size)) {
+               kfree_skb(skb);
+               goto rx_success;
+       }

        if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb,
hdr_size))
                goto rx_success;
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
