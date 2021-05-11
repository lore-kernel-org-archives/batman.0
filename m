Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Subject: Re: [net-next v2 09/11] net: bridge: mcast: split multicast router
 state for IPv4 and IPv6
From: Nikolay Aleksandrov <nikolay@nvidia.com>
References: <20210509194509.10849-1-linus.luessing@c0d3.blue>
 <20210509194509.10849-10-linus.luessing@c0d3.blue>
 <f2f1c811-0502-bde4-8ece-e47b3e30dc66@nvidia.com>
Message-ID: <e784e0e6-8b30-0862-e417-a6ff94790b8e@nvidia.com>
Date: Tue, 11 May 2021 12:33:08 +0300
In-Reply-To: <f2f1c811-0502-bde4-8ece-e47b3e30dc66@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, netdev@vger.kernel.org
Cc: Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, bridge@lists.linux-foundation.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org

On 11/05/2021 12:29, Nikolay Aleksandrov wrote:
> On 09/05/2021 22:45, Linus L=C3=BCssing wrote:
>> A multicast router for IPv4 does not imply that the same host also is =
a
>> multicast router for IPv6 and vice versa.
>>
>> To reduce multicast traffic when a host is only a multicast router for
>> one of these two protocol families, keep router state for IPv4 and IPv=
6
>> separately. Similar to how querier state is kept separately.
>>
>> For backwards compatibility for netlink and switchdev notifications
>> these two will still only notify if a port switched from either no
>> IPv4/IPv6 multicast router to any IPv4/IPv6 multicast router or the
>> other way round. However a full netlink MDB router dump will now also
>> include a multicast router timeout for both IPv4 and IPv6.
>>
>> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
>> ---
>>  net/bridge/br_forward.c   |   8 ++
>>  net/bridge/br_mdb.c       |  10 ++
>>  net/bridge/br_multicast.c | 197 ++++++++++++++++++++++++++++++++++---=
-
>>  net/bridge/br_private.h   |   6 +-
>>  4 files changed, 201 insertions(+), 20 deletions(-)
[snip]
>> +#else
>> +static inline void br_ip6_multicast_add_router(struct net_bridge *br,
>> +					       struct net_bridge_port *port)
>> +{
>> +}
>=20
> Actually that goes for multicast_add_router, too.
>=20

err, my bad - multicast_add_router is fine as is, sorry about that

> I'm saying all this because soon I'll be adding per-vlan multicast rout=
er support
> and these will be reusable there without any modification if they can t=
ake any list.
> Also it'll be easier to maintain one set of functions instead of multip=
le identical ones.
>=20
