Return-Path: <apape@phoenixcontact.com>
From: Andreas Pape <apape@phoenixcontact.com>
Message-ID: <1456492768-29861-1-git-send-email-apape@phoenixcontact.com>
Date: Fri, 26 Feb 2016 14:19:28 +0100
content-transfer-encoding: quoted-printable
content-type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] [PATCHv2 6/7] batman-adv: bugfix for dat
	optimiziation patch
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

Make sure that claiming of devices due to dat handling is only done
for non-local mac addresses. As dat is handled after the normal bla
code this does not break the roaming client scenario for bla.

Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
---
 net/batman-adv/bridge_loop_avoidance.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge=
_loop_avoidance.c
index 739f80f..32a6168 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1959,13 +1959,19 @@ bool batadv_bla_handle_local_claim(struct batadv_pr=
iv *bat_priv,
 =09=09=09=09=09primary_if->net_dev->dev_addr))
 =09=09=09ret =3D false;
 =09} else {
-=09=09/* If there is no claim, claim the device */
-=09=09batadv_dbg(BATADV_DBG_BLA, bat_priv,
-=09=09=09   "Handle claim locally for currently not claimed mac %pM.\n",
-=09=09=09   search_claim.addr);
+=09=09/* If there is no claim, claim the device
+=09=09 * but only if this isn't a mac address
+=09=09 * out of the local tt
+=09=09 */
+=09=09if (!batadv_is_my_client(bat_priv, addr, vid)) {
+=09=09=09batadv_dbg(BATADV_DBG_BLA, bat_priv,
+=09=09=09=09   "bla_handle_local_claim(): Handle claim locally for current=
ly not claimed mac %pM.\n",
+=09=09=09=09   search_claim.addr);

-=09=09batadv_handle_claim(bat_priv, primary_if,
-=09=09=09=09    primary_if->net_dev->dev_addr, addr, vid);
+=09=09=09batadv_handle_claim(bat_priv, primary_if,
+=09=09=09=09=09    primary_if->net_dev->dev_addr,
+=09=09=09=09=09    addr, vid);
+=09=09}
 =09}

 out:
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
