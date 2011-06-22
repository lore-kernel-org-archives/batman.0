Return-Path: <andrew@lunn.ch>
Date: Wed, 22 Jun 2011 20:54:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110622185424.GA3824@lunn.ch>
References: <201106211512.34486.sven@narfation.org>
	<20110621200124.GA4137@lunn.ch>
	<201106222003.37215.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201106222003.37215.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] One step back
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

Hi Marek

> Merging all "big" features at once does not seem feasible. We still
> want to be able to deliver something that does not break each and
> every bit at the same time. I also doubt that David would be happy
> with a big blob to be merged at once.

I guess you need to ask David. Does he prefer one big change, which
breaks compatibility once, but has a high risk of being buggy.  Or
does he prefer breaking compatibility for the next X kernel releases
until all the features are merged?

> For the upcoming routing protocol changes I propose the following:
> First we abstract the routing handling and adjust the current
> routing algo to be usable. Then we add a compile time option to
> choose this algo or the older one (afaik the wireless folks do the
> same with their rate control algorithm). The new algo can be marked
> as experimental and be completed step by step.

Im not sure the wireless folks example is valid. I doubt changing the
rate control algorithm changes the "in the air" protocol. Thus i can
mix experimental and well established algos in a wireless net and it
will all happily work.

I think maybe a better example is TCP flow control algorithms. The TCP
messages stay the same, but how fast start, delayed or repeated ACKs,
enlarging the window etc vary. So TCP-vegas, TCP-reno, TCP-new-reno,
are all compatible with each other and can be mixed on the Internet.

Do you think you can have two routing protocols, side by side, using
the same "in the air" protocol and they are compatible with each
other? David's request is that the "in the air" protocol is fixed.
What is behind the protocol can evolve, but the "in the air" messages
have to remain compatible.

     Andrew

