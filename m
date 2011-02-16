Return-Path: <Linus.Luessing@ascom.CH>
In-Reply-To: <20110216060811.GB11570@lunn.ch>
References: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
	<1297789948-16948-3-git-send-email-linus.luessing@ascom.ch>
	<20110216060811.GB11570@lunn.ch>
MIME-Version: 1.0
Message-ID: <OF1CE3C18F.65202C60-ONC1257839.0051202F-C1257839.0052EAAC@ln.ascom.ch>
From: Linus Luessing <Linus.Luessing@ascom.CH>
Date: Wed, 16 Feb 2011 16:05:39 +0100
Content-Type: text/plain; charset="US-ASCII"
Subject: Re: [B.A.T.M.A.N.] [PATCH 02/13] batman-adv: Add explicit batman
 header structure
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
To: Andrew Lunn <andrew@lunn.ch>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Andrew Lunn <andrew@lunn.ch> schrieb am 16.02.2011 07:08:11:

> [Bild entfernt] 
> 
> Re: [B.A.T.M.A.N.] [PATCH 02/13] batman-adv: Add explicit batman 
> header structure
> 
> Andrew Lunn 
> 
> an:
> 
> The list for a Better Approach To Mobile Ad-hoc Networking
> 
> 16.02.2011 07:08
> 
> Kopie:
> 
> Linus L??ssing
> 
> On Tue, Feb 15, 2011 at 06:12:17PM +0100, Linus L??ssing wrote:
> > Just a minor style adjustment, to give people a hint which fields 
should
> > not be reordered and need to be at the beginning of each packet with
> > batman-adv's frame type.
> 
> Hi Linus
> 
> > +struct batman_header {
> > +   uint8_t  packet_type;
> > +   uint8_t  version;  /* batman version field */
> > +   uint8_t  ttl;
> > +   uint8_t  align;
> > +} __packed;
> > +
> >  struct batman_packet {
> > -   uint8_t  packet_type;
> > -   uint8_t  version;  /* batman version field */
> > +   struct   batman_header header;
> > +   uint32_t seqno;
> >     uint8_t  flags;    /* 0x40: DIRECTLINK flag, 0x20 VIS_SERVER 
flag... */
> >     uint8_t  tq;
> > -   uint32_t seqno;
> >     uint8_t  orig[6];
> >     uint8_t  prev_sender[6];
> > -   uint8_t  ttl;
> >     uint8_t  num_hna;
> >     uint8_t  gw_flags;  /* flags related to gateway class */
> > -   uint8_t  align;
> >  } __packed;
> 
> Two different ideas, both triggered by the align byte in header. This
> byte is a waste of space, it is not used, and it is probably not easy
> to find something which all packet types are going to need in the
> future.

Sure, anything that not all packet types have in common can't go inside of
the batman_header. But are those three variables something we could agree
on, being something that all packet types will need today and in the 
future?
version + packet_type is something we'll always need I think, the TTL 
might
be something to argue about, as packets that do not get routed would not
necessarily need them (though it could be a "safety belt" in case of bugs,
to really make sure packets only intended for one hop will not be routed).

> 
> 1) Did you try not having it. So long header is __packed, and all the
> structures it is used in are __packed, i think the compiler will do
> the right thing. The downside is that alignment is not obvious. Most
> people will assume header is 4 bytes, not 3, and think the alignment
> of the packets is wrong. 
> 
> 2) Did you consider using a union? It is a more invasive patch, but
> the alignment is then clear. The downside is sizeof() no longer gives
> you the per packet type size, rather it gives you the size of the
> biggest member of the union. So this makes the change even more
> invasive and bug prone.

Hmm, no, actually haven't thought about that. So we'd actually put the 
batman
packet types as a union inside of the batman-header structure, instead of
putting the header structure at the front of each packet type. Don't know
if I'd like that either, due to the reason you've mentioned.

> 
> I think i prefer 1), with appropriate comments to explain the
> alignment issue.

So I think I'd prefer the first option, that should work too :). Just 
didn't think
that an extra Byte would matter that much, and had the readability / 
making the
alignment a little more obvious in mind. (And who knows when we might need 
to increase
the version number size already ;) ) 


> 
>      Andrew

Cheers, Linus
