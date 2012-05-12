Return-Path: <ordex@autistici.org>
Date: Sat, 12 May 2012 20:31:18 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120512183104.GA27709@ritirata.org>
References: <20120504000852.GA29070@ritirata.org>
	<201205102112.37690.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <201205102112.37690.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Improving the roaming procedure: multiple
 roaming within one orig interval
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


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 10, 2012 at 09:12:37 +0800, Marek Lindner wrote:
>=20
> Hi,
>=20
> > Right now I am working on a concept that would enable such possibility.=
 I
> > tried to summarise my ideas on the wiki as well[1] in order to share wi=
th
> > you the solution I am thinking about.
> >=20
> > The document is still a draft and may not be 100% understandable. If you
> > have time and you are curious enough to read the wiki, please drop me y=
our
> > feedback, it would really be appreciated :-)
>=20
> if I understand the document correctly each mesh node a client connects t=
o=20
> will send a roaming advertisement back to the last known mesh node this c=
lient=20
> was connected to.

Yes, this is the idea.

> A few questions come to my mind:
>=20
>  * Does this already work with the current code ? If not what happens now=
 ?

Now the ROAM_ADV is still sent to the last known mesh node the client was
connected to, but the rerouting mechanism could be broken by other nodes th=
at
still think the client is connected to them. (if a client at A roams to B a=
nd
then to C, B could break the rerouting).

>  * How do all nodes get back in sync ? It sounds to me like for certain w=
hile=20
> a number of nodes claim the same client, right ? Nobody tells the interme=
diate=20
> mesh nodes that their client has moved.

all the nodes will advertise the entry and so all the nodes will delete it,
but, eventually, the node that is really serving the client will re-add it =
and
advertise it again.
Yap, this must be improved. thank you for pointing it out.

>  * What if receiving a roaming advertisement triggered an immediate=20
> (unscheduled) OGM broadcast ? That would potentially speed up the gap and=
 also=20
> address the "longer path" problem you outlined in the wikipage.

I have to think about that... Imho the OGM should not be the solution, beca=
use an
OGM have a not negligible prob to be lost. So we should not rely on it.


Thank you for your comments!
I'll try to refine the concept a bit more to address the problem you pointed
out and then I will post an update here :-)

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPrqxtAAoJEFMQTLzJFOZFZVcH+wU64OgHITz7TrfELskokyeU
pMpZB5A7/mWrJppdRoz6nS9MlOb8T0wuxtzucTPvEoMUdifB/7pju8+toX0omIHw
NowWfOCy+9s8HpLlfaXoDUgp91vThnX+Xv7dvIV5i+Xez9l7KxV5JwfE4/UTRqM8
696kGG65Nb+wM4FPkRgQamuyj0n6BIWxRoGAMBlDM6FVs9jRusWTnkR1VEMUn3TC
uwj0WiO/xf+gwb/A1dKcOvxlV1tv9GeXlPt6fn++YrnCtQq/ktMD04rw7qLIN62H
aIzzJRO/av6R+QtLObrfVYiNZ41JnKhqfg/tEWkSLuA7Lf80SYkeubKXmImFj/0=
=fmbd
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
