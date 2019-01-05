Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 5 Jan 2019 16:02:32 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190105150232.GO21623@otheros>
References: <20181207135846.6152-1-sven@narfation.org>
 <20181207135846.6152-15-sven@narfation.org>
 <20190104015726.GG21623@otheros> <2492575.sfqEKcoiOs@sven-edge>
 <20190104084345.GC21282@nanopsycho.orion>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190104084345.GC21282@nanopsycho.orion>
Subject: Re: [B.A.T.M.A.N.] [RFC v3 14/19] batman-adv: Add multicast_mode
 mesh genl configuration
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jiri Pirko <jiri@mellanox.com>
Cc: Sven Eckelmann <sven@narfation.org>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Fri, Jan 04, 2019 at 08:51:56AM +0000, Jiri Pirko wrote:
> Fri, Jan 04, 2019 at 08:44:38AM CET, sven@narfation.org wrote:
> >On Friday, 4 January 2019 02.57.26 CET Linus Lüssing wrote:
> >> On Fri, Dec 07, 2018 at 02:58:41PM +0100, Sven Eckelmann wrote:
> >> > diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
> >> > index 8e3a1b6e..32762003 100644
> >> > --- a/net/batman-adv/netlink.c
> >> > +++ b/net/batman-adv/netlink.c
> >> > @@ -155,6 +155,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
> >> >  	[BATADV_ATTR_GW_SEL_CLASS]		= { .type = NLA_U32 },
> >> >  	[BATADV_ATTR_HOP_PENALTY]		= { .type = NLA_U8 },
> >> >  	[BATADV_ATTR_LOG_LEVEL]			= { .type = NLA_U32 },
> >> > +	[BATADV_ATTR_MULTICAST_MODE]		= { .type = NLA_U8 },
> >> >  };
> >> 
> >> Since the name is more generic than just a flag, would it make
> >> sense to make this a U32, just to stay flexible for the future?
> 
> If the attribute is supposed to be just a bool, the name would be
> probably better to change to "BATADV_ATTR_MULTICAST_ENABLED" or
> something.

Hm, BATADV_ATTR_MULTICAST_ENABLED sounds confusing to me. In a
layer 2 mesh network, multicast always needs to be enabled for
things like IP to work.

So setting this to 0 does not disable multicast.

What this option does is using "classic flooding" (0) for
multicast packets or dropping/unicasting if possible, if IGMP/MLD
snooping detected such potential (1).

And since there were many discussions regarding which additional
techniques and algorithms could be implemented I would expect more
options to follow.

And for complementary techniques, a bitfield of 32 bits size
could be useful, I guess?
