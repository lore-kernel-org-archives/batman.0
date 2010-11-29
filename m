Return-Path: <mvanderkolff@gmail.com>
MIME-Version: 1.0
In-Reply-To: <AANLkTikhncqRxsbRfJRPb0y8oM2uT4sHpQOzONc4hxba@mail.gmail.com>
References: <AANLkTikhncqRxsbRfJRPb0y8oM2uT4sHpQOzONc4hxba@mail.gmail.com>
Date: Tue, 30 Nov 2010 10:25:54 +1100
Message-ID: <AANLkTi=4o6z+KWP6tmet4eCTDHYmLsqzjEkNoUGHMz50@mail.gmail.com>
From: Michael van der Kolff <mvanderkolff@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] global mesh
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

On Tue, Nov 30, 2010 at 3:54 AM, Kosta Grammatis <kosta@iamkosta.org> wrote=
:
> Hi Friends-
> We're working on a rather ambitious initiative to build a
> de-centralized network for the whole of humanity. We're collaborating
> with NASA Ames, Deutsche Telekom, and others. =C2=A0Our latest campaign i=
s
> to buy a satellite: http://buythissatellite.org
>
> All that aside, the work of B.A.T.M.A.N. is incredible, from what I
> read you've tackled some big problems and your technology is being
> implemented in many places (our friends at Village Telco seem to be
> using B.A.T.M.A.N.).
>
> We'd like to build a satellite network that serves as a backhaul to
> local de-centralized mesh networks. =C2=A0Local data transactions can mov=
e
> within the mesh, if data needs to be accessed from further away, they
> switch to the satellite network. An ambitious addition to this idea is
> to allow each device on the mesh to act as a piece of a phase array
> antenna.
>
A phase array antenna requires that each of the pieces of the array
have very low-latency, low jitter communications.  BATMAN is unlikely
to supply that.

BATMAN's approach to routing is not suitable for very large networks
(more than 10^3 routing nodes).  That said, if the backhaul network
setup is stable, you could use BGP between individual BATMAN islands.
If you need a very large network with moving nodes, you may need an
approach like SSR, or other approaches - but they are very much the
subject of research.

> I personally understand how challenging this may be, and my expertise
> is (very) limited. =C2=A0Is this technically possible with technology
> available today? =C2=A0What would you recommend to get this done and what
> can we expect in terms of an end user experience?
> I appreciate your time and expertise. I believe this is the ultimate
> end goal of B.A.T.M.A.N, perhaps we can work on this together.
>
> -Kosta
> --
> http://iamkosta.org
>
