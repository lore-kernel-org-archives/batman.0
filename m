Return-Path: <dicht@operamail.com>
Message-Id: <1398340673.9414.109890229.7C3D1C45@webmail.messagingengine.com>
From: Thijs van Veen <dicht@operamail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Date: Thu, 24 Apr 2014 13:57:53 +0200
In-Reply-To: <201404241148.19217.sw@simonwunderlich.de>
References: <5358CCA4.2050203@wirelesspt.net>
 <201404241148.19217.sw@simonwunderlich.de>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, cmsv@wirelesspt.net
Cc: openwrt-users <openwrt-users@lists.openwrt.org>, Battlemesh Ninux <battlemesh@ml.ninux.org>

Hi,

I would like to add some additional insights I gained while working on
my bachelor thesis (which of course used batman :D ).

The dBm you see is the power at which packets are received (Prx).
The value of Prx depends on a lot of factors, primarily distance and
interferrence caused by re/deflections [1]. 
There is a minimum Prx at which the signal must arrive in order for your
Wi-Fi module to be able to see it as a proper signal rather than noise. 
This minimum, combined with (thermal) noise (N) gives you a
signal-to-noise ratio, which should at least be about 15 dB (SNR = Prx -
N >= 15).
N is usually somewhere around -100 dBm, meaning that a Prx of about -85
dBm is generally the minimum you need for succesful transmissions.
Note that these numbers don't take into account any antennae you might
be using, these are only really relevant for calculating the Prx.
A higher number means the signal is clearer, but that's really all it
means.
Because the Prx can only be determined if a packet arrives, the number
in itself is meaningless without a time reference, which in turn would
only indicate when the last packet was received.

Like Simon said, the transmission quality batman-adv returns is based on
the probability of packets arriving properly on the other side of the
Wi-Fi link.
Batman-adv uses counters to determine how many packets were lost and as
a result gives a more informative view of how well the link behaves.
Because the counters are based on packet reception, this means the Prx
also has to be above the minimum.

In summary: 
high dBm = the things that are received, are received very clearly
high TQ = nearly everything you send is received.
High chance of proper reception => less retransmissions => higher
throughput => happy you.

[1]: http://en.wikipedia.org/wiki/Path_loss

-- 
  Thijs van Veen
  dicht@operamail.com


On Thu, Apr 24, 2014, at 11:48, Simon Wunderlich wrote:
> > Recently i have experienced something quite usual to my experience and
> > that was not happening previously in the same scenario where it is
> > happening now.
> > 
> > Here is the example:
> > 2 nodes at with adhoc at 2.4ghz at a distance of 415 meters
> > one uses an omni 15 dbi antenna at 18dbi and another 24 dbi grid at 16 dbi.
> > 
> > This link was previously providing up to 21 mbit being 17 mbit a the
> > lowest. Batman-adv TQ value was always around 230 being many times above
> > 250.
> > 
> > However this has recently changed the same link with 230~250 TQ and the
> > same txpower is now outputting 1.93 Mbits/sec
> > 
> > I have used iperf for bandwidth tests. Batman-adv version is 2013.4.
> > Although i have considered several types of scenarios that can be
> > causing this issue i have also tested against some which leaves me
> > puzzled in regards to the presented TQ quality and dBm values as the
> > nodes dBm are sometimes bad (ie: -80 ~ -90)
> > 
> > One of the main questions is: shouldn't batman-adv TQ reflect or be
> > influenced by dBm values ? How come with -90 dBm i get batman-adv to
> > show me 230 TQ ?
> 
> The current implementation in batman-adv counts broadcast packets to
> compute 
> the TQ. Therefore this number reflects (more or less) the transmit
> success 
> probability on whatever wifi broadcast modulation rate you have
> configured 
> (default the lowest, e.g. 1M in 2.4 GHz). A common tweak is to set the 
> broadcast rate (also called multicast rate) to something higher, e.g. 18M
> or 
> 36M, to get a better analysis on these modulation rates. This should also
> help 
> in your scenario, but might affect the range of your batman-adv network.
> 
> Cheers,
>     Simon

-- 
http://www.fastmail.fm - Choose from over 50 domains or use your own

