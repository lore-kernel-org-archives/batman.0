Return-Path: <andrew.lunn@ascom.ch>
Date: Wed, 24 Jun 2009 10:28:45 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090624082845.GS19149@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [B.A.T.M.A.N.] originator tq_avg oscilations
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: B.A.T.M.A.N@lists.open-mesh.net

> If you are willing to test a few things to reduce the effect we can
> start right away. You could set TQ_GLOBAL_WINDOW_SIZE to 1 in order
> to deactivate the averaging of the TQ values. Aslo, some people
> reported that reducing the hop penalty also will increase the speed.

I already tried changing TQ_GLOBAL_WINDOW_SIZE to 5 instead of 10 and
that helped. Changing it to one is interesting. I've not tried it yet,
but i would of thought some ring buffer was needed to handle the 0s
which are added when originator messages are received for other
neighbors. 

I already tried reducing the hop penalty. However testing showed it
behaved worse. This i don't understand. So i'm guessing my test setup
changed between my different tests. So i need to run the test again,
both the control and the modified hop penalty.

What ideas do you have for improving the algorithms. Depending on the
scale of work needed i might have some time to do some coding.

     Andrew
