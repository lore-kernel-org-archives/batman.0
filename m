Return-Path: <linus.luessing@web.de>
Date: Wed, 12 Mar 2014 00:03:00 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140311230300.GP5090@Linus-Debian>
References: <1394526073.90768.YahooMailNeo@web142501.mail.bf1.yahoo.com>
 <1394540404.89540.YahooMailNeo@web142502.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1394540404.89540.YahooMailNeo@web142502.mail.bf1.yahoo.com>
Subject: Re: [B.A.T.M.A.N.] batman over wireless bridges
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
To: Tom Sparks <tom_a_sparks@yahoo.com.au>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Tom,

We are currently using batman-adv over Ubiquiti Nanobridges M5 for
Freifunk. That works just fine, these devices are able to
transparently forward the batman-adv ethernet frames.

Cheers, Linus


On Tue, Mar 11, 2014 at 05:20:04AM -0700, Tom Sparks wrote:
> 
> 
> I am wondering how well batman works over wireless bridges
> like this:
> 
> batR <--> wifiB <--> wifiB <--> batR
> 
> 
> meanings:
> BatR: openwrt router with batman installed
> wifiB: wifi bridge
> 
> 
> 
> ---
> tom_a_sparks "It's a nerdy thing I like to do"
> 
