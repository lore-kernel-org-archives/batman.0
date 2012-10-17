Return-Path: <linus.luessing@web.de>
MIME-Version: 1.0
Message-ID: <trinity-466685df-dab6-476d-be38-9f1320389eff-1350499385870@3capp-webde-bs10>
From: =?UTF-8?Q?=22Linus_L=C3=BCssing=22?= <linus.luessing@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Oct 2012 20:43:05 +0200 (CEST)
In-Reply-To: <20121017133640.GR7023@ritirata.org>
References: <1350479255-904-1-git-send-email-linus.luessing@web.de>,
 <20121017133640.GR7023@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Do not add multicast MAC
 addresses to translation table
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
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

=0A=0A>=20Gesendet:=20Mittwoch,=2017.=20Oktober=202012=20um=2015:36=20Uhr=
=0A>=20Von:=20"Antonio=20Quartulli"=20<ordex@autistici.org>=0A>=20An:=20"Th=
e=20list=20for=20a=20Better=20Approach=20To=20Mobile=20Ad-hoc=20Networking"=
=20<b.a.t.m.a.n@lists.open-mesh.org>=0A>=20Betreff:=20Re:=20[B.A.T.M.A.N.]=
=20[PATCH]=20batman-adv:=20Do=20not=20add=20multicast=20MAC=20addresses=20t=
o=20translation=20table=0A>=0A>=20On=20Wed,=20Oct=2017,=202012=20at=2003:07=
:35PM=20+0200,=20Linus=20L=C3=BCssing=20wrote:=0A>=20>=20The=20current=20tr=
anslation=20table=20mechanism=20is=20not=20suitable=20for=20multicast=0A>=
=20>=20addresses=20and=20we=20are=20currently=20flooding=20such=20frames=20=
anyway.=0A>=20>=20=0A>=20>=20Therefore=20this=20patch=20prevents=20multicas=
t=20MAC=20addresses=20being=20added=20to=20the=0A>=20>=20translation=20tabl=
e.=0A>=20>=20=0A>=20>=20Signed-off-by:=20Linus=20L=C3=BCssing=20<linus.lues=
sing@web.de>=0A>=20>=20---=0A>=20>=20=20soft-interface.c=20|=20=20=20=203=
=20++-=0A>=20>=20=201=20file=20changed,=202=20insertions(+),=201=20deletion=
(-)=0A>=20>=20=0A>=20>=20diff=20--git=20a/soft-interface.c=20b/soft-interfa=
ce.c=0A>=20>=20index=202d1f895..9955319=20100644=0A>=20>=20---=20a/soft-int=
erface.c=0A>=20>=20+++=20b/soft-interface.c=0A>=20>=20@@=20-180,7=20+180,8=
=20@@=20static=20int=20batadv_interface_tx(struct=20sk_buff=20*skb,=0A>=20>=
=20=20=09=09goto=20dropped;=0A>=20>=20=20=0A>=20>=20=20=09/*=20Register=20t=
he=20client=20MAC=20in=20the=20transtable=20*/=0A>=20>=20-=09batadv_tt_loca=
l_add(soft_iface,=20ethhdr->h_source,=20skb->skb_iif);=0A>=20>=20+=09if=20(=
!is_multicast_ether_addr(ethhdr->h_source))=0A>=20>=20+=09=09batadv_tt_loca=
l_add(soft_iface,=20ethhdr->h_source,=20skb->skb_iif);=0A>=20=0A>=20How=20c=
an=20the=20source=20address=20be=20multicast?=20Usually=20multicast=20addre=
sses=20are=20found=0A>=20in=20the=20destination=20field...=0A>=20=0A>=20Is=
=20there=20any=20scenario=20where=20this=20is=20possible?=20I=20am=20wonder=
ing=20whether=20we=20should=0A>=20directly=20drop=20packet=20having=20mcast=
=20address=20as=20source..=0A=0AHm,=20no,=20I=20do=20not=20have=20a=20speci=
fic=20scenario=20in=20mind.=20I=20only=20accidentally=20noticed=20such=20an=
=20FF:FF:FF:FF:FF:FF=20mac=20address=20in=20our=20vis=20graph=20here=20when=
=20I=20made=20a=20typo=20with=20the=20tool=20'mausezahn'.=0A=0AI=20don't=20=
know=20of=20any=20RFC=20or=20so=20which=20would=20generally=20forbid=20usin=
g=20a=20multicast=20source=20MAC=20for=20every=20ether=20type=20(although=
=20for=20sane=20IPv4/v6=20stacks=20I=20haven't=20seen=20something=20like=20=
this=20before=20either=20and=20yes,=20I=20bet=20it's=20not=20allowed=20ther=
e).=0A=0AThe=20Linux=20bridge=20I=20had=20on=20top=20of=20bat0=20was=20happ=
ily=20forwarding=20such=20frames=20into=20batman-adv.=20So=20I=20thought=20=
doing=20it=20like=20the=20bridge=20code=20-=20forwarding=20but=20with=20no=
=20learning=20-=20might=20be=20the=20right=20way?=0A=0ACheers=0A=0A>=20=0A>=
=20Cheers,=0A>=20=0A>=20=0A>=20--=20=0A>=20Antonio=20Quartulli=0A>=20=0A>=
=20..each=20of=20us=20alone=20is=20worth=20nothing..=0A>=20Ernesto=20"Che"=
=20Guevara=0A>=20
