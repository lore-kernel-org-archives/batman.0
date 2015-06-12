Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 12 Jun 2015 22:33:57 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20150612203356.GB2513@odroid>
References: <1434025163.1056.73.camel@nord-west.org>
 <1912783.F1ndSkPlnl@voltaire>
 <1434033854.25497.3.camel@nord-west.org>
 <20150612043240.GA27325@odroid>
 <1434121488.3296.8.camel@nord-west.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1434121488.3296.8.camel@nord-west.org>
Subject: Re: [B.A.T.M.A.N.] Mesh hickups with 2014.3
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
To: Bjoern Franke <bjo@nord-west.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, freifunk-ol-dev <freifunk-ol-dev@lists.nord-west.net>

On Fri, Jun 12, 2015 at 05:04:48PM +0200, Bjoern Franke wrote:
> Hi Linus,
> 
> > There's a hash_max value for the bridge
> > (/sys/class/net/<br>/bridge/hash_max). By default it's rather
> > small, just 512 entries / multicast listeners, so it's expected that
> > with 500 nodes the bridge multicast snooping will shut down.
> 
> Thanks for your reply, I increased the value now to 4096 on the
> gateways.
> 
> > Nevertheless, even if the bridge deactivates its multicast
> > snooping that shouldn't cause trouble for ICMPv6.
> > 
> > Which firmware are you using, do you see ICMPv6 packets entering
> > bat0 on the gateway and leaving bat0 on the router?
> 
> We are running gluon 2014.4 on the routers. 

Okay. In Gluon both the batman-adv multicast optimizations and
bridge multicast snooping are deactivated by default. So I think
it's probably an issue with the bridge on your gateway. Does
deactivating the batman-adv and bridge multicast stuff make a
difference?

Which kernel version and Linux distribution are you using on the
gateway?

> 
> I see solicitations and advertisements on the gateway:
> 16:59:54.567582 IP6 fd74:fdaa:9dc4:0:fa1a:67ff:feeb:c77e >
> ff02::1:ff40:1: ICMP6, neighbor solicitation, who has
> fd74:fdaa:9dc4::40:1, length 32
> 16:59:54.567661 IP6 fd74:fdaa:9dc4::40:1 >
> fd74:fdaa:9dc4:0:fa1a:67ff:feeb:c77e: ICMP6, neighbor advertisement,
> tgt is fd74:fdaa:9dc4::40:1, length 32

Measured on bat0 or on the bridge on top?

> 
> Unfortunately it's not possible to access the router at the moment to
> have look what's leaving on bat0 there.
> 
> Regards
> Björn

Cheers, Linus

PS: Please keep the mailinglists.
