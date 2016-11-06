Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 6 Nov 2016 18:50:07 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161106175007.GE9484@otheros>
References: <32cfb197-7944-7b9c-0d1c-6f6267d355de@t-online.de>
 <2562442.4W30obIVjL@lafayette>
 <0b99a1f3-aa99-eb62-46cf-f959011a05e6@t-online.de>
 <7866334.t3BPe0EmV2@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7866334.t3BPe0EmV2@sven-edge>
Subject: Re: [B.A.T.M.A.N.] Batman an more than one Gateway
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

On Sat, Nov 05, 2016 at 11:25:38PM +0100, Sven Eckelmann wrote:
> This can be wrong (as explained in my last mail). Gluon only sets the
> no_rebroadcast on the Freifunk router because it doesn't have to handle
> distribution of broadcast to multiple fastd endpoints. It would be
> completely wrong when set on the fastd server (handling multiple clients).
> See my other mail for details.

Just as a small addition, I think I've said it in the ticket, too:
Jean-Jacques, in one point, you're absolutely right:

When there is just one neighbor on an interface, then rebroadcasts
can easily be avoided. Which is the case in your scenario on the
VPN client(!) side.

Gluon has this extra patch for batman-adv, this no_rebroadcast
knob. But an automatic detection which should cover this specific
VPN client case, was merged into upstream batman-adv just a few
days ago \o/ :).


For any case with more than one neighbor on an interface it is
very hard to detect whether upon receiving a broadcast all other
neighbors have received this broadcast too.

If we can't say for sure, then we unfortunately need to stay safe
and rebroadcast to avoid horrible packet loss / broken connections /
armageddon.
