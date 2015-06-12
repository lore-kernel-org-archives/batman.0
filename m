Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 12 Jun 2015 06:32:41 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20150612043240.GA27325@odroid>
References: <1434025163.1056.73.camel@nord-west.org>
 <1912783.F1ndSkPlnl@voltaire>
 <1434033854.25497.3.camel@nord-west.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1434033854.25497.3.camel@nord-west.org>
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

On Thu, Jun 11, 2015 at 04:44:14PM +0200, Bjoern Franke wrote:
> Hi Marek,
> 
> 
> > Do you have the multicast optimizations enabled ? 2014.3.0 still has 
> > a known 
> > bug causing these optimizations to harm multicast traffic. Either 
> > disable this 
> > feature or upgrade to something newer than 2014.3.0.
> > 
> 
> IThanks for your reply. Multicast optimizations are disabled, but we ha
> ve multicast related errors in the logs:
> br-mesh: Multicast hash table chain limit reached: bat0br-mesh: Cannot rehash multicast hash table, disabling snooping: bat0, 201, -22
> Regardsbjo

There's a hash_max value for the bridge
(/sys/class/net/<br>/bridge/hash_max). By default it's rather
small, just 512 entries / multicast listeners, so it's expected that
with 500 nodes the bridge multicast snooping will shut down.

Nevertheless, even if the bridge deactivates its multicast
snooping that shouldn't cause trouble for ICMPv6.

Which firmware are you using, do you see ICMPv6 packets entering
bat0 on the gateway and leaving bat0 on the router?

Cheers, Linus
