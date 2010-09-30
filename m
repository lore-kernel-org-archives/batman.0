Return-Path: <mag@magwas.rulez.org>
Message-ID: <4CA4799C.6050503@magwas.rulez.org>
Date: Thu, 30 Sep 2010 13:50:52 +0200
From: =?UTF-8?B?TWFnb3PDoW55aSDDgXJww6Fk?= <mag@magwas.rulez.org>
MIME-Version: 1.0
References: <4CA23D45.60306@magwas.rulez.org>	<201009292220.14857.lindner_marek@yahoo.de>	<4CA3A534.30102@magwas.rulez.org>
	<201009292340.41693.lindner_marek@yahoo.de>
In-Reply-To: <201009292340.41693.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Mesh with access from wifi and lan. Which is the
 Only True Way?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

  On 2010-09-29 23:40, Marek Lindner wrote:
> On Wednesday 29 September 2010 22:44:36 Magos=C3=A1nyi =C3=81rp=C3=A1d =
wrote:
>> I am using OpenWrt Backfire.
> Ok.
>
>
>> One sign that I am using nonstandard setting is that a non-batman node=

>> will end up in a throw route of the batman nodes. But if it should wor=
k
>> without firewall, then I will be happy with my current setup.
> A throw route is no problem by itself. It only means that the Linux ker=
nel
> will leave the current table to check the next one for a suitable routi=
ng
> entry.
>
> If you are interested in understanding the routing techniques used by b=
atman:
> http://www.open-mesh.org/wiki/RoutingVodoo
>
>
>> What I am seeing is that traffic from local wifi net does not "go down=
" to the
>> tunnels, but goes through the batman nodes untunneled. Maybe I have to=
 set
>> up some routes from the local wifi net? For your reference here is the=

>> network setup again (N is the node number, ip of the node/netmask len)=
:
>> backbone batman network: 10.42.0.N/24 (for batman nodes)
>> local wifi net: 10.42.N.1/24 (for non-batman users, dhcp served from t=
he
>> node in force mode)
>> local lan: 10.43.N.1/24 (for wired users, DHCP served from the node)
> Does each node announce the "local wifi net" via HNA ? You will need th=
ese
> announcements to make the routing towards this addresses work. As soon =
as
> batmand knows that it is responsible for a certain IP address space it =
will
> add the appropriate routing entries for you.
> Again, we have a document describing the process:
> http://www.open-mesh.org/wiki/AnnouncingNetworks
>
>

I do announce local wifi net through HNA.
In the meantime my config started to not work. I saw that the node in=20
the middle does REJECT tunnel traffic from packet filter, so added a=20
firewall rule to accept everything in the FORWARD chain in all nodes.=20
Then as packets started to come out from the system with tunnel source=20
IP, I have added a MASQUERADE on the node which is connected to the=20
internet gateway.

Now it works, but uses the tunnel in an assymetric way: packets out go=20
through the tunnel, packets in go in the plain route.

13:38:53.464186 00:22:fa:95:1d:c4 > 00:0b:6b:3c:74:86, ethertype IPv4=20
(0x0800), length 74: 10.42.3.178.51723 > 1.2.3.4.80: Flags [S], seq=20
2151644104, win 5840, options [mss 1460,sackOK,TS val 6321427 ecr=20
0,nop,wscale 6], length 0
13:38:53.468526 00:0b:6b:3c:74:86 > 00:0b:6b:3c:73:56, ethertype IPv4=20
(0x0800), length 103: 10.42.0.3.4306 > 10.42.0.4.4306: UDP, length 61
13:38:53.469091 00:0b:6b:3c:73:56 > 00:0b:6b:3c:74:8c, ethertype IPv4=20
(0x0800), length 103: 10.42.0.3.4306 > 10.42.0.4.4306: UDP, length 61
13:38:53.474019 00:0b:6b:3c:74:8c > 00:0b:6b:3c:73:56, ethertype IPv4=20
(0x0800), length 74: 1.2.3.4.80 > 10.42.3.178.51723: Flags [S.], seq=20
1125027318, ack 2151644105, win 5792, options [mss 1460,sackOK,TS val=20
19849628 ecr 6321427,nop,wscale 5], length 0
13:38:53.474497 00:0b:6b:3c:73:56 > 00:0b:6b:3c:74:86, ethertype IPv4=20
(0x0800), length 74: 1.2.3.4.80 > 10.42.3.178.51723: Flags [S.], seq=20
1125027318, ack 2151644105, win 5792, options [mss 1460,sackOK,TS val=20
19849628 ecr 6321427,nop,wscale 5], length 0
13:38:53.475385 00:0b:6b:3c:74:86 > 00:22:fa:95:1d:c4, ethertype IPv4=20
(0x0800), length 74: 1.2.3.4.80 > 10.42.3.178.51723: Flags [S.], seq=20
1125027318, ack 2151644105, win 5792, options [mss 1460,sackOK,TS val=20
19849628 ecr 6321427,nop,wscale 5], length 0


>> P=C3=A1ty, Hungary. We are experimenting with participatory democracy,=
 and
>> this is one of the side effects:)
> Cool! Good luck with your experiments. :-)
>
> Regards,
> Marek
>


