Return-Path: <guohuizou2000@sina.com>
From: "gary" <guohuizou2000@sina.com>
References: <02ef01d466a6$f0c629f0$d2527dd0$@sina.com>	
 <2254141.JEhYi27MYC@bentobox>
 <202a9491f70cebec4fe1aa1ba08b2d99d61435c3.camel@sdl.usu.edu>
In-Reply-To: <202a9491f70cebec4fe1aa1ba08b2d99d61435c3.camel@sdl.usu.edu>
Date: Tue, 23 Oct 2018 11:02:37 +0800
Message-ID: <03b201d46a7c$dd0b47e0$9721d7a0$@sina.com>
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


Hi Jon,

Long for your fix. Thanks.

I have a doubt for the issue.
Alfred should send the info by multicast packets. So the packet's dst =
mac address should be multicast mac address.
The packet with multicast mac address should be received by all group =
member, isn't it?
Why does the mesh point need peer's mac address for sending the info?


Regards,
Gary
-----Original Message-----
From: Jonathan Haws <jhaws@sdl.usu.edu>=20
Sent: 2018=E5=B9=B410=E6=9C=8823=E6=97=A5 1:36
To: sven@narfation.org
Cc: b.a.t.m.a.n@lists.open-mesh.org; guohuizou2000@sina.com
Subject: Re: [B.A.T.M.A.N.] alfred and batadv-vis issue


On Thu, 2018-10-18 at 08:22 +0200, Sven Eckelmann wrote:
> On Donnerstag, 18. Oktober 2018 13:53:44 CEST gary wrote:
> > I setup a testbed like this.  (BBN =3D backbone node)
> >=20
> > Switch ---------->BBN1 --------------->MP1
> >         |
> > 		------->BBN2---------------->MP2
> >=20
> > MP1 and MP2 may select BBN1 or BBN2 as gateway.=20
> > On both MP1 and MP2, I enable Alfred and batadv-vis as follows:
> > alfred -i br0 -4 224.0.0.1 -m &
> > batadv-vis -i bat0 -s
>=20
> Looks like you are using the experimental IPv4 support which I don't=20
> want to actively support. So Jonathan Haws should take care of this.
>=20

I am aware of this issue, but was under the impression I was the only =
one it affected. I'm working on a fix (basically check the ARP table and =
if a record doesn't exist for the MAC then run an ARP query; if that =
query fails then report a error) and I hope to have it working soon.

> >=20
> > when I run batadv-vis again on MP1, I can't get the info from MP2.=20
> > If I ping the ip address of MP2 from MP1, MP1 will get MP2's mac=20
> > address by arp.
> > And then I run batadv-vis again, I can get the data from MP2 now.
> >=20
> > Is there any configure or method to get MP2's info without ping=20
> > test?
>=20

We have been working around this issue in the same manner as you =
describe for the time being.

Thanks,
Jon



