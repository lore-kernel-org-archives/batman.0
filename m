Return-Path: <gabriel@kerneis.info>
Date: Fri, 9 Mar 2012 13:57:41 +0100
From: Gabriel Kerneis <kerneis@pps.jussieu.fr>
Message-ID: <20120309125741.GJ15059@kerneis.info>
References: <4F4F6D18.3070403@ninux.org> <20120309085636.GA9018@pandem0nium>
	<20120309111203.GE15059@kerneis.info>
	<201203091926.54899.lindner_marek@yahoo.de>
	<20120309120455.GF15059@kerneis.info>
	<20120309123905.GB436@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20120309123905.GB436@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [Battlemesh] Battlemesh v5 tests
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
Cc: Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>

Antonio,

On Fri, Mar 09, 2012 at 01:39:06PM +0100, Antonio Quartulli wrote:
> > Does that mean that it is impossible to announce a route on some interf=
aces
> > only?  It looks like a rather arbitrary limitation.
>=20
> OGMs are broadcasted over all the interfaces (there may be some neighs re=
achable
> only by one interface) and you can't force an OGM to be broadcasted only =
over
> one of them. I hope I correctly got your question.

My question is about some kind of policy routing (setup by the administrato=
r,
not guessed by batman).

Consider the following topology:


       l0     l1
    A ---- B =3D=3D=3D=3D C
              l2

where --- is a single link (l0) and =3D=3D=3D are two links (l1 and l2).

Now imagine that the administator wants to dedicate the link l2 to the
communication between B=A0and C, for whatever reason.  It is fairly easy to=
 set
netfilter rules to that effect, for instance.

1) Is it possible for the administrator of B to configure batman so that it
   announces a route to A=A0only over l1, and not l2?  Such that C will onl=
y ever
   send packets for A over l1, and B never replies on l2 either.

2) If that is possible, what is the mechanism in the alternating algorithm =
which
   prevents batman from sending packets from A to C=A0over l2 (assuming TQ1=
 < TQ2)?
   It looks like both l1 and l2 will end up as bonding alternates for C.

Best,
--=20
Gabriel
