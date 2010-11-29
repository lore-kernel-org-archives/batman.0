Return-Path: <linus.luessing@web.de>
Date: Mon, 29 Nov 2010 21:13:44 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20101129201344.GA5899@Sellars>
References: <mailman.14.1290812292.944.b.a.t.m.a.n@lists.open-mesh.org>
	<AANLkTimR7VU95r3C-=C9rn5ftZahKkNTu3-cU-Vft+VZ@mail.gmail.com>
	<AANLkTikZJn5T7gEc_REH_vyEwhKhTcsqLRdq8tX0OdF8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AANLkTikZJn5T7gEc_REH_vyEwhKhTcsqLRdq8tX0OdF8@mail.gmail.com>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] Fwd: BATMAN routing
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

Hi Hlabishi and welcome!

> As I mentioned above: We are in a redesign phase right now and welcome
> anyone
> interested to join.
Hmm, what would you think about a voip conference for anyone
interested to join :)? I think there are still quite some open
questions about how a BATMAN V algorithm could look like. And I
wanted to discuss some of the recent experiences in mobile
scenarios anyway.

We could try something like mumble for the chatting, I've setup an
experimental server on open-mesh.org on its default port.
I'd suggest something like 6pm UTC. If anyone who's interested to
join can't make it at that time, feel free to suggest
another date then. Anyone who thinks this is fine and would like
to attend, please drop a note :).

Cheers, Linus

PS: Some interesting ideas and questions have been raised so far,
I'm looking forward to interesting answers via email already,
too :).

> module ? All my answers will refer to the kernel module as this is the place
> where most of the development is going on at the moment.
> 
> > On the second approach we want to use mac layer stats to estimate the
> > signal strength and probably the congestion rate of the top N ranked
> links.
> > We acknowledge the fact that usually links with lower signal strength will
> > loose more OGM's which results in an automatic low rank, however in a
> > frequently changing topology, current signal strength is crucial. We plan
> > to use SNR or RSSI in this case.
> 
> The concept is known since a while but nobody has implemented it so far
> because its implementation is fairly complex. Do you have an idea how it
> should work in the end ?
> 
> 
> > 1. How can i get the RSSI/LQI of th neighbor links?
> 
> I don't get this question. You intend to use RSSI but you don't know how ?
> 
> 
> > I would really appreciate your opinions and advices in this regard more
> > specially how to go about implementing changes in BATMAN protocol.
> 
> This is a little abstract. Usually, we discuss specific concepts / ideas in
> our
> IRC channel or on the mailing list long before starting to implement them.
> The
> past has shown it is often better to let other people dive into your ideas
> and
> comment because routing is a rather complex subject.
> 
> scenarios in which the current implementation behaves poorly. All routing
> protocol changes have to go through this collection of scenarios to estimate
> its impact. What do you think about this idea ?
> 
> Regards,
> Marek
> 
