Return-Path: <apape@phoenixcontact.com>
From: Andreas Pape <apape@phoenixcontact.com>
Message-ID: <1456381870-29872-1-git-send-email-apape@phoenixcontact.com>
Date: Thu, 25 Feb 2016 07:31:10 +0100
content-transfer-encoding: quoted-printable
content-type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] [PATCH 7/7] batman-adv: handle race condition for
	claims between gateways
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

This patch is crucial for prevention of looping broadcast or multicast
packets in a bla setup. Consider the following situation: Gateway B
has claimed client C and gateway A has the same backbone network as B.
C sends a broad- or multicast to B and directly after this packet
decides to send another packet to A due to a better TQ value. B will
forward the multicast into the backbone as it is the responsible gw
and A will claim C as it has been chosen by C as the best gateway.
If it now happens that A claims C before it has received the multicast
forwarded by B (due to backbone topology or some delay in B) we get
a critical situation: in the current code A will immediately unclaim
C if the multicast is received due to the roaming client scenario
although the position of C has not changed in the mesh. If this
happens the broadcast will be sent back into the mesh and we have a
loop until one of the gateways claims C again.
In order to prevent this, unclaiming of a client due to the roaming
client scenario is only done after a certain time is expired after
the last claim of the client. 100 ms are used here, which should be
slow enough for big backbones and slow gateways but fast enough not
to break the roaming client use case.

Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
---
 net/batman-adv/bridge_loop_avoidance.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge=
_loop_avoidance.c
index 6311ca2..7afddd9 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1761,10 +1761,22 @@ int batadv_bla_tx(struct batadv_priv *bat_priv, str=
uct sk_buff *skb,
 =09=09/* if yes, the client has roamed and we have
 =09=09 * to unclaim it.
 =09=09 */
-=09=09batadv_handle_unclaim(bat_priv, primary_if,
-=09=09=09=09      primary_if->net_dev->dev_addr,
-=09=09=09=09      ethhdr->h_source, vid);
-=09=09goto allow;
+=09=09if (batadv_has_timed_out(claim->lasttime, 100)) {
+=09=09=09/* only unclaim if the last claim entry is
+=09=09=09 * older than 100 ms to make sure we really
+=09=09=09 * have a roaming client here.
+=09=09=09 */
+=09=09=09batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla_tx(): Roaming client %p=
M detected. Unclaim it.\n",
+=09=09=09=09   ethhdr->h_source);
+=09=09=09batadv_handle_unclaim(bat_priv, primary_if,
+=09=09=09=09=09      primary_if->net_dev->dev_addr,
+=09=09=09=09=09      ethhdr->h_source, vid);
+=09=09=09goto allow;
+=09=09} else {
+=09=09=09batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla_tx(): Race for claim %p=
M detected. Drop packet.\n",
+=09=09=09=09   ethhdr->h_source);
+=09=09=09goto handled;
+=09=09}
 =09}

 =09/* check if it is a multicast/broadcast frame */
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
