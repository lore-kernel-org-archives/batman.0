Date: Mon, 29 Dec 2008 21:39:27 +0100
Message-Id: <1398907753@web.de>
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

Hiii Don,

thank you very much for your reply, for your help...


>
>> 1)
>> I will build a mesh network.. One of my router is connected to my server
>> with the IP 129.211.186.12. I can't make
>> a traceroute through my router to this server. If I try to make
>> "traceroute 129.211.186.12" from an another router I get the message:
>> "PING 129.211.186.12 (129.211.186.12): 56 data bytes
>> ping: sendto: Network is unreachable
>=20
>=20
> router 				Server (129.211.186.12)
> (batman eth0) <------------------> (batman some wireless device)
>=20
> On the router, which firmware are you running with Batman?
>=20
>=20
> When you type batmand -c -d 1 on the router /server what do you see?
>=20
> What does batmand -v show on the router / server?
>=20
>=20

I have some problems with my server at the moment, I will write the output =
of the other commands as soon as possible...


my freifunk firmware is v1.6.29 and the batmand version is :B.A.T.M.A.N. 0.=
2 rv502 (compability version 3)
=20




>> I can send ping requests from my server to the router and from the
>> router to the server, but as I said, I can't make a traceroute to the
>> server
>> from an another router. My question is, how can I do this ?
>>
>> In OLSR it was not a problem to trace the server through the router.
>> Should I change something in HNA messages ?
>>
>> 2)
>> I read the HowTO from Freifunk Leipzig about the configuration of
>> BATMAN, look here http://wiki.leipzig.freifunk.net/BATMAN. How is the
>> configuration
>> If I want to run BATMAN in Ubuntu Intrepid? How can I configure the
>> IPTABLES ?
>>
>=20
> For newer batman and experimental you'll want to open up ports 4305-4307:
>=20
> iptables -t filter -I INPUT 2 -p udp --dport 4305 --sport 4305 -j ACCEPT
> iptables -t filter -I INPUT 2 -p udp --dport 4306 --sport 4306 -j ACCEPT
> iptables -t filter -I INPUT 2 -p udp --dport 4307 --sport 4307 -j ACCEPT
> iptables -t filter -I OUTPUT 2 -p udp --dport 4305 --sport 4305 -j ACCEPT
> iptables -t filter -I OUTPUT 2 -p udp --dport 4306 --sport 4306 -j ACCEPT
> iptables -t filter -I OUTPUT 2 -p udp --dport 4307 --sport 4307 -j ACCEPT


You helped me a lot so far,thank you,=20
I will write the output of the commands as soon as possible...=20


greetings,
John


>=20
>=20
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


