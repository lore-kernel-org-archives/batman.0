Return-Path: <APape@phoenixcontact.com>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF5389A718.644E8229-ONC1257E0D.00566F9A-C1257E0D.0056A5A0@phoenixcontact.com>
Date: Thu, 19 Mar 2015 16:46:24 +0100
Content-Type: text/plain; charset="utf-8"
content-transfer-encoding: quoted-printable
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: bugfix for kernel crash in
	batadv_tt_local_table_free
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

This missing check lead to a kernel crash when a hard_if is removed on a=20
node forwarding
untagged and tagged traffic (VLANID 0) to and from the mesh network.

Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
---
 translation-table.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index b20812b..4d3ab8d 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1143,8 +1143,10 @@ static void batadv_tt_local_table_free(struct=20
batadv_priv *bat_priv)
                        /* decrease the reference held for this vlan */
                        vlan =3D batadv_softif_vlan_get(bat_priv,
 tt_common_entry->vid);
-                       batadv_softif_vlan_free_ref(vlan);
-                       batadv_softif_vlan_free_ref(vlan);
+                       if (vlan) {
+                               batadv_softif_vlan_free_ref(vlan);
+                               batadv_softif_vlan_free_ref(vlan);
+                       }
=20
                        batadv_tt_local_entry_free_ref(tt_local);
                }
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
