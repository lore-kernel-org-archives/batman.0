Return-Path: <linus.luessing@web.de>
MIME-Version: 1.0
Message-ID: <trinity-8aea4262-fe03-4043-ab60-541bccb1e2f5-1348397094263@3capp-webde-bs04>
From: =?UTF-8?Q?=22Linus_L=C3=BCssing=22?= <linus.luessing@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Sep 2012 12:44:54 +0200 (CEST)
In-Reply-To: <1348391763-16924-1-git-send-email-lindner_marek@yahoo.de>
References: <201209231715.28695.lindner_marek@yahoo.de>,
 <1348391763-16924-1-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Fix symmetry check / route
 flapping in multi interface setups
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Yes,=20looks=20good.=20Makes=20the=20symmetry=20patch=20look=20more,=20ehm,=
=20"symmetric".=0A=0A>=20Gesendet:=20Sonntag,=2023.=20September=202012=20um=
=2011:16=20Uhr=0A>=20Von:=20"Marek=20Lindner"=20<lindner_marek@yahoo.de>=0A=
>=20An:=20b.a.t.m.a.n@lists.open-mesh.org=0A>=20Cc:=20"Linus=20L=C3=BCssing=
"=20<linus.luessing@web.de>=0A>=20Betreff:=20[PATCHv3]=20batman-adv:=20Fix=
=20symmetry=20check=20/=20route=20flapping=20in=20multi=20interface=20setup=
s=0A>=0A>=20From:=20Linus=20L=C3=BCssing=20<linus.luessing@web.de>=0A>=20=
=0A>=20If=20receiving=20an=20OGM=20from=20a=20neighbor=20other=20than=20the=
=20currently=20selected=0A>=20and=20if=20it=20has=20the=20same=20TQ=20then=
=20we=20are=20supposed=20to=20switch=20if=20this=0A>=20neighbor=20provides=
=20a=20more=20symmetric=20link=20than=20the=20currently=20selected=20one.=
=0A>=20=0A>=20However=20this=20symmetry=20check=20currently=20is=20broken=
=20if=20the=20interface=20of=20the=0A>=20neighbor=20we=20received=20the=20O=
GM=20from=20and=20the=20one=20of=20the=20currently=20selected=0A>=20neighbo=
r=20differ:=20We=20are=20currently=20trying=20to=20determine=20the=20symmet=
ry=20of=20the=0A>=20link=20towards=20the=20selected=20router=20via=20the=20=
link=20we=20received=20the=20OGM=20from=0A>=20instead=20of=20just=20checkin=
g=20via=20the=20link=20towards=20the=20currently=20selected=0A>=20router.=
=0A>=20=0A>=20This=20leads=20to=20way=20more=20route=20switches=20than=20ne=
cessary=20and=20can=20lead=20to=0A>=20permanent=20route=20flapping=20in=20m=
any=20common=20multi=20interface=20setups.=0A>=20=0A>=20This=20patch=20fixe=
s=20this=20issue=20by=20using=20the=20right=20interface=20for=20this=0A>=20=
symmetry=20check.=0A>=20=0A>=20Signed-off-by:=20Linus=20L=C3=BCssing=20<lin=
us.luessing@web.de>=0A>=20---=0A>=20=20bat_iv_ogm.c=20|=20=20=20=207=20++++=
+--=0A>=20=201=20files=20changed,=205=20insertions(+),=202=20deletions(-)=
=0A>=20=0A>=20diff=20--git=20a/bat_iv_ogm.c=20b/bat_iv_ogm.c=0A>=20index=20=
7f0adad..75403a4=20100644=0A>=20---=20a/bat_iv_ogm.c=0A>=20+++=20b/bat_iv_o=
gm.c=0A>=20@@=20-657,6=20+657,7=20@@=20batadv_iv_ogm_orig_update(struct=20b=
atadv_priv=20*bat_priv,=0A>=20=20=09struct=20batadv_neigh_node=20*router=20=
=3D=20NULL;=0A>=20=20=09struct=20batadv_orig_node=20*orig_node_tmp;=0A>=20=
=20=09struct=20hlist_node=20*node;=0A>=20+=09int=20if_num;=0A>=20=20=09uint=
8_t=20sum_orig,=20sum_neigh;=0A>=20=20=09uint8_t=20*neigh_addr;=0A>=20=20=
=09uint8_t=20tq_avg;=0A>=20@@=20-743,12=20+744,14=20@@=20batadv_iv_ogm_orig=
_update(struct=20batadv_priv=20*bat_priv,=0A>=20=20=09if=20(router=20&&=20(=
neigh_node->tq_avg=20=3D=3D=20router->tq_avg))=20{=0A>=20=20=09=09orig_node=
_tmp=20=3D=20router->orig_node;=0A>=20=20=09=09spin_lock_bh(&orig_node_tmp-=
>ogm_cnt_lock);=0A>=20-=09=09sum_orig=20=3D=20orig_node_tmp->bcast_own_sum[=
if_incoming->if_num];=0A>=20+=09=09if_num=20=3D=20router->if_incoming->if_n=
um;=0A>=20+=09=09sum_orig=20=3D=20orig_node_tmp->bcast_own_sum[if_num];=0A>=
=20=20=09=09spin_unlock_bh(&orig_node_tmp->ogm_cnt_lock);=0A>=20=20=0A>=20=
=20=09=09orig_node_tmp=20=3D=20neigh_node->orig_node;=0A>=20=20=09=09spin_l=
ock_bh(&orig_node_tmp->ogm_cnt_lock);=0A>=20-=09=09sum_neigh=20=3D=20orig_n=
ode_tmp->bcast_own_sum[if_incoming->if_num];=0A>=20+=09=09if_num=20=3D=20ne=
igh_node->if_incoming->if_num;=0A>=20+=09=09sum_neigh=20=3D=20orig_node_tmp=
->bcast_own_sum[if_num];=0A>=20=20=09=09spin_unlock_bh(&orig_node_tmp->ogm_=
cnt_lock);=0A>=20=20=0A>=20=20=09=09if=20(sum_orig=20>=3D=20sum_neigh)=0A>=
=20--=20=0A>=201.7.9.1=0A>=20=0A>=20
