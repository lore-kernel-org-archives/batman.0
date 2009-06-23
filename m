Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 24 Jun 2009 04:18:36 +0800
References: <20090623151631.GN19149@ma.tech.ascom.ch>
In-Reply-To: <20090623151631.GN19149@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906240418.37278.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] ring buffer average function...
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


Hi,

> When a neighbor is dead, the ring slowly fills with 0's, whenever
> there is an originator message from one of the other
> neighbors. However since the 0 are ignored when calculating the
> average, we tend to have a cliff effect for dead neighbors. There
> tq_avg stays about the same for quite a while, and then plummets to 0.
> For faster detecting dead neighbors, it would be better if the 0 were
> included in the average. The tv_avg would then drop more linearly, not
> cliff like, so it is likely to cross below another neighbors tv_avg
> earlier, so re-routing around the dead node faster.

this approach will penalize asymetric links. Imagine you have a link which you 
can use for sending very well (no packet loss) but the opposite direction is 
quite weak (receiving looses some packets). You need to receive the batman 
information over that very link to make sure the other side is still alive. 
May be you only get 2 out of 10 via that perfect link and the other 8 via a 
connection that is bad (from your standpoint). If you take the 0 into account 
you will use the bad link instead of the good one.

Regards,
Marek

