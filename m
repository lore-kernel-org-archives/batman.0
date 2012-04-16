Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 16 Apr 2012 12:37:36 +0200
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<20120413055947.GH7664@lunn.ch>
	<CAKLmikPJBmk=Xoom0a1D2OFfx6o8OtSk7D4PdT3TDXDx9iyO1A@mail.gmail.com>
In-Reply-To: <CAKLmikPJBmk=Xoom0a1D2OFfx6o8OtSk7D4PdT3TDXDx9iyO1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201204161237.37008.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Migration to Batman
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

On Monday, April 16, 2012 12:25:42 Mitar wrote:
> I have problems with an idea of running another routing protocol on
> top of Batman. I think this is creates unnecessary additional
> bandwidth consumption:
> 1) routing protocol has to find which nodes are reachable
> 2) routing protocol has to exchange information about announced routes
> 
> But 1) Batman already knows. So we could have a netlink protocol where
> user-land daemon could subscribe to events and get for example two
> events: "node reachable" and "node unreachable". Then it can do some
> user-land mingling. :-)

Batman-adv already has an event reporting system (via sysfs):
http://www.open-mesh.org/wiki/batman-adv/Uevent
It could be easily extended to also throw node events (reachable/unreachable).

Note: Whoever is going to implement that should think about the implications 
of mesh clouds periodically connecting and disconnecting. A lot of events 
could be fired over and over again.


> And for 2), Batman could allow a general key/value additional
> information to be announced by nodes. From its point of view that
> information can be anything.
> 
> And the in our case we could add to each node information which IP it
> has and which subnets it has behind. This information would then be
> announced to other nodes. And then we could run a simple daemon on
> other nodes which would listen to netlink events and once  a node is
> reachable, read that information and setup necessary routes.

There is no need to implement such a thing in batman-adv. You can have this 
feature today by using any broadcast system (avahi, routing daemon, self-
implemented thingy, etc) you like. Here also lies the misunderstanding: You 
don't need to run another routing protocol "on top" of batman-adv. You only 
run it to announce "stuff". You can simply run your routing protocol of choice 
to announce the routes. 
This was explained several times in this thread - maybe it still is not clear?

Cheers,
Marek

