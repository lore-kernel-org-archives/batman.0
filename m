Return-Path: <andrew@lunn.ch>
Date: Wed, 13 Apr 2016 14:14:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160413121416.GA22733@lunn.ch>
References: <20160412204259.GK29895@lunn.ch>
 <2242031.raF8ugmCc9@prime>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2242031.raF8ugmCc9@prime>
Subject: Re: [B.A.T.M.A.N.] skb->priority and fragments
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

On Wed, Apr 13, 2016 at 01:11:12PM +0200, Simon Wunderlich wrote:
> Hi Andrew,
> 
> On Tuesday 12 April 2016 22:42:59 Andrew Lunn wrote:
> > Hi Folks
> > 
> > Does anybody remember the history for the follow and can explain why
> > the code is as it is?
> > 
> > The soft interface transmit function, batadv_interface_tx() calls
> > batadv_skb_set_priority(skb, 0) to set the skb->priority based on the
> > TOS bits or 801.p.
> > 
> > If the packet needs to be fragmented because of MTU issues,
> > batadv_frag_create() is used to create the fragments. It overwrites
> > the skb->priority in the original skb to TC_PRIO_CONTROL, and leaves
> > the fragment skb with the default priority.
> > 
> > This seems a bit odd to me. I would of expected the priority to of
> > been copied from the original into the fragment.

Hi Simon

> I think this part could be improved. Right now, if I remember correctly, we 
> set TC_PRIO_CONTROL by default and set another priority if we can parse the 
> header (batadv_skb_set_priority()).

Yes, that is what i thought the intention was. The implementation is a
bit different.

> There are two cases:
> 
> 1.) On the original sender, both fragments could adopt the priority as you 
> suggest. The code probably doesn't take care of that yet, so that could be 
> fixed.

I will cook up a patch for this.
 
> 2.) On routers on the way, the priority could only be set based on the first 
> fragment, since the second fragment will not have a valid header to parse. And 
> unless we remember the priority from the first fragment, we have no way to 
> know to which priority we should set the second fragment.

I don't think remembering works. It looks like it fragments from the
tail towards the head. So we are not going to receive the IP header
until we get the last fragment.

> I believe case 1 can be fixed easily, for case 2 I don't have an idea right 
> now. :)

There is one reasonable option i can think
of. batadv_skb_set_priority() extracts three bits of priority
information, either from the TOS bits, or the 801.q header.

The fragment header is:

struct batadv_frag_packet {
        u8     packet_type;
        u8     version;  /* batman version field */
        u8     ttl;
#if defined(__BIG_ENDIAN_BITFIELD)
        u8     no:4;
        u8     reserved:4;
#elif defined(__LITTLE_ENDIAN_BITFIELD)
        u8     reserved:4;
	u8     no:4;
#else
#error "unknown bitfield endianness"
#endif
        u8     dest[ETH_ALEN];
        u8     orig[ETH_ALEN];
        __be16 seqno;
	__be16 total_size;
};

Place the priority information into 3 of the 4 reserved bits. The
receiver can then set the skb->priority of the fragment before passing
it to the hard interface.

   Andrew
