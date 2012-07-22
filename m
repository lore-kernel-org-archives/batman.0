Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 22 Jul 2012 13:20:13 +0200
References: <5008C14B.6040707@codigosur.org>
In-Reply-To: <5008C14B.6040707@codigosur.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uH+CQjfhmufiZ2b"
Message-Id: <201207221320.14242.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv not selecting a gateway when using
	"client 1" through uci config
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--Boundary-00=_uH+CQjfhmufiZ2b
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday, July 20, 2012 04:24:11 Nicol=E1s Ech=E1niz wrote:
> there's no gateway being selected until I manually run:
> # batctl gw_mode client 1
> (which was te current mode anyway)
> on each client.
>=20
> In fact, connected computers are not being served DHCP offers because of
> this.
>=20
> Is this some known behavior or just something I overlooked?

In fact you managed to uncover a regression that was overlooked for quite s=
ome=20
time. Guess gw selection class 1 is rarely used.  :-)

Can you apply the attached patch and verify that it fixes the problem ? Her=
e=20
in my test setup it does.

Regards,
Marek

--Boundary-00=_uH+CQjfhmufiZ2b
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-batman-adv-select-an-internet-gateway-if-none-was-ch.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-batman-adv-select-an-internet-gateway-if-none-was-ch.patch"

=46rom 0a29f3a348c68f375585e25153da0f0a061fd71d Mon Sep 17 00:00:00 2001
=46rom: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 22 Jul 2012 13:04:48 +0200
Subject: [PATCH] batman-adv: select an internet gateway if none was chosen
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

This is a regression introduced by: 6a17ecc4603be7f065c38b288d038a0082bbf21d

Reported-by: Nicol=C3=A1s Ech=C3=A1niz <nicoechaniz@codigosur.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
=2D--
 gateway_client.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 47f7186..dace001 100644
=2D-- a/gateway_client.c
+++ b/gateway_client.c
@@ -197,11 +197,11 @@ void gw_election(struct bat_priv *bat_priv)
 	if (atomic_read(&bat_priv->gw_mode) !=3D GW_MODE_CLIENT)
 		goto out;
=20
=2D	if (!atomic_dec_not_zero(&bat_priv->gw_reselect))
=2D		goto out;
=2D
 	curr_gw =3D gw_get_selected_gw_node(bat_priv);
=20
+	if (!atomic_dec_not_zero(&bat_priv->gw_reselect) && curr_gw)
+		goto out;
+
 	next_gw =3D gw_get_best_gw_node(bat_priv);
=20
 	if (curr_gw =3D=3D next_gw)
=2D-=20
1.7.9.1


--Boundary-00=_uH+CQjfhmufiZ2b--
