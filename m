Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 19 Dec 2016 14:32:26 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161219133226.GM6323@otheros>
References: <20161006064142.20003-1-linus.luessing@c0d3.blue>
 <20161006064142.20003-3-linus.luessing@c0d3.blue>
 <740883563.LbP4XMaFY9@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <740883563.LbP4XMaFY9@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/4] batman-adv: Store and transmit
 own neighborhood hash
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

On Wed, Dec 14, 2016 at 09:28:33PM +0100, Sven Eckelmann wrote:
> On Donnerstag, 6. Oktober 2016 08:41:39 CET Linus Lüssing wrote:
> >  struct batadv_elp_packet {
> >         u8     packet_type;
> > @@ -247,6 +258,8 @@ struct batadv_elp_packet {
> >         u8     orig[ETH_ALEN];
> >         __be32 seqno;
> >         __be32 elp_interval;
> > +       __be16 reserved;
> > +       __be16 tvlv_len;
> >  };
> 
> Um, you simply increase the size of the elp_packet? Isn't this potentially 
> breaking compat with older versions? batadv_v_elp_packet_recv is using 
> BATADV_ELP_HLEN (sizeof(struct batadv_elp_packet)) as minimal size/header_len 
> in batadv_check_management_packet.
> 
> Only thing saving you here is the padding on some links. But this padding 
> could cause some odd behaviour in batadv_tvlv_containers_process2 when 
> tvlv_len is bogus/padding.

Urgh, could catch, you're right.

Luckily, it seems like it's only breaking compatibility in one direction.
And it's the direction where a non-compatibility breaking solution
is possible.
