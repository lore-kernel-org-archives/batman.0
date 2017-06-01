Return-Path: <apape@phoenixcontact.com>
From: Andreas Pape <apape@phoenixcontact.com>
Message-ID: <20170601085804.4756-1-apape@phoenixcontact.com>
Date: Thu, 1 Jun 2017 10:58:04 +0200
content-transfer-encoding: quoted-printable
content-type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: prevent adding of loop detection
 mac addresses to global tt
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

This patch prevents that entries in the global translation table are genera=
ted
for mac addresses used by loop detection frames.

Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
---
 net/batman-adv/translation-table.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translatio=
n-table.c
index e75b493..ca1e0f7 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1618,8 +1618,10 @@ static bool batadv_tt_global_add(struct batadv_priv =
*bat_priv,
 =09struct batadv_tt_common_entry *common;
 =09u16 local_flags;

-=09/* ignore global entries from backbone nodes */
-=09if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig, vid))
+=09/* ignore global entries from backbone nodes or
+=09 * adding of entries related to loop detect frames */
+=09if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig, vid) ||
+=09=09batadv_bla_is_loopdetect_mac(tt_addr))
 =09=09return true;

 =09tt_global_entry =3D batadv_tt_global_hash_find(bat_priv, tt_addr, vid);
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
