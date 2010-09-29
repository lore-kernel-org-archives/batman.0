Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 29 Sep 2010 23:40:40 +0200
References: <4CA23D45.60306@magwas.rulez.org>
	<201009292220.14857.lindner_marek@yahoo.de>
	<4CA3A534.30102@magwas.rulez.org>
In-Reply-To: <4CA3A534.30102@magwas.rulez.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201009292340.41693.lindner_marek@yahoo.de>
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

On Wednesday 29 September 2010 22:44:36 Magos=C3=A1nyi =C3=81rp=C3=A1d wrot=
e:
> I am using OpenWrt Backfire.

Ok.


> One sign that I am using nonstandard setting is that a non-batman node
> will end up in a throw route of the batman nodes. But if it should work
> without firewall, then I will be happy with my current setup.

A throw route is no problem by itself. It only means that the Linux kernel=
=20
will leave the current table to check the next one for a suitable routing=20
entry.=20

If you are interested in understanding the routing techniques used by batma=
n:
http://www.open-mesh.org/wiki/RoutingVodoo


> What I am seeing is that traffic from local wifi net does not "go down" t=
o the
> tunnels, but goes through the batman nodes untunneled. Maybe I have to set
> up some routes from the local wifi net? For your reference here is the
> network setup again (N is the node number, ip of the node/netmask len):
> backbone batman network: 10.42.0.N/24 (for batman nodes)
> local wifi net: 10.42.N.1/24 (for non-batman users, dhcp served from the
> node in force mode)
> local lan: 10.43.N.1/24 (for wired users, DHCP served from the node)

Does each node announce the "local wifi net" via HNA ? You will need these=
=20
announcements to make the routing towards this addresses work. As soon as=20
batmand knows that it is responsible for a certain IP address space it will=
=20
add the appropriate routing entries for you.
Again, we have a document describing the process:
http://www.open-mesh.org/wiki/AnnouncingNetworks


> P=C3=A1ty, Hungary. We are experimenting with participatory democracy, and
> this is one of the side effects:)

Cool! Good luck with your experiments. :-)

Regards,
Marek

