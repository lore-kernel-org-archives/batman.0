Return-Path: <andrew.lunn@ascom.com>
From: <andrew.lunn@ascom.com>
Date: Fri, 9 Mar 2012 13:09:26 +0000
Message-ID: <74A4488FAEEC56408507A6FECA6909910122184D@SC000647.CHASCOM.INT>
References: <4F4F6D18.3070403@ninux.org> <20120309085636.GA9018@pandem0nium>
	<20120309111203.GE15059@kerneis.info>
	<201203091926.54899.lindner_marek@yahoo.de>
	<20120309120455.GF15059@kerneis.info>	<20120309123905.GB436@ritirata.org>
	<20120309125741.GJ15059@kerneis.info>
In-Reply-To: <20120309125741.GJ15059@kerneis.info>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [Battlemesh]   Battlemesh v5 tests
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
To: battlemesh@ml.ninux.org, b.a.t.m.a.n@lists.open-mesh.org

> My question is about some kind of policy routing (setup by the
> administrator,
> not guessed by batman).
>=20
> Consider the following topology:
>=20
>=20
>        l0     l1
>     A ---- B =3D=3D=3D=3D C
>               l2
>=20
> where --- is a single link (l0) and =3D=3D=3D are two links (l1 and l2).
>=20
> Now imagine that the administator wants to dedicate the link l2 to the
> communication between B=A0and C, for whatever reason.  It is fairly easy
> to set
> netfilter rules to that effect, for instance.

Hi Gabriel

Remember that BATMAN is a Layer 2 mesh, not layer 3.=20

It would be possible to do what you want. Simply don't add the l2 interface=
s to BATMAN, put IP addresses from a different subnet on the interfaces, an=
d B and C can use the link l2 for themselves, and use the bat0 interface fo=
r access to the mesh subnet.

	Andrew=20
