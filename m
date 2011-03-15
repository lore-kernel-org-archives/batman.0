Return-Path: <jluehr@online.de>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Apple Message framework v1082)
From: =?iso-8859-1?Q?Jan_L=FChr?= <jluehr@online.de>
In-Reply-To: <20110315151525.GA4987@Sellars>
Date: Tue, 15 Mar 2011 16:38:27 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <7942B760-B3A9-4C56-A4C6-7F0EDAE5A5C9@online.de>
References: <9B37313E-1B65-4D3F-BE01-1374D13681A8@online.de>
	<20110315151525.GA4987@Sellars>
Subject: Re: [B.A.T.M.A.N.] Batman-adv gateways vs IPv6
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hello,

Am 15.03.2011 um 16:15 schrieb Linus L=FCssing:

> On Mon, Mar 14, 2011 at 01:39:51PM +0100, Jan L=FChr wrote:

>> We're up to deploy batman-adv in an wireless mesh network with =
multiple routers / gateways providing access to the outside world. =
Furthermore deploying an IPv4 / v6 dual stack networking is one goals =
we're trying to archive.
>> We stumbled up on batman-adv and its gateway feature, which looks =
quite promising. (http://www.open-mesh.org/wiki/batman-adv-gateways)
>> However, since dhcp is used for implementing batman-adv gateways, =
this feature doesn't affect IPv6 ND / icmp6 - am I right?
> Yes, that's right, the gateway feature only applies for DHCPv4/6.
> And IPv6 ND / icmp6 is not being touched at all. Like ARP needs to
> be done for IPv4, also still IPv6 needs to do IPv6 ND with all
> hosts.
>=20
> Also the IPv6 Router Advertisements, which I guess you were
> indirectly refering to with the icmp6, are untouched, they are
> still being flooded through the mesh. There were some ideas on how
> a batman-adv gateway optimization could look like for that, based
> on RFC4191, Router Preference, but some tests showed that the
> Router Preference in Linux was not working as expected:
> http://comments.gmane.org/gmane.linux.ipv6.usagi.users/2242
>=20
> But do you actually need that, is there a difficulty with using
> DHCPv6 in your use-case?
>=20
>>=20
>> Having this in mind, what do you think is a suitable deployment =
strategy for IPv6 in batman-adv networks?
>> Of course, assigning a single /64 to the mesh-cloud is a simple =
option, but icmp6 flooding might occur ...
> As said previously, IPv6 ND will be needed anyway, so there's ICMP
> flooding anyway. However that's rather low bandwidth traffic and
> doesn't happen that frequently.
>=20
> Could you describe your use-case a little further? So far no one
> has noticed any constraints with that in practical setups, afaik.

Thanks for you reply - I'm even not sure about our "use"-case. We're =
currently discussing options on running an batman-adv in a =
freifunk-style network, using global IPv6 adresses.
My concern is, that using batman-adv has the achilles heel of creating a =
single collision domain, that'll cause scaling issues.

By that, seperating the mesh into different collision domains (using =
multiple /64 for exmaple) is an option - however, I'm still looking for =
a practical approach to do so.
For instance: If we deploy a bunch of ipv6 routers to our cloud, we have =
to make sure, that IPv6 autoconfiguration will use the address-space of =
a nearby router.
If we'd connect all /64-Annoucing Routers via batman-adv, clients will =
get multiple /64 Addresses by that routers.

So each node must be smart on what icmp6-messages have to be forwareded =
...
However - this is quite vague and we're looking for a feasible routing =
strategy.

Thanks,
Jan=20



