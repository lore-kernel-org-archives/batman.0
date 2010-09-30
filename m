Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 30 Sep 2010 16:15:40 +0200
References: <4CA23D45.60306@magwas.rulez.org>
	<201009292340.41693.lindner_marek@yahoo.de>
	<4CA4799C.6050503@magwas.rulez.org>
In-Reply-To: <4CA4799C.6050503@magwas.rulez.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201009301615.41517.lindner_marek@yahoo.de>
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

On Thursday 30 September 2010 13:50:52 Magos=C3=A1nyi =C3=81rp=C3=A1d wrote:
> I do announce local wifi net through HNA.
> In the meantime my config started to not work. I saw that the node in=20
> the middle does REJECT tunnel traffic from packet filter, so added a=20
> firewall rule to accept everything in the FORWARD chain in all nodes.=20
> Then as packets started to come out from the system with tunnel source=20
> IP, I have added a MASQUERADE on the node which is connected to the=20
> internet gateway.
>=20
> Now it works, but uses the tunnel in an assymetric way: packets out go=20
> through the tunnel, packets in go in the plain route.

Batmand offers 2 types of tunnel: the "half tunnel" and the "full tunnel" w=
hich=20
allows you to choose what suits you best.

The full tunnel has the advantage that batmand can automatically detect=20
whether the gateway has a working internet connection and switch to another=
=20
gateway if necessary. As tunneling in user space is painfully CPU intense t=
he=20
full tunnel comes with a performance penalty with many simultaneous users. =
 If=20
that is an issue you might want to have a look at the batgat kernel module=
=20
which does the tunneling in kernel space.

The half tunnel does not run into the performance issue that easily but can=
't=20
detect internet availability. As the user traffic is not natted in the tunn=
el=20
this mode is more suitable for SIP and similar protocols.

Half tunnel mode is the default, full tunneling can be activated by natting=
 on=20
the client's gate0 interface:
iptables -t nat -I POSTROUTING -o gate0 -j MASQUERADE

Regards,
Marek
