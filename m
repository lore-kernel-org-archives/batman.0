Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 8 Jan 2013 14:15:30 +0800
References: <B9683C50-CBE6-40F6-B084-187E41B04CE4@stephan.homeunix.net>
 <4FD8BE79-700F-402E-AC8B-ACA10D6DD61C@stephan.homeunix.net>
 <EDAD8912-487A-4B02-842B-675C214E02D6@stephan.homeunix.net>
In-Reply-To: <EDAD8912-487A-4B02-842B-675C214E02D6@stephan.homeunix.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201301081415.31205.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Unterstanding gateway-mode - why do nodes have a
	"sticky" gateway
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, =?iso-8859-1?q?NicoEch=E1niz?= <nicoechaniz@altermundi.net>, Jan =?iso-8859-1?q?L=FChr?= <ff@stephan.homeunix.net>

On Monday, January 07, 2013 23:26:10 Jan L=FChr wrote:
> Ok, I make one - for Link-Usability (or attractiveness, or whatever you
> like)  LU, Gateway-Class GC and TQ: LU =3D (1 - gw_bw_weight) *
> TQ  +  gw_bw_weight * GC
>=20
> gw_tq_threshold should then be renamed to gw_lu_threshold.
>=20
> However, that implies, that TQ and GC should are linear in LU and that mi=
n(
> TQ ) =3D min ( GC ) as well as max ( TQ ) =3D max( GC ). I'll be fine wit=
h the
> assuming that TQ and GC should be linear in LU - GC can be scaled such
> that the min / max condition holds LU =3D (1 - gw_bw_weight) *
> TQ  +  gw_bw_weight * ( c1 * GC + c2)
> (for contants c1, c2)=20
>=20
> @Marek, Nico : What Do you think?

May I propose that we schedule an IRC discussion for this topic ? I lost tr=
ack=20
of what you are actually trying to achieve and I see things getting more an=
d=20
more complicated.=20
Whatever idea you come up with keep in mind that somebody has to do the=20
following before this solution can be merged:

 * batman-adv code has to be written, tested & debugged
 * batman-adv kernel doc has to be written
 * batctl code has to be written, tested & debugged
 * man page has to be updated
 * user documentation for $your_new_mechanism has to be written

Unless you manage to convince somebody else to do the work for you that=20
somebody who has to do all work will be you. In other words: It is in your=
=20
best interest to keep things as simple as possible.  :-)

Cheers,
Marek
