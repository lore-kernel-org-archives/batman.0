Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Tue, 31 May 2022 14:54:12 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [RFC PATCH v3 1/1] mac80211: use AQL airtime for expected
 throughput.
Message-ID: <YpYP9NBD+Wmzup+s@sellars>
References: <20220531100922.491344-1-gasmibal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220531100922.491344-1-gasmibal@gmail.com>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Baligh Gasmi <gasmibal@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "open list:MAC80211" <linux-wireless@vger.kernel.org>, "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, b.a.t.m.a.n@lists.open-mesh.org

On Tue, May 31, 2022 at 12:09:22PM +0200, Baligh Gasmi wrote:
> Since the integration of AQL, packet TX airtime estimation is
> calculated and counted to be used for the dequeue limit.
> 
> Use this estimated airtime to compute expected throughput for
> each station.
> 
> It will be a generic mac80211 implementation. If the driver has
> get_expected_throughput implementation, it will be used instead.
> 
> Useful for L2 routing protocols, like B.A.T.M.A.N.
> 
> Signed-off-by: Baligh Gasmi <gasmibal@gmail.com>

Hi Baligh,

Thanks for your work, this indeed sounds very relevant for
batman-adv. Do you have some test results on how this compares to
real throughput? And maybe how it compares to other methods we
already have in the kernel, like expected throughput via
minstrel_ht rate control or the estimates performed in 802.11s
HWMP [0]?

Is there a certain minimum amount of traffic you'd suggest to have
enough samples to get a meaningful result?

I'm also wondering if we are starting to accumulate too many
places to provide wifi expected throughput calculations. Do you
see a chance that this generic mac80211 implementation could be made
good enough to be used as the sole source for both batman-adv and
802.11s HWMP, for instance? Or do you see some pros and cons
between the different methods?

Regards, Linus


[0]: https://elixir.bootlin.com/linux/v5.18/source/net/mac80211/mesh_hwmp.c#L295
