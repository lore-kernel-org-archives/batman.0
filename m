Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Tue, 22 Sep 2020 19:51:19 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH net-next v2 06/16] net: bridge: mcast: rename br_ip's u
 member to dst
Message-ID: <20200922175119.GA10212@otheros>
References: <20200922073027.1196992-1-razor@blackwall.org>
 <20200922073027.1196992-7-razor@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922073027.1196992-7-razor@blackwall.org>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: netdev@vger.kernel.org, roopa@nvidia.com, davem@davemloft.net, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <a@unstable.cc>

On Tue, Sep 22, 2020 at 10:30:17AM +0300, Nikolay Aleksandrov wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> Since now we have src in br_ip, u no longer makes sense so rename
> it to dst. No functional changes.
> 
> v2: fix build with CONFIG_BATMAN_ADV_MCAST

Hi Nikolay,

I don't see a "src" in br_ip in net-next/master at the moment. Or
is that supposed to be added with your IGMPv3 implementation in
the future?

(which btw. is awesome, really looking forward to full IGMPv3(+MLDv2)
support, as source-specific-multicast would allow us to implement
some neat, way more efficient algorithms than with any-source-multicast
for multicast in batman-adv in the future, too)

Regards, Linus
