Return-Path: <andrew@lunn.ch>
Date: Thu, 27 May 2010 17:42:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100527154236.GA26610@lunn.ch>
References: <20100527162350.75bef379@rechenknecht>
	<20100527150700.GA29869@lunn.ch>
	<201005272330.15388.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201005272330.15388.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Layer 2 fragmentation
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

On Thu, May 27, 2010 at 11:30:15PM +0800, Marek Lindner wrote:
> On Thursday 27 May 2010 23:07:00 Andrew Lunn wrote:
> > I don't quite understand the problem. If you have implemented
> > fragmentation, you will naturally increase the MTU on bat0 so that it
> > is the standard for Ethernet. So this statement will not trigger.
> 
> AFAIK batman-adv determines the minimal MTU automatically, so that you can't 
> simply increase the mtu on bat0. But you are right - if the fragmentation is 
> enabled batman-adv could allow higher mtu values.

We discussed this a while ago. Actually fragmentation should be
considered the last resort. It if first better to try header
compression, to make the frame small enough that it can be sent
without fragmentation. I think you had a quick look at using the PPP
compression code, but i guess it did not go any further.

We only need to fragment when compression is not possible. 

In either case, we should remove the automatic MTU calculation, and
just offer the default for Ethernet. Let the compression and
fragmentation code solve any differences.

	      Andrew
