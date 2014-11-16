Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 16 Nov 2014 07:51:23 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20141116065123.GB2469@odroid>
References: <069201cffe76$c6b720c0$54256240$@dslx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <069201cffe76$c6b720c0$54256240$@dslx.net>
Subject: Re: [B.A.T.M.A.N.] Current OpenWrt build
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wed, Nov 12, 2014 at 07:47:10AM -0500, Jay Brussels wrote:
> Antonio,
> 
> I am planning to start programming Ubiquiti and TP-Link Routers in two weeks for a very large BATMAN mesh deployment.
> 
> Although many patches I have seen on this list involves multicast traffic I have seen some others.  
> 
> Is the current OpenWrt release stable enough for deployment or are there some "must have" patches requiring a build from scratch for a successful deployment?

Regarding Barrier-Breaker: The default settings in OpenWRT with
bridges are unfortunately broken (in that breakes multicast, which
means broken IPv6):

https://lists.openwrt.org/pipermail/openwrt-devel/2014-September/027859.html
https://lists.openwrt.org/pipermail/openwrt-devel/2014-September/027876.html

(the first one is my "favourite", a typical OpenWRT feature patch:
awesome idea, good intention, but being applied to the repo without any
peer-reviewing and broken; instead of going through upstream first...)


You'll probably want to disable the multicast-to-unicast feature
or even the bridge snooping as a whole for now.

Cheers, Linus
