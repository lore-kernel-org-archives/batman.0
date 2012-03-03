Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 3 Mar 2012 19:32:15 +0800
References: <4F51CA9D.2090404@codigosur.org> <4F51EF0B.5070501@codigosur.org>
	<4F51F168.7000605@codigosur.org>
In-Reply-To: <4F51F168.7000605@codigosur.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201203031932.15663.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] routing loops on interconnected routers / adhoc
	+ ethernet
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

On Saturday, March 03, 2012 18:24:40 Nicol=E1s Ech=E1niz wrote:
> On 03/03/2012 07:14 AM, Nicol=E1s Ech=E1niz wrote:
> > On 03/03/2012 05:43 AM, Marek Lindner wrote:
> >> You should not have loops either way but it is easy to build loops in=
=20
> >> complicated setups. At first we should understand your setup and=20
> >> configuration. Drawing a little picture that shows what interface is
> >> connected  to what other interface also can help.
> >
> >=20
> >
> > alright, I'll try some ascii art, but I'm afraid you'll find out my
> > english is better :P
>=20
> holy s... I knew this wouldn't work
>=20
> I've uploaded the image here:
> http://www.lavecindaria.org.ar/picture/esquema-de-enlaces/

I got your drawing. Would it possible to also post the output of:
 * brctl show
 * batctl if
 * batctl o

We don't need it from all nodes. cisterna, marisa-mr and marisa-blt should =
be=20
enough. Please configure these nodes, so that they theoretically would prod=
uce=20
the routing loop although it is not necessary to wait for the loop itself. =
As=20
I understand it that loop occurs from time to time only?

Regards,
Marek
