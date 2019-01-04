Return-Path: <jiri@mellanox.com>
From: Jiri Pirko <jiri@mellanox.com>
Date: Fri, 4 Jan 2019 08:51:56 +0000
Message-ID: <20190104084345.GC21282@nanopsycho.orion>
References: <20181207135846.6152-1-sven@narfation.org>
 <20181207135846.6152-15-sven@narfation.org> <20190104015726.GG21623@otheros>
 <2492575.sfqEKcoiOs@sven-edge>
In-Reply-To: <2492575.sfqEKcoiOs@sven-edge>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <F9CB9637A8DBF14B8988C50850D97BA1@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Sven Eckelmann <sven@narfation.org>
Cc: =?iso-8859-1?Q?Linus_L=FCssing?= <linus.luessing@c0d3.blue>, "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

Fri, Jan 04, 2019 at 08:44:38AM CET, sven@narfation.org wrote:
>On Friday, 4 January 2019 02.57.26 CET Linus L=FCssing wrote:
>> On Fri, Dec 07, 2018 at 02:58:41PM +0100, Sven Eckelmann wrote:
>> > diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
>> > index 8e3a1b6e..32762003 100644
>> > --- a/net/batman-adv/netlink.c
>> > +++ b/net/batman-adv/netlink.c
>> > @@ -155,6 +155,7 @@ static const struct nla_policy batadv_netlink_poli=
cy[NUM_BATADV_ATTR] =3D {
>> >  	[BATADV_ATTR_GW_SEL_CLASS]		=3D { .type =3D NLA_U32 },
>> >  	[BATADV_ATTR_HOP_PENALTY]		=3D { .type =3D NLA_U8 },
>> >  	[BATADV_ATTR_LOG_LEVEL]			=3D { .type =3D NLA_U32 },
>> > +	[BATADV_ATTR_MULTICAST_MODE]		=3D { .type =3D NLA_U8 },
>> >  };
>>=20
>> Since the name is more generic than just a flag, would it make
>> sense to make this a U32, just to stay flexible for the future?

If the attribute is supposed to be just a bool, the name would be
probably better to change to "BATADV_ATTR_MULTICAST_ENABLED" or
something.


>>=20
>> (I don't have any specific ideas or plans to use more
>> values for it right now, though)
>
>Please discuss this with Jiro because he told us to use u8.
>
>Kind regards,
>	Sven
>


