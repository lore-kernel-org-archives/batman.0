Return-Path: <Jonathan.Haws@sdl.usu.edu>
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Date: Wed, 8 Jun 2016 19:29:12 +0000
Message-ID: <55afb26665e840de9a3c2fb25f7c2ca0@Ek.usurf.usu.edu>
References: <31c117a7ea164528a8d01a730c7dd9e8@Ek.usurf.usu.edu>
 <1486656.g3lhHQC2Ly@voltaire>
 <4e5bb9a24054475a9a088932bb48c5e9@Ek.usurf.usu.edu>
 <18b9499ee37643aea211c5921980a0d8@Ek.usurf.usu.edu>
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

>>> Can you provide specifics about what you saw when running tcpdump ? Wha=
t does=0A=
>>> 'never getting anything back' mean ? The ping goes one way without any =
pong=0A=
>>> showing up ? Have you checked on the ping destination (via tcpdump) tha=
t the=0A=
>>> ping ever made it there ?=0A=
>>=0A=
>> I had two non-batman clients on the mesh, connected to two different=0A=
>> nodes separated by a third node (i.e. for the client on node 1 to=0A=
>> communicate to the client on node 3, the data has to go through node 2).=
=0A=
>>     Each client can ping the node they are connected to (the br0=0A=
>> interface, which has the IP address), but when they try and ping another=
=0A=
>> node or the other client I see the ping requests go out in tcpdump, but=
=0A=
>> nothing received at the other end (again in tcpdump).  I do see a lot of=
=0A=
>> ARP requests without replies on the originator if that helps.=0A=
>=0A=
> Here is some sample output.  Client 3b is trying to ping client 4a and=0A=
> 4a is trying to ping 3b at the same time.  While all batman nodes can=0A=
> ping other nodes, they can only ping their own clients (i.e. those=0A=
> connected directly to them).=0A=
>=0A=
> I'm guessing I'm missing some sort of routing information or bridge=0A=
> configuration.  If anyone can shed some light or let me know what sort=0A=
> of output they'd like to see I'm happy to gather it and send it along.=0A=
=0A=
One more update.  I switched to use the program arping to just send ARP =0A=
packets.  I found that I can use arping to get the MAC address for any =0A=
node, provided that MAC address is in the cache of the node I am =0A=
connected to.=0A=
=0A=
For example, if I run 'arping -I eth0 192.168.1.102 -c 5 -b' on my =0A=
client at 192.168.1.141, I see replies coming from 192.168.1.104 (the =0A=
batman node which has the MAC cached).  If I omit the '-b' on the arping =
=0A=
command (i.e. use broadcast once, then unicast after), I get the first =0A=
reply, but nothing thereafter, nor does the node see the unicast requests.=
=0A=
=0A=
As another test, I run 'arping -I eth0 192.168.1.132 -c 5 -b' on my =0A=
client at 192.168.1.141, I see the requests propagate through the mesh =0A=
all the way to 192.168.1.132 and I see it reply via a unicast ARP reply. =
=0A=
  However, this unicast ARP reply is not seen by node 192.168.1.103 at =0A=
all (on any interface).=0A=
=0A=
So it seems to be that there is something up with unicasting from a =0A=
non-batman client.  Thoughts?=0A=
