Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 4 Jan 2013 08:39:00 +0800
References: <B9683C50-CBE6-40F6-B084-187E41B04CE4@stephan.homeunix.net>
 <201301032314.22606.lindner_marek@yahoo.de> <50E61CF9.2050305@altermundi.net>
In-Reply-To: <50E61CF9.2050305@altermundi.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201301040839.00852.lindner_marek@yahoo.de>
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

On Friday, January 04, 2013 08:06:17 NicoEch=E1niz wrote:
> > You did mention you were using selection class 1. I was referring to yo=
ur
> > test in which you turn on/off your best gateway. As I explained in my
> > previous mail: batman-adv does not switch the gateway once it has chosen
> > a gateway unless you select fast or late switching as selection class.
> > Selection class 1 does not fall into this category which means a gateway
> > reselection only happens if the currently selected gateway disappears.
>=20
> Marek, could you please clarify this?
>=20
> From the man page I don't see an option that would behave as Jan (and I)
> seem to be expecting it to work. That is: switch to a better gateway -
> with more bandwidth and comparable link quality - when it's available.
>=20
> [..]
>=20
> Would mode 3 accomplish this fast switching? It doesn't mention if this
> mode will consider advertised throughput or not; only selection class 1
> mentions throughput.

Selection class 3 and beyond do change the gateway when a better one become=
s=20
available. But as you correctly pointed out these selection classes don't=20
consider the announced bandwidth for the simple reason that nobody cared. I=
n=20
most wireless scenarios (the main playground for batman-adv) the path towar=
ds=20
the gateway turned out to be more critical than the gateway's pipe to the=20
internet.

=46eel free to propose something if you care about having this option. The=
=20
necessary code shouldn't be too hard to add. Backward compatibility will be=
=20
more difficult to achieve.

By the way, I posted a patch to improve the man page explanation a couple o=
f=20
hours ago.

Cheers,
Marek
