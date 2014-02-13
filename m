Return-Path: <andrew@lunn.ch>
Date: Thu, 13 Feb 2014 10:55:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140213095527.GC7193@lunn.ch>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-16-git-send-email-antonio@meshcoding.com>
 <20140212091215.GI30814@lunn.ch> <52FB6525.7090001@open-mesh.com>
 <52FB6F04.3000404@openwrt.org> <52FB6F75.6070802@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52FB6F75.6070802@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 15/23] batman-adv: ELP - send unicast ELP
 packets for throughput sampling
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: Felix Fietkau <nbd@openwrt.org>, b.a.t.m.a.n@lists.open-mesh.org

> > Right. If I remember correctly, if you send less than 1 packet per 100
> > ms, then all packets should end up being probing packets. If that
> > doesn't work, we can change minstrel's probing pattern to allow things
> > like batman to get a desirable amount of rate control probing simply by
> > sending unicast packets.
> 
> This is what I am trying to achieve here: if no unicast packets have
> been sent for the last 100ms (at least) then send N probing packets in a
> row (with N = 2 at the moment - it is a define in main.h).

Hi Antonio

One minor thing to consider is that your statement is actually:

if no _batman_ unicast packets have been sent for the last 100ms ...

I've used batman in setups where it has not been the exclusive user of
the hard interface. So there could be other traffic which is keeping
the RC algorithm up to date. So maybe it would be better to use the
hard interface statistic counters rather than last time batman sent a
packet?

	Andrew
