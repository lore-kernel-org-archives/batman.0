Date: Wed, 31 Dec 2008 15:23:29 +0100
Message-Id: <1401597840@web.de>
MIME-Version: 1.0
From: John Harris <JHarris@web.de>
Subject: Re: [B.A.T.M.A.N.] Some questions to BATMAN
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hii,

I have fixed my problem... The reason was the HNA announce...After writing =
129.211.186.0If/24 in the HNA field, I could make a=20
traceroute to my server...

Thank you all for the advices...
If anybody has some advices, comments or want to discuss, don't hesistate t=
o contact me...

greetings,
J





> -----Urspr=FCngliche Nachricht-----
> Von: "John Harris" <JHarris@web.de>
> Gesendet: 31.12.08 13:24:46
> An:  dondavis@reglue.org
> Betreff: Re: [B.A.T.M.A.N.] Some questions to BATMAN


> Hii Don,
>=20
> my scenario look like as follows...
>=20
> router 1   <--------------------->  router 2 <-----------------------> ro=
uter 3 (connected to server..IP 129.211.186.46)
> eth1:bat                                   eth1:bat                      =
           eth1:bat  (11.1.1.2) (wired: 129.211.186.12)
>=20
> The IP Adress of my router 3 is 129.211.186.12 (dhcp-lan), router 3 is co=
nnected to my server with the server IP 129.211.186.46.
>=20
> I can ping the eth1:bat interface of the router among each other. But I c=
ouldn't make a trace to the server IP 129.211.186.46 from=20
> an another router... I get the message:
>=20
> " *sendto: Network is unreachable
> traceroute: wrote 129.211.186.46 40 chars, ret=3D-1"=20
>=20
> My settings to BATMAN are:
>=20
> ----------------------------------------
> Management: B.A.T.M.A.N.
>=20
>=20
> WLAN as 			                            11.1.1.3/24
> LAN as 			                            129.211.186.12
>  		=09
> local internet-bandwidth:                    This is not a internet-gatew=
ay=09
> common used gateway 	                    stable
> Prefered gateway: 	        =20
> Host&Network Announcement (HNA): 129.211.186.46/24=09
> Visualisation Server: 	                   =20
> Hello-Interval [ms]: =09
> ----------------------------------------
>   =20
>  The output of the command "batmand -c -d 1" on the router I see:
>  Originator           Router (#/128):    Potential routers... [B.A.T.M.A.=
N. 0.2 rv502, MainIF/IP: eth1:bat 11.1.1.1, UT: 0d 1h22m]
> 11.1.1.3               11.1.1.3 (119):        11.1.1.3 (119)
> 129.211.186.181        11.1.1.3 (128):        11.1.1.3 (128)
>=20
>  Originator           Router (#/128):    Potential routers... [B.A.T.M.A.=
N. 0.2 rv502, MainIF/IP: eth1:bat 11.1.1.3, UT: 0d 0h27m]
> 11.1.1.1               11.1.1.1 (124):        11.1.1.1 (124)
>=20
>=20
> I would be very appreciate, if you an the others could give me some advic=
e how to fix my problem...How can make a
> traceroute form a router to the server IP 129.211.186.46.
>=20
> Thanks in advance...
>=20
> greetings,
> J
>=20
>=20
>=20
> > -----Urspr=FCngliche Nachricht-----
> > Von: "John Harris" <JHarris@web.de>
> > Gesendet: 29.12.08 21:39:27
> > An: b.a.t.m.a.n@open-mesh.net,dondavis@reglue.org
> > Betreff: Re: [B.A.T.M.A.N.] Some questions to BATMAN
>=20
> > Hiii Don,
> >=20
> > thank you very much for your reply, for your help...
> >=20
> >=20
> > >
> > >> 1)
> > >> I will build a mesh network.. One of my router is connected to my se=
rver
> > >> with the IP 129.211.186.12. I can't make
> > >> a traceroute through my router to this server. If I try to make
> > >> "traceroute 129.211.186.12" from an another router I get the message:
> > >> "PING 129.211.186.12 (129.211.186.12): 56 data bytes
> > >> ping: sendto: Network is unreachable
> > >=20
> > >=20
> > > router 				Server (129.211.186.12)
> > > (batman eth0) <------------------> (batman some wireless device)
> > >=20
> > > On the router, which firmware are you running with Batman?
> > >=20
> > >=20
> > > When you type batmand -c -d 1 on the router /server what do you see?
> > >=20
> > > What does batmand -v show on the router / server?
> > >=20
> > >=20
> >=20
> > I have some problems with my server at the moment, I will write the out=
put of the other commands as soon as possible...
> >=20
> >=20
> > my freifunk firmware is v1.6.29 and the batmand version is :B.A.T.M.A.N=
. 0.2 rv502 (compability version 3)
> > =20
> >=20
> >=20
> >=20
> >=20
> > >> I can send ping requests from my server to the router and from the
> > >> router to the server, but as I said, I can't make a traceroute to the
> > >> server
> > >> from an another router. My question is, how can I do this ?
> > >>
> > >> In OLSR it was not a problem to trace the server through the router.
> > >> Should I change something in HNA messages ?
> > >>
> > >> 2)
> > >> I read the HowTO from Freifunk Leipzig about the configuration of
> > >> BATMAN, look here http://wiki.leipzig.freifunk.net/BATMAN. How is the
> > >> configuration
> > >> If I want to run BATMAN in Ubuntu Intrepid? How can I configure the
> > >> IPTABLES ?
> > >>
> > >=20
> > > For newer batman and experimental you'll want to open up ports 4305-4=
307:
> > >=20
> > > iptables -t filter -I INPUT 2 -p udp --dport 4305 --sport 4305 -j ACC=
EPT
> > > iptables -t filter -I INPUT 2 -p udp --dport 4306 --sport 4306 -j ACC=
EPT
> > > iptables -t filter -I INPUT 2 -p udp --dport 4307 --sport 4307 -j ACC=
EPT
> > > iptables -t filter -I OUTPUT 2 -p udp --dport 4305 --sport 4305 -j AC=
CEPT
> > > iptables -t filter -I OUTPUT 2 -p udp --dport 4306 --sport 4306 -j AC=
CEPT
> > > iptables -t filter -I OUTPUT 2 -p udp --dport 4307 --sport 4307 -j AC=
CEPT
> >=20
> >=20
> > You helped me a lot so far,thank you,=20
> > I will write the output of the commands as soon as possible...=20
> >=20
> >=20
> > greetings,
> > John
> >=20
> >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > > _______________________________________________
> > > B.A.T.M.A.N mailing list
> > > B.A.T.M.A.N@open-mesh.net
> > > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> > >=20
> >=20
>=20
>=20
> _______________________________________________________________________
> T=E4glich 1.000.000 Euro gewinnen! Jetzt kostenlos WEB.DE MillionenKlick =

> spielen! https://millionenklick.web.de/?mc=3Dmail@footer.mklick@home
>=20
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20


_______________________________________________________________________
Sensationsangebot verl=E4ngert: WEB.DE FreeDSL - Telefonanschluss + DSL
f=FCr nur 16,37 Euro/mtl.!* http://dsl.web.de/?ac=3DOM.AD.AD008K15039B7069a


