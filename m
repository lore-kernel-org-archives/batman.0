Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Tue, 22 Sep 2020 19:55:20 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH net-next v2 06/16] net: bridge: mcast: rename br_ip's u
 member to dst
Message-ID: <20200922175519.GB10212@otheros>
References: <20200922073027.1196992-1-razor@blackwall.org>
 <20200922073027.1196992-7-razor@blackwall.org>
 <20200922175119.GA10212@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922175119.GA10212@otheros>
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: netdev@vger.kernel.org, roopa@nvidia.com, davem@davemloft.net, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <a@unstable.cc>

On Tue, Sep 22, 2020 at 07:51:19PM +0200, Linus L=C3=BCssing wrote:
> I don't see a "src" in br_ip in net-next/master at the moment. Or
> is that supposed to be added with your IGMPv3 implementation in
> the future?

Ah, sorry, found the according patch (*) it in my other inbox.
Nevermind.

(*): [PATCH net-next v2 04/16] net: bridge: add src field to br_ip=20
https://patchwork.ozlabs.org/project/netdev/patch/20200922073027.1196992-=
5-razor@blackwall.org/
