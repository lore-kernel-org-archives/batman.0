Return-Path: <Jonathan.Haws@sdl.usu.edu>
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Date: Wed, 8 Jun 2016 18:08:48 +0000
Message-ID: <18b9499ee37643aea211c5921980a0d8@Ek.usurf.usu.edu>
References: <31c117a7ea164528a8d01a730c7dd9e8@Ek.usurf.usu.edu>
 <1486656.g3lhHQC2Ly@voltaire>
 <4e5bb9a24054475a9a088932bb48c5e9@Ek.usurf.usu.edu>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Non-batman Clients
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

>> Can you ping from the nodes running batman-adv to other nodes running ba=
tman-=0A=
>> adv ? In other words: Is your mesh working ?=0A=
>=0A=
> Yes, I can use the standard ping command to ping any batman node on the=
=0A=
> mesh from any other batman node.  It is the non-batman clients that are=
=0A=
> not communicating with anything.  They can only ping the node they are=0A=
> directly connected to.=0A=
Double checked this just now and I can ping all batman nodes (their br0 =0A=
interfaces) just fine from any node.=0A=
=0A=
>> Can you provide specifics about what you saw when running tcpdump ? What=
 does=0A=
>> 'never getting anything back' mean ? The ping goes one way without any p=
ong=0A=
>> showing up ? Have you checked on the ping destination (via tcpdump) that=
 the=0A=
>> ping ever made it there ?=0A=
>=0A=
> I had two non-batman clients on the mesh, connected to two different=0A=
> nodes separated by a third node (i.e. for the client on node 1 to=0A=
> communicate to the client on node 3, the data has to go through node 2).=
=0A=
>    Each client can ping the node they are connected to (the br0=0A=
> interface, which has the IP address), but when they try and ping another=
=0A=
> node or the other client I see the ping requests go out in tcpdump, but=
=0A=
> nothing received at the other end (again in tcpdump).  I do see a lot of=
=0A=
> ARP requests without replies on the originator if that helps.=0A=
=0A=
Here is some sample output.  Client 3b is trying to ping client 4a and =0A=
4a is trying to ping 3b at the same time.  While all batman nodes can =0A=
ping other nodes, they can only ping their own clients (i.e. those =0A=
connected directly to them).=0A=
=0A=
I'm guessing I'm missing some sort of routing information or bridge =0A=
configuration.  If anyone can shed some light or let me know what sort =0A=
of output they'd like to see I'm happy to gather it and send it along.=0A=
=0A=
Thanks!=0A=
=0A=
=0A=
Client 3b: 192.168.1.132/24 -- 08:00:27:32:c7:1c=0A=
Command: tcpdump=0A=
=0A=
17:46:26.923228 ARP, Request who-has 192.168.1.132 tell 192.168.1.141, =0A=
length 46=0A=
17:46:26.923246 ARP, Reply 192.168.1.132 is-at 08:00:27:32:c7:1c (oui =0A=
Unknown), length 28=0A=
17:46:26.952511 IP 192.168.1.132 > 192.168.1.141: ICMP echo request, id =0A=
1374, seq 221, length 64=0A=
=0A=
=0A=
Client 4b: 192.168.1.141/24 -- 08:00:27:1f:90:aa=0A=
Command: tcpdump=0A=
=0A=
17:46:26.021447 ARP, Request who-has 192.168.1.132 tell 192.168.1.141, =0A=
length 28=0A=
17:46:26.357353 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP, =0A=
Request from 08:00:27:9d:43:0a (oui Unknown), length 300=0A=
17:46:26.953478 08:00:27:1f:90:aa (oui Unknown) > Broadcast, ethertype =0A=
Unknown (0x4305), length 74:=0A=
	0x0000:  000f 3200 d609 7156 0800 271f 90aa 0800  ..2...qV..'.....=0A=
	0x0010:  271f 90aa 00ff 0024 0401 0014 0102 0002  '......$........=0A=
	0x0020:  3f0f a131 8000 2000 7720 f3e8 0000 0000  ?..1....w.......=0A=
	0x0030:  0601 0004 0000 0000 0201 0000            ............=0A=
=0A=
