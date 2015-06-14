Return-Path: <bjo@nord-west.org>
Message-ID: <1434277200.9779.3.camel@nord-west.org>
From: Bjoern Franke <bjo@nord-west.org>
Date: Sun, 14 Jun 2015 12:20:00 +0200
In-Reply-To: <20150612203356.GB2513@odroid>
References: <1434025163.1056.73.camel@nord-west.org>
 <1912783.F1ndSkPlnl@voltaire> <1434033854.25497.3.camel@nord-west.org>
 <20150612043240.GA27325@odroid> <1434121488.3296.8.camel@nord-west.org>
 <20150612203356.GB2513@odroid>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org, freifunk-ol-dev <freifunk-ol-dev@lists.nord-west.net>

Hi,

> 
> Okay. In Gluon both the batman-adv multicast optimizations and
> bridge multicast snooping are deactivated by default. So I think
> it's probably an issue with the bridge on your gateway. Does
> deactivating the batman-adv and bridge multicast stuff make a
> difference?

Unfortunately not.

> Which kernel version and Linux distribution are you using on the
> gateway?
> > 

3.16.0-4-amd64 / Debian Jessie. In the old setup (with 2013.4) it was
3.2.0-4-amd64 / wheezy

> 
> 
> Measured on bat0 or on the bridge on top?

On the bridge.

> 
> PS: Please keep the mailinglists.

Sorry, I thought it was sent off the list.

Regards
Bjoern

-- 
xmpp bjo@schafweide.org 



