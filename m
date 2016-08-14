Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 14 Aug 2016 19:21:28 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160814172128.GD8599@otheros>
References: <1470928381.10121.0.camel@gmail.com>
 <20160811154723.GJ4483@otheros>
 <1470931774.10121.10.camel@gmail.com>
 <20160811163153.GK4483@otheros>
 <1470988256.16102.4.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1470988256.16102.4.camel@gmail.com>
Subject: Re: [B.A.T.M.A.N.] is the multicast performance throttled?
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

On Fri, Aug 12, 2016 at 09:50:56AM +0200, Ignacio Quezada wrote:
> > UDP has no flow control. That's why I was asking about the bitrate
> > you have configured in the application. Sending with "as fast as
> > possible" will basically jam your (and your neighbors) wifi. And
> > will create trouble for batman-adv to find usable routes too
> > without any airtime available.
> > 
> > Regards, Linus
> 
> What I don't understand is that you are explaining standard behavior of
> WiFi networks, but using plain WiFi without batman works ok and the
> multicast goes up to 100kb/s (I think I wrote that in my first email). 
> The tests have been like this so far:
> - wlan0 (no batman),  multicast: 100kb/s
> - wlan0 (no batman),  unicast: 100kb/s
> - bat0,  unicast: 100kb/s
> - bat0,  multicast: 20kb/s

Yes, read your first email and that's the oddity I'm trying to
figure out :-).

Let me try to rephrase. One guess I'm having (which might be
wrong), that the multicast traffic on bat0 is interfering with the
control packets ("Originator Messages" in batman speak). And that
this breaks even one-hop routes. Hm, ok, on the other hand, even
with no routes, flooded multicast would "work" because it doesn't
use the routes discovered by OGMs. Next guess. (although the
output of the originator table, "batctl o", before and during your
application transmitting would be interesting to check whether
there is an effect/interference)


Second guess (which is probably it :-) ): In general, batman-adv
(re)broadcasts a multicast packet three times on an interface. To
ensure proper reception even over multiple hops.

That might even add up with your numbers: Initial sender
broadcasts three times, neighbor rebroadcasts three times, so
6*16kb/s ~ 100kb/s. 100kb/s => 0.800Mbit/s, which is already
oversaturating the gross 1MBit/s wifi multicast rate (@1MBit/s gross
it's usually more like 0.5MBit/s net at least for unicast,
multicast might be something between 1MBit/s and 0.5MBit/s net).

> 
> 
> PS: Emails from the Gmail Android App get rejected by the mailinglist,
> I guess it is because of the HTML format? I wasn't able to disable it,
> back at the desktop.

Yes, this mailinglist rejects HTML mail. To cope with spam,
I think.

Regards, Linus
