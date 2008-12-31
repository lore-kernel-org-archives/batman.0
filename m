Date: Wed, 31 Dec 2008 13:20:00 +0100
Message-Id: <1401440253@web.de>
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
To: b.a.t.m.a.n@open-mesh.net, dondavis@reglue.org

Hii Don,

my scenario look like as follows...

router 1   <--------------------->  router 2 <-----------------------> rout=
er 3 (connected to server..IP 129.211.186.46)
eth1:bat                                   eth1:bat                        =
         eth1:bat  (11.1.1.2) (wired: 129.211.186.12)

The IP Adress of my router 3 is 129.211.186.12 (dhcp-lan), router 3 is conn=
ected to my server with the server IP 129.211.186.46.

I can ping the eth1:bat interface of the router among each other. But I cou=
ldn't make a trace to the server IP 129.211.186.46 from=20
an another router... I get the message:

" *sendto: Network is unreachable
traceroute: wrote 129.211.186.46 40 chars, ret=3D-1"=20

My settings to BATMAN are:

----------------------------------------
Management: B.A.T.M.A.N.


WLAN as 			                            11.1.1.3/24
LAN as 			                            129.211.186.12
 		=09
local internet-bandwidth:                    This is not a internet-gateway=
=09
common used gateway 	                    stable
Prefered gateway: 	        =20
Host&Network Announcement (HNA): 129.211.186.46/24=09
Visualisation Server: 	                   =20
Hello-Interval [ms]: =09
----------------------------------------
  =20
 The output of the command "batmand -c -d 1" on the router I see:
 Originator           Router (#/128):    Potential routers... [B.A.T.M.A.N.=
 0.2 rv502, MainIF/IP: eth1:bat 11.1.1.1, UT: 0d 1h22m]
11.1.1.3               11.1.1.3 (119):        11.1.1.3 (119)
129.211.186.181        11.1.1.3 (128):        11.1.1.3 (128)

 Originator           Router (#/128):    Potential routers... [B.A.T.M.A.N.=
 0.2 rv502, MainIF/IP: eth1:bat 11.1.1.3, UT: 0d 0h27m]
11.1.1.1               11.1.1.1 (124):        11.1.1.1 (124)


I would be very appreciate, if you an the others could give me some advice =
how to fix my problem...How can make a
traceroute form a router to the server IP 129.211.186.46.

Thanks in advance...

greetings,
J



> -----Urspr=FCngliche Nachricht-----
> Von: "John Harris" <JHarris@web.de>
> Gesendet: 29.12.08 21:39:27
> An: b.a.t.m.a.n@open-mesh.net,dondavis@reglue.org
> Betreff: Re: [B.A.T.M.A.N.] Some questions to BATMAN

> Hiii Don,
>=20
> thank you very much for your reply, for your help...
>=20
>=20
> >
> >> 1)
> >> I will build a mesh network.. One of my router is connected to my serv=
er
> >> with the IP 129.211.186.12. I can't make
> >> a traceroute through my router to this server. If I try to make
> >> "traceroute 129.211.186.12" from an another router I get the message:
> >> "PING 129.211.186.12 (129.211.186.12): 56 data bytes
> >> ping: sendto: Network is unreachable
> >=20
> >=20
> > router 				Server (129.211.186.12)
> > (batman eth0) <------------------> (batman some wireless device)
> >=20
> > On the router, which firmware are you running with Batman?
> >=20
> >=20
> > When you type batmand -c -d 1 on the router /server what do you see?
> >=20
> > What does batmand -v show on the router / server?
> >=20
> >=20
>=20
> I have some problems with my server at the moment, I will write the outpu=
t of the other commands as soon as possible...
>=20
>=20
> my freifunk firmware is v1.6.29 and the batmand version is :B.A.T.M.A.N. =
0.2 rv502 (compability version 3)
> =20
>=20
>=20
>=20
>=20
> >> I can send ping requests from my server to the router and from the
> >> router to the server, but as I said, I can't make a traceroute to the
> >> server
> >> from an another router. My question is, how can I do this ?
> >>
> >> In OLSR it was not a problem to trace the server through the router.
> >> Should I change something in HNA messages ?
> >>
> >> 2)
> >> I read the HowTO from Freifunk Leipzig about the configuration of
> >> BATMAN, look here http://wiki.leipzig.freifunk.net/BATMAN. How is the
> >> configuration
> >> If I want to run BATMAN in Ubuntu Intrepid? How can I configure the
> >> IPTABLES ?
> >>
> >=20
> > For newer batman and experimental you'll want to open up ports 4305-430=
7:
> >=20
> > iptables -t filter -I INPUT 2 -p udp --dport 4305 --sport 4305 -j ACCEPT
> > iptables -t filter -I INPUT 2 -p udp --dport 4306 --sport 4306 -j ACCEPT
> > iptables -t filter -I INPUT 2 -p udp --dport 4307 --sport 4307 -j ACCEPT
> > iptables -t filter -I OUTPUT 2 -p udp --dport 4305 --sport 4305 -j ACCE=
PT
> > iptables -t filter -I OUTPUT 2 -p udp --dport 4306 --sport 4306 -j ACCE=
PT
> > iptables -t filter -I OUTPUT 2 -p udp --dport 4307 --sport 4307 -j ACCE=
PT
>=20
>=20
> You helped me a lot so far,thank you,=20
> I will write the output of the commands as soon as possible...=20
>=20
>=20
> greetings,
> John
>=20
>=20
> >=20
> >=20
> >=20
> >=20
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@open-mesh.net
> > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> >=20
>=20


_______________________________________________________________________
T=E4glich 1.000.000 Euro gewinnen! Jetzt kostenlos WEB.DE MillionenKlick=20
spielen! https://millionenklick.web.de/?mc=3Dmail@footer.mklick@home


