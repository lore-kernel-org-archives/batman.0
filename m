Return-Path: <linus.luessing@web.de>
Date: Wed, 5 Jan 2011 11:57:47 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110105105747.GA6723@Sellars>
References: <E056F038D9D24718AF5E3AFDC7E7BAEE@granch.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E056F038D9D24718AF5E3AFDC7E7BAEE@granch.local>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] Mesh network topology problem
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

Hi Michael,

Welcome to the BATMAN mailing list :). Let me ask some general
questions first about what you're trying to achieve. So you are
trying to set up a highly fault tolearant network. Does the
fault tolerant setup have any time limitations, how quickly do you
need to detect outageous and switch? So far it looks like you're
having just a wlan0 interface inside of batman-adv, right?
So you usually want to use the wired links but use the wireless mesh
network as a backup?
Could you explain the picture you've attached a little further. I
guess (1) - (8) and (11) - (18) are nodes which are running
batman-adv, what are (CCbs0/1)? Do blue lines represent the wired
links attached to a switch (so 4 switches involved?) and a thin black
line the wifi-links? What is a thick black line, what do the numbers represent?

On Mon, Jan 03, 2011 at 03:24:45PM +0600, Michael Y. Gluhovchenko wrote:
> Hello All;
> 
> I have a problem organizing mesh, each wireless router has a Wifi
> link and 2 wired links. The problem is that there is the parallel
> corridor  with the same infrastructure. Routers can see each other
> across the corridor, the signal quality in the corridor is better
> than the main line.
> I want to use Linux bridge + stp interfaces bat0, eth0, eth1 wired
> links have advantages. When break wire links or failure one of the
> routers need to maintain communication through the mesh. Is it
> possible to configure mesh so that the link in another corridor with
> the best quality work in the last turn?
Are you talking about a wireless link here? Which link are you
refering to here exactly?
> What problems can occur for
> that network topology.
Well, if done wrong, bridge-loops ;). I think with stp and
bridging the wifi-mesh and wired network would be one possible
solution, but there are at least two more ways to go. It would be
great if you could explain the physical network topology a little
more with the help of the picture so that we'd be able to better
decide which of those solutions might be most suitable for you.
> 
> With best regards,
> Michael;

Cheers, Linus

PS: Also note, that STP over batman-adv will create quite some
overhead, depending on the number of nodes you are running.
batman-adv will flood each STP packet through the whole
wireless mesh.
