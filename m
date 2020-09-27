Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Sun, 27 Sep 2020 21:26:56 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH 2/2] batman-adv: mcast: rename br_ip's u member to dst
Message-ID: <20200927192656.GA2392@otheros>
References: <20200926081220.40779-1-sven@narfation.org>
 <20200926081220.40779-2-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200926081220.40779-2-sven@narfation.org>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>

On Sat, Sep 26, 2020 at 10:12:20AM +0200, Sven Eckelmann wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> Since now we have src in br_ip, u no longer makes sense so rename
> it to dst. No functional changes.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> [sven@narfation.org: Add compat code]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---

Hi Sven,

The version I've just posted [1] should hopefully work without needing
to readd the source code patching infrastructure.

Regards, Linus

[1]: https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20200927191234.22423-1-linus.luessing@c0d3.blue/
