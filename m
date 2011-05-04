Return-Path: <andrew@lunn.ch>
Date: Wed, 4 May 2011 15:52:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110504135223.GB1528@lunn.ch>
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
	<1304438096-19009-4-git-send-email-ordex@autistici.org>
	<20110504112234.GA1528@lunn.ch>
	<20110504133637.GB6519@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110504133637.GB6519@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: improved roaming
 mechanism
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wed, May 04, 2011 at 03:36:37PM +0200, Antonio Quartulli wrote:
> On Wed, May 04, 2011 at 01:22:34PM +0200, Andrew Lunn wrote:
> > > +struct roam_adv_packet {
> > > +	uint8_t  packet_type;
> > > +	uint8_t  version;
> > > +	uint8_t  dst[6];
> > > +	uint8_t  ttl;
> > > +	uint8_t  src[6];
> > > +	uint8_t  client[6];
> > > +} __packed;
> > > +
> > 
> > Maybe put ttl at the end, to help with alignment? 
> 
> As I did for the tt_query packet, the initial four fields are the same as the
> unicast_packet so that I can exploit route_unicast_packet() instead of writing
> routing function.
> 
> Is that a major issue?

No. It just that gcc might optimize accesses to src and client as a
word read + 1/2 word read, if they where 1/2 word aligned. With ttl
where it is, src and client are in strange alignments, so gcc will
have to do byte access. But this is not the fast path, so it does not
matter much.

> > > +	tt_global_add(bat_priv, orig_node, roam_adv_packet->client,
> > > +		      atomic_read(&orig_node->last_ttvn) + 1, true);
> > > +
> > > +	/* Roaming phase starts: I have a new information but the ttvn has been
> > > +	 * incremented yet. This flag will make me check all the incoming
> > > +	 * packets for the correct destination. */
> > 
> > The grammar in that comment could be better:
> > 
> > 	/* Roaming phase starts: I have new information but the ttvn has not 
> > 	 * been incremented yet. This flag will make me check all the incoming
> > 	 * packets for the correct destination. */
> > 
> 
> Thanks and sorry for my poor grammar :)

Actually, it is mostly very good....

> Ok..I got the point. Maybe I will not be so drastic but I will follow
> your suggestion

Lots of small functions is my style. However, the Linux coding style
documentation says something similar:

                Chapter 6: Functions

Functions should be short and sweet, and do just one thing.  They should
fit on one or two screenfuls of text (the ISO/ANSI screen size is 80x24,
as we all know), and do one thing and do that well.

It is well worth reading Documentation/CodingStyle

   Andrew
