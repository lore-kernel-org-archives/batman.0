Return-Path: <mitar@tnode.com>
Message-ID: <4E42FDFF.1040400@tnode.com>
Date: Wed, 10 Aug 2011 23:54:07 +0200
From: Mitar <mitar@tnode.com>
MIME-Version: 1.0
References: <87ipr2mjdv.fsf@trurl.pps.jussieu.fr>	<4E270F72.10900@virtadpt.net>	<7izkk8zsr4.fsf@lanthane.pps.jussieu.fr>	<4E28392B.9020209@virtadpt.net>	<7ibown8v2j.fsf@lanthane.pps.jussieu.fr>	<4E403367.4060701@virtadpt.net>
	<4E411B95.4030203@tnode.com>	<4E416584.2020701@virtadpt.net>
	<4E41A0C6.1010209@tnode.com>	<4E42B411.9050601@virtadpt.net>
	<4E42B779.70905@tnode.com> <4E42C417.7060909@haxwithaxe.net>
In-Reply-To: <4E42C417.7060909@haxwithaxe.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [Babel-users] [Battlemesh] Battlemesh-like
 experiment in Washington, DC
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
To: haxwithaxe <me@haxwithaxe.net>
Cc: b.a.t.m.a.n@open-mesh.net, Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>, babel-users@lists.alioth.debian.org

Hi!

> our use case dictates that the meshes will at some point need to operate
> without being connected to the internet at all so relying on any kind of
> centralized service to configure the nodes isn't always going to work.

This centralized service does not need to be on the Internet? It can
just be one (or more) more powerful nodes in the network itself. Also, I
still believe that the concept is easier to develop centralized
(especially when it is a new concept and you have to try few iterations
to find the right ingredients) and then make it decentralized.

For example, the approach which we will probably take to decentralize
our system will be to have a distributed IP allocation storage over
whole network and a cloning approach to generate firmware images (so you
will just need an existing node of the same hardware and it will
generate a new image firmware just for you from its own firmware
currently running). So the concept of not having a web interface and
making maintenance and operation of the network very easily can still be
made decentralized.

But for 95 % of times when this central service will be available (and
can be deployed very fast again somewhere else if somebody takes one
offline), it will make network operation much much easier for everybody
(and thus also network faster spreading as it will be able to be
operated by non-technical people too, and for technical people, they
will not spend their time going through wizards again and again,
entering some numbers, potentially making mistakes). Again, network is
still decentralized, only for easier deployment we have additional
service in the network. You could still configure nodes yourself without
the system. But you would then face changes of IP collisions and
misconfigurations.

I just want to share our experiences. We have been there. We had web
interface on the routers. And we learned that this is maybe good for DIY
networks and geeks, but not if you want that common people deploy your
network. And at the end of the day, it counts how many nodes you have
deployed. Because this makes the network more resilient.

So we created an approach where you have plug & mesh. And everything
else is automatic. So people just have to share an idea, buy a router,
register it, plug it in and this is almost it.

Of course this approach is not best for all cases. But I would just like
to present it, so that maybe you can think about it and see if it fits
into your picture.

> also we are using x86 machines (laptops/desktops) for our nodes so we
> need to allow for tweaking given the diversity of the hardware byzantium
> will be on.

We also allow tweaking. You made all your changes in the OpenWrt
packages (currently we support only OpenWrt build chain, but we will
soon lift this limitation) and then it is always added to your firmware
image when generated.

Even more. Once this is in a package, somebody else can also use this
package for their own router. So instead that everybody tries same
things again and again, only one person has to do it, package it, and
everybody can use it.

> in addition the lack of centralized configuration mechanism prevents an
> a hostile party from spoofing control instructions and shutting down the
> network by scrambling the configs in the event byzantium is deployed in
> an environment where it may not be welcome by authorities, or if it's
> deployed in the proximity of skiddies who think it'd be funny to kill a
> community's link to each other and the internet.

Again, centralized system for monitoring and deployment does not mean
that taking over this system can make network less stable/useless. It
just means that you have to deploy the service somewhere else again (and
this again just one person has to know how to do and again everybody can
enjoy) or that you switch to secondary means of deployment (like cloning
routers).

BTW, it is much easier for anybody currently to throw any of our mesh
networks offline: you just need to put garbage and stupid routes in our
routing daemons. Zero route everything or something. This is much more
realistic scenario for me. Having a service which draws nice graphs and
maps put down is also possible. But to put the network down you will
just have to poison routing daemons.

Or just scramble the 2.4 GHz spectrum. If I would be government, I would
just broadcast sawtooth signal over whole 2.4 GHz spectrum at 100 kW.
Simple and effective.

So then we get back to the basic: more nodes, better the resilience,
harder to poison, harder to quiet. How to get more nodes? By very easy
deployment at the time of peace and possible deployment at the time of
war. And with many nodes it is hard to get all of them offline.

I believe the approach is in masses. It must be so easy to deploy that
even in the time of peace people will want and do deploy those nodes.
And not just heavily motivated geeks, but also normal population. Just
because of the fun of it, because it is something for a greater good.
And already have many of them in the time of peace. Because it is a bit
too late to start deploying them when there are problems already on the
horizon. Simply the problem of time. (Especially if you have to click
each time again on the web interface things.)

> also we are using ahcpd so withing the mesh it's not entirely random
> what ip one gets.

But who decides which subnet a node gets to give forward? Or which IP
does a node have?


Mitar
