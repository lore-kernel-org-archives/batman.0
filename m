Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 5 Jan 2013 01:41:04 +0800
References: <B9683C50-CBE6-40F6-B084-187E41B04CE4@stephan.homeunix.net>
 <201301040839.00852.lindner_marek@yahoo.de> <50E6F17B.1010305@altermundi.net>
In-Reply-To: <50E6F17B.1010305@altermundi.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201301050141.04885.lindner_marek@yahoo.de>
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

On Friday, January 04, 2013 23:12:59 NicoEch=E1niz wrote:
> > Selection class 3 and beyond do change the gateway when a better one
> > becomes available. But as you correctly pointed out these selection
> > classes don't consider the announced bandwidth for the simple reason
> > that nobody cared. In most wireless scenarios (the main playground for
> > batman-adv) the path towards the gateway turned out to be more critical
> > than the gateway's pipe to the internet.
> >=20
> > Feel free to propose something if you care about having this option. The
> > necessary code shouldn't be too hard to add. Backward compatibility will
> > be more difficult to achieve.
>=20
> I believe that those of us who chose to use selection class 1 would
> prefer if it were "dynamic". So if a new gateway appears, then the
> client would evaluate with the same previous criteria if it is better or
> not (considering "the gateway's advertised throughput as well as the
> link quality") and switch accordingly. I see no reason why when someone
> chooses selection class 1 she would be expecting to choose the best
> available gw once and not ever check again.
>=20
> If a network is stable, when a new better gw appears in some area it
> won't be selected until nodes are restarted, and that might be a long tim=
e.

You misread my statement. Nobody needs to be convinced of the usefulness of=
=20
such a feature (at least for what concerns myself). Somebody needs to come =
up=20
with a solid proposal which then needs to be implemented. That is what I me=
ant=20
by saying "Feel free to propose something [..]".

Note that switching immediately as soon as a better gateway comes around is=
n't=20
the best solution. Imagine a case in which a gateway announcing the highest=
=20
bandwidth in your network barely is visible for your gateway client. It wil=
l=20
keep switching between gateways, thereby breaking all your stateful=20
connections such as: ssh, vpns, video & music streams, etc


> One other change that might be interesting would be the addition of a
> setting for how much the advertised throughput affects gw selection.
> I've seen Jan uses 96/96Mbit as advertised throughput on one router; I
> do the same on our "main gateway", but maybe it would be better if we
> could actually advertise the real throughput and have a setting to
> control how much the bandwidth difference affects the selection.

Again, feel free to propose something which can be discussed.

Cheers,
Marek
