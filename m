Return-Path: <onelektra@gmx.net>
Date: Thu, 31 Mar 2016 11:54:45 +0200
From: elektra <onelektra@gmx.net>
Message-Id: <20160331115445.c1aa7ca4351a8d80dd937bbe@gmx.net>
In-Reply-To: <DB5PR01MB18642060A402BE7C992F1E0FF1980@DB5PR01MB1864.eurprd01.prod.exchangelabs.com>
References: <DB5PR01MB18642060A402BE7C992F1E0FF1980@DB5PR01MB1864.eurprd01.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Ip rule issue
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Mika -

10.1.4.2=A0is in a different subnet than=A010.1.2.0/24, so the rule to tabl=
e 66 doesn't match.

The IPs of your mesh interfaces (those interfaces that batmand is supposed =
to take care of) must be in the same subnet.=A0

If you actually want to announce routes to different networks/hosts, use th=
e network announcement feature of batmand: -a=A0

Happy testing!
Elektra



On Wed, 30 Mar 2016 07:31:45 +0000
Mika Rajala <mika.rajala@patria.fi> wrote:

> Hi
>=20
> I'm using the latest batmand with ns-3 to test routing.
>=20
> I'm a bit of a newbie with this stuff, so this might be really simple
>=20
> I'm not getting a ping through to 10.1.4.2, from a node that has this in =
its routing table
>=20
> ip route ls table 66
> 10.1.4.2 via 10.1.2.2 dev eth 0  proto static  src 10.1.2.3
> // and so on
>=20
> I'm guessing it's because of this
> ip rule
> 0:                         from all lookup local
> 6600:                  from all to 10.1.2.0/24 lookup 66
> 6699:                  from all lookup 65
> 6700:                  from all to 10.1.2.0/24 lookup 67
> 32766:                from all lookup main
> 32767:                from all lookup default
>=20
> It isn't being told to look for the route to 10.1.4.2 from the table 66 w=
here the route is stored.
>=20
> -mika


--=20
Viral meme of radical freedom=20
=20
The fact that you talk in your head doesn't mean that you think.=20
=20
The worst way to lose control over yourself is by trying to control yoursel=
f.=20
=20
Most people experience themselves as a voice in their head, telling them=20
 who they are, what they think and what they have to do.=20
=20
http://en.wikipedia.org/wiki/Meme=20
