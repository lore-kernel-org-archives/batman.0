Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 21 May 2018 13:04:40 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20180521110440.GJ7162@otheros>
References: <20180515155908.23839-1-linus.luessing@c0d3.blue>
 <1526683397.ZIjaEm5zIv@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526683397.ZIjaEm5zIv@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v4] batman-adv: Snoop DHCPACKs for DAT
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

On Sat, May 19, 2018 at 12:08:57AM +0200, Sven Eckelmann wrote:
> On Dienstag, 15. Mai 2018 17:59:08 CEST Linus Lüssing wrote:
> > +       magic = skb_header_pointer(skb, offset, sizeof(_magic), &_magic);
> > +       if (!magic || *magic != htonl(BATADV_DHCP_MAGIC))
> > +               return -EINVAL;
> 
> I just hear a neoraider cry [1] in the background because you've added a new 
> potentially unaligned 4 byte access in the network packet parsing code. 
> 
> 
> [...]
> > +static __be32 *batadv_dat_dhcp_get_yiaddr(struct sk_buff *skb, __be32 *buffer)
> > +{
> > +       unsigned int offset = skb_transport_offset(skb) + sizeof(struct udphdr);
> > +       unsigned int len = sizeof(((struct batadv_dhcp_packet *)0)->yiaddr);
> > +
> > +       offset += offsetof(struct batadv_dhcp_packet, yiaddr);
> > +
> > +       return skb_header_pointer(skb, offset, len, buffer);
> > +}
> 
> Same here

Hm, I guess there's nothing I could do about that unaligned
access other than suppressing any potential warnings? I guess
since DHCP ACKs are relatively rare compared to other traffic in
fast path I think the performance impact should be negligible.

What was the magic command to check unaligned accesses during
runtime again?

With the preceding "#pragma pack(2)" any warnings should be
suppressed already, shouldn't they?

Regards, Linus
