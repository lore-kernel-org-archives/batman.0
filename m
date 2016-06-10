Return-Path: <apape@phoenixcontact.com>
From: Andreas Pape <apape@phoenixcontact.com>
In-Reply-To: <1465557064-24406-1-git-send-email-apape@phoenixcontact.com>
References: <1465557064-24406-1-git-send-email-apape@phoenixcontact.com>
Message-ID: <1465557064-24406-6-git-send-email-apape@phoenixcontact.com>
Date: Fri, 10 Jun 2016 13:11:03 +0200
content-transfer-encoding: quoted-printable
content-type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] [PATCH v5 5/6] batman-adv: changed debug messages
	for easier bla debugging
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

Some of the bla debug messages are extended and additional messages are
added for easier bla debugging. Some debug messages introduced with the
dat changes in prior patches of this patch series have been changed to
be more compliant to other existing debug messages.

Acked-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
---
 net/batman-adv/bridge_loop_avoidance.c |   18 ++++++++++++++----
 net/batman-adv/routing.c               |    2 +-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge=
_loop_avoidance.c
index cd2d74b..2ccce6e 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -715,8 +715,8 @@ static void batadv_bla_add_claim(struct batadv_priv *ba=
t_priv,
 =09=09=09goto claim_free_ref;

 =09=09batadv_dbg(BATADV_DBG_BLA, bat_priv,
-=09=09=09   "bla_add_claim(): changing ownership for %pM, vid %d\n",
-=09=09=09   mac, BATADV_PRINT_VID(vid));
+=09=09=09   "bla_add_claim(): changing ownership for %pM, vid %d to gw %pM=
\n",
+=09=09=09   mac, BATADV_PRINT_VID(vid), backbone_gw->orig);

 =09=09spin_lock_bh(&claim->backbone_gw->crc_lock);
 =09=09claim->backbone_gw->crc ^=3D crc16(0, claim->addr, ETH_ALEN);
@@ -1240,10 +1240,13 @@ static void batadv_bla_purge_claims(struct batadv_p=
riv *bat_priv,
 =09=09=09=09continue;

 =09=09=09batadv_dbg(BATADV_DBG_BLA, bat_priv,
-=09=09=09=09   "bla_purge_claims(): %pM, vid %d, time out\n",
+=09=09=09=09   "bla_purge_claims(): timed out.\n");
+
+purge_now:
+=09=09=09batadv_dbg(BATADV_DBG_BLA, bat_priv,
+=09=09=09=09   "bla_purge_claims(): %pM, vid %d\n",
 =09=09=09=09   claim->addr, claim->vid);

-purge_now:
 =09=09=09batadv_handle_unclaim(bat_priv, primary_if,
 =09=09=09=09=09      claim->backbone_gw->orig,
 =09=09=09=09=09      claim->addr, claim->vid);
@@ -1787,6 +1790,13 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, str=
uct sk_buff *skb,
 =09=09/* possible optimization: race for a claim */
 =09=09/* No claim exists yet, claim it for us!
 =09=09 */
+
+=09=09batadv_dbg(BATADV_DBG_BLA, bat_priv,
+=09=09=09   "bla_rx(): Unclaimed MAC %pM found. Claim it. Local: %s\n",
+=09=09=09   ethhdr->h_source,
+=09=09=09   batadv_is_my_client(bat_priv,
+=09=09=09=09=09       ethhdr->h_source, vid) ?
+=09=09=09   "yes" : "no");
 =09=09batadv_handle_claim(bat_priv, primary_if,
 =09=09=09=09    primary_if->net_dev->dev_addr,
 =09=09=09=09    ethhdr->h_source, vid);
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 667e2cd..7eeae86 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -904,7 +904,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 =09=09=09batadv_orig_node_put(orig_node_gw);
 =09=09=09if (is_gw) {
 =09=09=09=09batadv_dbg(BATADV_DBG_BLA, bat_priv,
-=09=09=09=09=09   "Dropped unicast pkt received from another backbone gw %=
pM.\n",
+=09=09=09=09=09   "recv_unicast_packet(): Dropped unicast pkt received fro=
m another backbone gw %pM.\n",
 =09=09=09=09=09   orig_addr_gw);
 =09=09=09=09return NET_RX_DROP;
 =09=09=09}
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
