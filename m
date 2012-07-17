Return-Path: <mmitar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201207171257.23627.lindner_marek@yahoo.de>
References: <CAKLmikNDZQL2bDWYMMUHcHA5WTMj2Ou0yFiZ7wg134OHFQZWrw@mail.gmail.com>
 <201207161202.45306.lindner_marek@yahoo.de>
 <CAKLmikOuvdvdzV+UD-qr=FSKA0s+1yMHcdYr4GU6S4VzvqcMcw@mail.gmail.com>
 <201207171257.23627.lindner_marek@yahoo.de>
Date: Tue, 17 Jul 2012 11:06:27 -0700
Message-ID: <CAKLmikPKq3Ys8L=wtc08-GBeX04huu85OYJR17MByqOBGbi6sw@mail.gmail.com>
From: Mitar <mmitar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Route selection over VPN links
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

Hi!

On Tue, Jul 17, 2012 at 3:57 AM, Marek Lindner <lindner_marek@yahoo.de> wrote:
> I was more curious about the bandwidth routing than the latency stuff. The
> current routing algorithm already takes latency into account. An alternate
> path always need to be better than the current path. If both paths are equal
> the faster packets win the race.

Hm. This happens only first time, it does not really change the route
latter on, if chosen path latency increases and becomes worse than the
second path, but packet loss stays the same (zero). Or it does?

For bandwidth, I would say that we first need multipath routing. And
then route on all possible paths some percentage of packets, based on
given capacity ratio. So if you have three paths A, B, and C with same
packet loss and capacity Ca, Cb, and Cc, you route over A with Ca/(Ca
+ Cb + Cc) ratio.

The other way would be to route based on free capacity, but this means
you would also have to know how much capacity is already taken for the
given path. This is probably hard. But for given interface maybe not
so much.

So for wall links we probably cannot know capacity. (This is
especially true for WiFi.) But for some links we can know (VPN links,
especially where people can set caplimit how much of their link they
want to donate to the network). So probably this information (link cap
and free capability) should be transmitted to all neighbors. And for
those links where you have this additional information, I would route
like:

- if packet loss on a path is different for some epsilon, route based on that
- if latency on a path is different for some epsilon, route based on that
- otherwise route based on the largest free capacity for some epsilon
available for the next hop (or preferably even path)

This would do correct thing for the case of VPN links, where most of
links will have almost zero packet loss, latency will be or small (for
local VPN servers) or big (for foreign VPN servers), and then based on
free capacity we would route on that.

So there should be some hysteresis and some "epsilon equality" so that
we do not flap the links all the time.

One more thing, we have currently one gateway server and multiple VPN
servers connecting to it. So most of the time traffic flows from or to
this gateway server from VPN servers. So if we transmit around
information about capacity on links, this would be a case where nodes
connected to multiple VPN servers could decide not just on next hop
capacity link, but also on the link to gateway. And so not just
congest the VPN server, because the link to it is free, but that also
link from it to gateway server should be free.

The above logic tells me, that routing plugins could be stacked. So
that you could have a stack of routing decisions where each of plugins
in the stack, in order, over which paths the packet should be routed.
It simply returns a list of those with some ratio/vote on each path.
Or simply remove some out of the list if it determines it is really
bad. For example, for above logic, for paths A, B and C:

- packet loss would return [A:0.33, B:0.33, C:0.33] because there is
no significant packet loss
- latency would return the same
- free capacity would return [A:(Ca/(Ca + Cb + Cc)), ...]

And at the end, for now, Batman could choose the best one route. Later
on with multipath routing, it could use this information to choose for
example n best.

Just some ideas ...


Mitar
