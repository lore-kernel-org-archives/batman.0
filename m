Return-Path: <andrew@lunn.ch>
Date: Mon, 28 Feb 2011 15:48:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110228144820.GH4698@lunn.ch>
References: <AANLkTim+tN9NKUUHJqcaaxS-RpWeLQqrUoB0D+=sA0J7@mail.gmail.com>
	<20110228123720.GG4698@lunn.ch>
	<AANLkTikdyLe01RSdet=Y1bZgjnCAUCcbdvJdXyUDSVw=@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTikdyLe01RSdet=Y1bZgjnCAUCcbdvJdXyUDSVw=@mail.gmail.com>
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

> I'm not a kernel guru but i find out that the new core mac80211 and
> cfg80211 (http://linuxwireless.org/) offers the possibility to obtain
> a per-station bit-rate information that should be driver independent.

O.K. I will take a look at this.

> I have not mentioned the hidden node problem. But I think this problem
> is very difficult to remove, the only best practice to reduce the
> problem is to force the RTS/CTS mechanism to be active.

RTS/CTS helps, true. But it has a few problems. e.g. most meshing
protocols use broadcast packets for there management. e.g. BATMANs
OGMs are broadcast. These cannot be protected with RTS/CTS. So the
OGMs can collide with RTS packets from a hidden node, or OGMs from a
hidden node.

Another way to help reduce the hidden node problem, or interference
with other nodes, is to use a low coding rate and transmit power when
possible. So for example when we don't have much traffic to send to
node X, it could send the packets with the lowest coding rate and low
power. This keeps the interference with other nodes to a minimum. As
the amount of data for X increases, the coding rate and transmit power
can be increased, so increasing the available bandwidth to X, but at
the same time increasing the amount of interference the traffic
produces.

Such a scheme to minimize interference does not play too well with
your idea of putting the coding rate into the OGMs. We would have to
ensure that the coding rate is the highest possible coding rate usable
between two peers, not the currently used coding rate, which could be
low in order to avoid interference.

> > Will you be at the WBMv4 next Month?
> >
> I'm afraid but I cannot be at WMBv4, I hope I can come to the next
> WBM, maybe with a working implementation :)

Shame, i plan to talk more about the hidden node problem during WBMv4.
It is also a good place to discuss new ideas like adding information
into the OGMs.

     Andrew
