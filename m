Return-Path: <guohuizou2000@sina.com>
From: "gary" <guohuizou2000@sina.com>
References: <02ef01d466a6$f0c629f0$d2527dd0$@sina.com>	
 <19500073.zgPyDjR2lk@bentobox>	
 <100c018ff42541ddb2615fae42bc64f62ced80b4.camel@sdl.usu.edu>	
 <1897809.X9xPm7IOO6@bentobox> <042f01d46c41$fe24ddd0$fa6e9970$@sina.com>
 <98bb1f935c1da5ecdb978b7c95e243ec5c81f04a.camel@sdl.usu.edu>
In-Reply-To: <98bb1f935c1da5ecdb978b7c95e243ec5c81f04a.camel@sdl.usu.edu>
Date: Tue, 30 Oct 2018 13:24:23 +0800
Message-ID: <001901d47010$d20e57d0$762b0770$@sina.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: zh-cn
Subject: Re: [B.A.T.M.A.N.] alfred and batadv-vis issue
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: 'Jonathan Haws' <jhaws@sdl.usu.edu>, sven@narfation.org
Cc: b.a.t.m.a.n@lists.open-mesh.org


In my test setup, both BBN1/2 and MP1/2 are in one subnet.=20

ipv4_arp_request ret =3D -1  interface =3D0x120020070 sipaddr =3D =
0x50505f7   (the first try, sipaddr is right)
ipv4_arp_request ret =3D 0  interface =3D0x120020070 sipaddr =3D =
0x50505f7    (the second try with latest patch)

the cause should be there is no arp entry for the source ip address at =
the first try.


-----Original Message-----
From: Jonathan Haws <jhaws@sdl.usu.edu>=20
Sent: 2018=E5=B9=B410=E6=9C=8830=E6=97=A5 0:07
To: guohuizou2000@sina.com; sven@narfation.org
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [B.A.T.M.A.N.] alfred and batadv-vis issue

> The patch does NOT work for me.
>=20
> I review the code again and find the issue. The following code may=20
> make my testbed work.

Gary - can you describe to me some more details of your test setup?=20
How are BBN1 and BBN2 configured? Are they machines with two different =
Ethernet interfaces (i.e. each having one connected to the downstream =
node and one connected to the switch)? Are they more or less acting as =
routers (i.e. doing IP forwarding)?

The testing I have been doing is just connecting MP1 and MP2 to the same =
switch and having them on the same subnet. Is that not the case in your =
setup?

The other thing I am interested in is what is the result of the first
ioctl() call? I'm guessing it has to be failing, or else the patch would =
have worked for you. Can you add a print statement before the return =
that would give the error string as well as the interface and IP (i.e. =
interface->interface and addr->ipv4.s_addr)? That would be helpful in =
helping me find the root issue.

One thing to note (and Sven, maybe you can tell me if this is
expected): in my testing I found that alfred is getting into this =
ipv4_arp_request call for the local node as well, thus the very first
ioctl() will fail with "No such device or address". Should there be a =
check for this being the local node and just discard it before making =
the check or is making the check all the time then discarding okay?





