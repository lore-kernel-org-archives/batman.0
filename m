Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 9 Mar 2012 19:26:54 +0800
References: <4F4F6D18.3070403@ninux.org> <20120309085636.GA9018@pandem0nium>
	<20120309111203.GE15059@kerneis.info>
In-Reply-To: <20120309111203.GE15059@kerneis.info>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201203091926.54899.lindner_marek@yahoo.de>
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
To: b.a.t.m.a.n@lists.open-mesh.org, Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>

On Friday, March 09, 2012 19:12:03 Gabriel Kerneis wrote:
> > When we receive OGMs with PRIMARIES_FIRST_HOP flags on different
> > interfaces, we know that it came from the same neighbor, just from
> > different interfaces. We have two links to this neighbor.
>=20
> I think my primary misunderstanding comes from this concept of =E2=80=9Cp=
rimary
> interface=E2=80=9D.  It might be due to my lack of knowledge about Batman=
, but it
> definitely looks like a hack to me: why do you need this symmetry breaking
> in the first place?
>=20
> I believe the rest is only implementation details layered on top of this
> assumption.
>=20
> Maybe there is some explanation that I have overlooked in the wiki?  I ha=
ve
> not found, for instance, how the primary interface is chosen.

The concept of a primary interface goes back into the early days of batman =
and=20
primarily is an optimization to reduce overhead. At some point we realized=
=20
that it is not necessary to flood the mesh with OGMs from each and every=20
interface we have. Nearby nodes might want to know about all interfaces to=
=20
select the best one. Nodes that are far away don't care which interface is=
=20
connected to what other interface. They only care about a route to their=20
destination. This concept is briefly explained here[1] (section 2.1.6 and=20
2.1.7).

What interface is going to be the primary interface does not matter at all.=
=20
=46or the sake of simplicty batman chooses the first interface to be the pr=
imary=20
interface but it could be any interface you prefer. The key point is that o=
nly=20
the primary interface is known in the entire mesh whereas secondary interfa=
ces=20
are known by single hop neighbors only.

Regards,
Marek
=20

[1] http://downloads.open-mesh.org/batman/papers/batman-status.pdf
