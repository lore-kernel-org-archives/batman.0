Return-Path: <linus.luessing@web.de>
MIME-Version: 1.0
Message-ID: <trinity-bad41429-4528-47e4-81dc-ed7ec370f6d5-1357277691439@3capp-webde-bs44>
From: =?UTF-8?Q?=22Linus_L=C3=BCssing=22?= <linus.luessing@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 4 Jan 2013 06:34:51 +0100 (CET)
In-Reply-To: <11DE1CAB-ADE0-429F-97F1-ED38894E1CE1@stephan.homeunix.net>
References: <201301032300.04942.lindner_marek@yahoo.de>
 <6D44E9FE-9AC6-4747-8BF6-52E6647C0625@stephan.homeunix.net>
 <201301040005.05457.lindner_marek@yahoo.de>,
 <11DE1CAB-ADE0-429F-97F1-ED38894E1CE1@stephan.homeunix.net>
Subject: Re: [B.A.T.M.A.N.] Packet-Loss-Peaks in a Freifunk-Network
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

What=20were=20the=20exact=20batman-adv=20versions=20at=20the=20time=20you=
=20made=20those=20graphs=20for=20the=20shown=20nodes=20as=20well=20as=20any=
=20intermediate=20nodes=20(although=20if=20I=20got=20your=20setup=20right=
=20then=20the=20nodes=20in=20those=20graphs=20do=20not=20have=20any=20inter=
mediate=20batman-adv=20hops=20involved,=20do=20they?)?=0A=0ADoes=20it=20mak=
e=20a=20difference=20if=20you=20make=20the=20entries=20in=20the=20neighbor=
=20solicitation=20table=20permanent=20(e.g.=20with=20'ip=20-6=20neigh')?=0A=
=0ADo=20the=20same=20spikes=20appear=20with=20a=20'batctl=20ping'=20(or=20i=
f=20adding=20such=20graphs=20is=20quite=20a=20hassle=20then=20at=20least,=
=20is=20the=20overall=20'batctl=20ping'=20packet=20loss=20similar=20to=20th=
e=20one=20from=20the=20ip=20ping)?=0A=0ADo=20you=20see=20any=20"Changing=20=
route=20towards"=20events=20in=20the=20batman-adv=20logs=20between=20these=
=20supposedly=20always=20direct=20neighbors=20-=20if=20yes,=20maybe=20with=
=20a=20similar=20frequency?=20Or=20even=20better,=20check=20whether=20the=
=20same=20packet=20loss=20appears=20when=20isolating=20any=20of=20such=20pa=
irs=20of=20nodes=20so=20that=20no=20batman-adv=20route=20changes=20could=20=
happen=20at=20all.=0A=0ADo=20these=20packet=20loss=20events=20correlate=20w=
ith=20periods=20of=20high=20OGM=20loss=20(e.g.=20check=20for=20high=20last-=
seen=20values=20in=20the=20originator=20table)?=0A=0A>=20Gesendet:=20Donner=
stag,=2003.=20Januar=202013=20um=2017:17=20Uhr=0A>=20Von:=20"Jan=20L=C3=BCh=
r"=20<ff@stephan.homeunix.net>=0A>=20An:=20"The=20list=20for=20a=20Better=
=20Approach=20To=20Mobile=20Ad-hoc=20Networking"=20<b.a.t.m.a.n@lists.open-=
mesh.org>=0A>=20Betreff:=20Re:=20[B.A.T.M.A.N.]=20Packet-Loss-Peaks=20in=20=
a=20Freifunk-Network=0A>=0A>=20Hello,=0A>=20=0A>=20Am=2003.01.2013=20um=201=
7:05=20schrieb=20Marek=20Lindner:=0A>=20=0A>=20>=20On=20Thursday,=20January=
=2003,=202013=2023:52:42=20Jan=20L=C3=BChr=20wrote:=0A>=20>>=20Well,=20I=20=
started=20echoing=20on=20the=20underlying=20VPN-connection=20as=20well=20an=
d=0A>=20>>=20changed=20the=20chart-titles=20for=20clearance:=0A>=20>>=20=0A=
>=20>>=20In=20chart=204=20and=20chart=205=20RTT=20/=20Loss=20from=20kif.kbu=
=20to=20node-1=20is=20measured.=0A>=20>>=20In=20chart=204=20kif=20is=20send=
ing=20ICMPv6=20to=20the=20link-local=20address=20of=0A>=20>>=20bat0-interfa=
ce=20-=20in=20chart=205=20the=20link_local=20address=20of=20the=20underlyin=
g=0A>=20>>=20vpn-interface=20is=20used.=0A>=20>=20=0A>=20>=20All=20tests=20=
are=20from=20the=20same=20node=20to=20the=20same=20node=20using=20exactly=
=20the=20same=20means=20=0A>=20>=20(protocols,=20etc)=20with=20the=20except=
ion=20of=20batman-adv=20?=20Sorry=20for=20my=20dumb=20question=20=0A>=20>=
=20but=20your=20topology=20might=20be=20obvious=20to=20you=20but=20isn't=20=
for=20me=20(us?).=0A>=20=0A>=20yes.=0A>=20=0A>=20>=20=0A>=20>=20The=20spike=
s=20on=20your=20graphs=20show=20the=20packet=20loss=20?=0A>=20=0A>=20yes.=
=0A>=20=0A>=20>=20How=20can=20we=20have=20a=20RTT=20<=2050ms=20=0A>=20>=20w=
hile=20experiencing=20packet=20loss=20?=0A>=20=0A>=20=0A>=20Collectd=20uses=
=20a=20ping=20rate=20of=2010=20seconds=20here,=20RTT=20>=3D=200.9s=20=3D=20=
900ms=20is=20"loss"=0A>=20If=201/3=20arrives=20in=20<=2050ms=20and=202/3=20=
are=20lost,=20RTT=20is=20<=2050ms=20=20while=20loss=20=3D=202/3.=0A>=20=0A>=
=20Btw.=20I=20you=20wanna=20see=20our=20setup,=20we=20can=20take=20a=20tour=
=20via=20ssh=20/=20tmux=20-=20I=20can=20provide=20the=20rrd-Files,=20too.=
=0A>=20You=20can=20contact=20my=20by=20jabber=20(yanosz@jabber.ccc.de)=20as=
=20well,=0A>=20=0A>=20Thanks,=0A>=20Keep=20smiling=0A>=20yanosz=0A>=20=0A>=
=20
