Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 24 Apr 2014 11:48:19 +0200
References: <5358CCA4.2050203@wirelesspt.net>
In-Reply-To: <5358CCA4.2050203@wirelesspt.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201404241148.19217.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] Batman-adv high TQ and Low throughput
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
To: b.a.t.m.a.n@lists.open-mesh.org, cmsv@wirelesspt.net
Cc: openwrt-users <openwrt-users@lists.openwrt.org>, Battlemesh Ninux <battlemesh@ml.ninux.org>

> Recently i have experienced something quite usual to my experience and
> that was not happening previously in the same scenario where it is
> happening now.
> 
> Here is the example:
> 2 nodes at with adhoc at 2.4ghz at a distance of 415 meters
> one uses an omni 15 dbi antenna at 18dbi and another 24 dbi grid at 16 dbi.
> 
> This link was previously providing up to 21 mbit being 17 mbit a the
> lowest. Batman-adv TQ value was always around 230 being many times above
> 250.
> 
> However this has recently changed the same link with 230~250 TQ and the
> same txpower is now outputting 1.93 Mbits/sec
> 
> I have used iperf for bandwidth tests. Batman-adv version is 2013.4.
> Although i have considered several types of scenarios that can be
> causing this issue i have also tested against some which leaves me
> puzzled in regards to the presented TQ quality and dBm values as the
> nodes dBm are sometimes bad (ie: -80 ~ -90)
> 
> One of the main questions is: shouldn't batman-adv TQ reflect or be
> influenced by dBm values ? How come with -90 dBm i get batman-adv to
> show me 230 TQ ?

The current implementation in batman-adv counts broadcast packets to compute 
the TQ. Therefore this number reflects (more or less) the transmit success 
probability on whatever wifi broadcast modulation rate you have configured 
(default the lowest, e.g. 1M in 2.4 GHz). A common tweak is to set the 
broadcast rate (also called multicast rate) to something higher, e.g. 18M or 
36M, to get a better analysis on these modulation rates. This should also help 
in your scenario, but might affect the range of your batman-adv network.

Cheers,
    Simon
