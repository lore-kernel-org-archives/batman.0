Return-Path: <nickthefarrow@hotmail.com>
Message-ID: <SNT107-W263AEF87A1D0726A92E172A60D0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_7ed37573-335f-44e5-b7fd-7d18504dd70c_"
From: nick farrow <nickthefarrow@hotmail.com>
Date: Wed, 5 Aug 2009 11:35:48 +0000
In-Reply-To: <200908051931.10324.lindner_marek@yahoo.de>
References: <200908051533.26117.lindner_marek@yahoo.de>
	<SNT107-W1743C6216DE9D4A6F5A50BA60D0@phx.gbl> 
	<200908051931.10324.lindner_marek@yahoo.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Routing help?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

--_7ed37573-335f-44e5-b7fd-7d18504dd70c_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Marek=2C

Thanks very much - so advance sounds like the solution=2C I'll try this. Do=
es the whole bridge work be default with this install or is there some spec=
ial configuration?

My ipkg does list batman adv but its an alpha=2C is this the still the best=
 current version to use?

Regards

nick

> From: lindner_marek@yahoo.de
> To: b.a.t.m.a.n@lists.open-mesh.net
> Date: Wed=2C 5 Aug 2009 19:31:06 +0800
> Subject: Re: [B.A.T.M.A.N.] Routing help?
>=20
>=20
> Hi=2C
>=20
> > I had thought that as they all on the same subnet and bridged that this
> > would be sufficient just relying on standard arps across the entire net=
work
> > as there is no routing. On this basis I assumed there is no need to
> > announce any networks/hosts. Is this a correct understanding?
>=20
> for this to work .1=2C .2 and .3 would need to rebroadcast the ARP reques=
ts. In=20
> a normal wifi ad-hoc network this will not happen. Also=2C in a ordinary =
ethernet=20
> network no router will rebroadcast ARP requests.
>=20
> Basically=2C you can solve this in two different ways:
> * You use routing and flood the network with IP addresses using the batma=
n=20
> daemon.
> * You create a bridge over the whole setup using batman advanced (batman-=
adv=20
> will handle the ARP rebroadcast).
>=20
> Regards=2C
> Marek
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n

_________________________________________________________________
Celebrate a decade of Messenger with free winks=2C emoticons=2C display pic=
s=2C and more.
http://clk.atdmt.com/UKM/go/157562755/direct/01/=

--_7ed37573-335f-44e5-b7fd-7d18504dd70c_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
</style>
</head>
<body class=3D'hmmessage'>
Marek=2C<br><br>Thanks very much - so advance sounds like the solution=2C I=
'll try this. Does the whole bridge work be default with this install or is=
 there some special configuration?<br><br>My ipkg does list batman adv but =
its an alpha=2C is this the still the best current version to use?<br><br>R=
egards<br><br>nick<br><br>&gt=3B From: lindner_marek@yahoo.de<br>&gt=3B To:=
 b.a.t.m.a.n@lists.open-mesh.net<br>&gt=3B Date: Wed=2C 5 Aug 2009 19:31:06=
 +0800<br>&gt=3B Subject: Re: [B.A.T.M.A.N.] Routing help?<br>&gt=3B <br>&g=
t=3B <br>&gt=3B Hi=2C<br>&gt=3B <br>&gt=3B &gt=3B I had thought that as the=
y all on the same subnet and bridged that this<br>&gt=3B &gt=3B would be su=
fficient just relying on standard arps across the entire network<br>&gt=3B =
&gt=3B as there is no routing. On this basis I assumed there is no need to<=
br>&gt=3B &gt=3B announce any networks/hosts. Is this a correct understandi=
ng?<br>&gt=3B <br>&gt=3B for this to work .1=2C .2 and .3 would need to reb=
roadcast the ARP requests. In <br>&gt=3B a normal wifi ad-hoc network this =
will not happen. Also=2C in a ordinary ethernet <br>&gt=3B network no route=
r will rebroadcast ARP requests.<br>&gt=3B <br>&gt=3B Basically=2C you can =
solve this in two different ways:<br>&gt=3B * You use routing and flood the=
 network with IP addresses using the batman <br>&gt=3B daemon.<br>&gt=3B * =
You create a bridge over the whole setup using batman advanced (batman-adv =
<br>&gt=3B will handle the ARP rebroadcast).<br>&gt=3B <br>&gt=3B Regards=
=2C<br>&gt=3B Marek<br>&gt=3B <br>&gt=3B __________________________________=
_____________<br>&gt=3B B.A.T.M.A.N mailing list<br>&gt=3B B.A.T.M.A.N@list=
s.open-mesh.net<br>&gt=3B https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a=
.n<br><br /><hr />Windows Live Messenger: Celebrate 10 amazing years with f=
ree winks and emoticons. <a href=3D'http://clk.atdmt.com/UKM/go/157562755/d=
irect/01/' target=3D'_new'>Get Them Now</a></body>
</html>=

--_7ed37573-335f-44e5-b7fd-7d18504dd70c_--
