Return-Path: <andrew@lunn.ch>
Date: Tue, 1 Mar 2011 10:13:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110301091328.GD4022@lunn.ch>
References: <AANLkTim+tN9NKUUHJqcaaxS-RpWeLQqrUoB0D+=sA0J7@mail.gmail.com>
	<20110228123720.GG4698@lunn.ch>
	<AANLkTikdyLe01RSdet=Y1bZgjnCAUCcbdvJdXyUDSVw=@mail.gmail.com>
	<20110228144820.GH4698@lunn.ch>
	<AANLkTikH6y62sEUUmW9UuXdY=koyDSk5K9Zmnhd6cp7U@mail.gmail.com>
	<20110301085141.GA24189@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110301085141.GA24189@Sellars>
Subject: Re: [B.A.T.M.A.N.] OGM overhead and routing metric proposal
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

> But I'm actually also a little confused why you, Andrew, came up
> with the hidden node problem :) (which these papers did not try to
> solve, if I'm not missing something). Or do you mean, that this
> idea could be extended maybe be able to solve that hidden node
> problem for OGMs, using the bitrate measuremens to detect / avoid
> switching to bad links?

Hi Linus

If we can extend minstrel so that it also takes transmit power and
load into consideration, we might be able to optimize the coding rate
& TX power for complete mesh bandwidth, not a single link bandwidth.

I would expect there are a number of research papers looking at this,
and many ideas which can be taken from cellular networks. I also think
the commercial mesh products do this. 

However, for Daniele idea of putting the coding rate into the OGM, we
probably need the achievable coding rate, not the current coding rate.
It could be the link is idle, so is using the lowest coding rate and
minimum TX power, just to carrier a few ARP reply packets etc. If
however the link becomes loaded, it would increase the coding rate and
TX power so allowing more packets through.

Daniele's idea is good, but i'm just being careful it does not block
ideas like dynamic coding rate/TX power control.

      Andrew
