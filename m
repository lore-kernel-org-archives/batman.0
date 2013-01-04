Return-Path: <nicoechaniz@altermundi.net>
Message-ID: <50E6F17B.1010305@altermundi.net>
Date: Fri, 04 Jan 2013 12:12:59 -0300
From: =?ISO-8859-1?Q?NicoEch=E1niz?= <nicoechaniz@altermundi.net>
MIME-Version: 1.0
References: <B9683C50-CBE6-40F6-B084-187E41B04CE4@stephan.homeunix.net>
 <201301032314.22606.lindner_marek@yahoo.de> <50E61CF9.2050305@altermundi.net>
 <201301040839.00852.lindner_marek@yahoo.de>
In-Reply-To: <201301040839.00852.lindner_marek@yahoo.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

On 01/03/2013 09:39 PM, Marek Lindner wrote:
> On Friday, January 04, 2013 08:06:17 NicoEch=E1niz wrote:

>> Would mode 3 accomplish this fast switching? It doesn't mention if this
>> mode will consider advertised throughput or not; only selection class 1
>> mentions throughput.
>=20
> Selection class 3 and beyond do change the gateway when a better one beco=
mes=20
> available. But as you correctly pointed out these selection classes don't=
=20
> consider the announced bandwidth for the simple reason that nobody cared.=
 In=20
> most wireless scenarios (the main playground for batman-adv) the path tow=
ards=20
> the gateway turned out to be more critical than the gateway's pipe to the=
=20
> internet.
>=20
> Feel free to propose something if you care about having this option. The =

> necessary code shouldn't be too hard to add. Backward compatibility will =
be=20
> more difficult to achieve.

I believe that those of us who chose to use selection class 1 would
prefer if it were "dynamic". So if a new gateway appears, then the
client would evaluate with the same previous criteria if it is better or
not (considering "the gateway's advertised throughput as well as the
link quality") and switch accordingly. I see no reason why when someone
chooses selection class 1 she would be expecting to choose the best
available gw once and not ever check again.

If a network is stable, when a new better gw appears in some area it
won't be selected until nodes are restarted, and that might be a long time.

In my town, where partial energy outages are frequent, I've had to
manually switch off gw_mode and play around with this from time to time
because clients would be stuck with the wrong gw after an energy
shortage in the main gw.

One other change that might be interesting would be the addition of a
setting for how much the advertised throughput affects gw selection.
I've seen Jan uses 96/96Mbit as advertised throughput on one router; I
do the same on our "main gateway", but maybe it would be better if we
could actually advertise the real throughput and have a setting to
control how much the bandwidth difference affects the selection.


> By the way, I posted a patch to improve the man page explanation a couple=
 of=20
> hours ago.

good, it reads better now :)

Cheers,
NicoEch=E1niz



