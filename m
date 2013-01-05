Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 5 Jan 2013 12:42:29 +0800
References: <B9683C50-CBE6-40F6-B084-187E41B04CE4@stephan.homeunix.net>
 <201301050141.04885.lindner_marek@yahoo.de> <50E76594.5010903@altermundi.net>
In-Reply-To: <50E76594.5010903@altermundi.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201301051242.30188.lindner_marek@yahoo.de>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Saturday, January 05, 2013 07:28:20 NicoEch=E1niz wrote:
> >> One other change that might be interesting would be the addition of a
> >> setting for how much the advertised throughput affects gw selection.
> >> I've seen Jan uses 96/96Mbit as advertised throughput on one router; I
> >> do the same on our "main gateway", but maybe it would be better if we
> >> could actually advertise the real throughput and have a setting to
> >> control how much the bandwidth difference affects the selection.
> >=20
> > Again, feel free to propose something which can be discussed.
>=20
> It could just be implemented as a new setting like: gw_bw_weight
>=20
> which would regulate how much gw bandwidth/throughput affects best gw
> calculation.
>=20
> I don't know what's the current algorithm but I guess there would be no
> problem with backwards compatibility here; if the value is not set, the
> default should produce the same result we get now.
>
> [..]
>=20
> I like this better than gateway classes that Jan proposed, as it is less
> implementation specific.

How about you and Jan discuss the matter to come up with a combined proposa=
l=20
which solves both your problems ?


> PS: Marek, there are mismatched parenthesis in the new man page text in
> this paragraph:

The parenthesis is ok but groff has problems compiling that section. I re-
posted a cleaned up version of Pau's proposed fix. In the future don't=20
hesitate to post a patch for such trivial things otherwise you will have to=
=20
wait until somebody comes around and does the work for you.

Cheers,
Marek

