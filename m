Return-Path: <andrew@lunn.ch>
Date: Sat, 16 Apr 2022 19:26:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] batman-adv: Don't skb_split skbuffs with frag_list
Message-ID: <Ylr8YwkBAS+6iozm@lunn.ch>
References: <20220416122434.33061-1-sven@narfation.org>
 <YlrQ306LD4luXaeJ@lunn.ch>
 <2248548.8ZbxvZVH5L@sven-l14>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2248548.8ZbxvZVH5L@sven-l14>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Felix Kaechele <felix@kaechele.ca>

On Sat, Apr 16, 2022 at 07:17:28PM +0200, Sven Eckelmann wrote:
> On Saturday, 16 April 2022 16:21:19 CEST Andrew Lunn wrote:
> > This is not an area of the kernel i'm very familiar with. But i'm
> > wondering, is this a BATMAN specific problem, or a generic problem?
> > Should the fix be in BATMAN, or the core?
> 
> I understand what you mean. But let me cite two places which required to 
> operate on parts of the frag lists:
> 
> 	/* If we need update frag list, we are in troubles.
> 	 * Certainly, it is possible to add an offset to skb data,
> 	 * but taking into account that pulling is expected to
> 	 * be very rare operation, it is worth to fight against
> 	 * further bloating skb head and crucify ourselves here instead.
> 	 * Pure masohism, indeed. 8)8)
> 	 */
> 
> 	/* Misery. We are in troubles, going to mincer fragments... */
> 
> 
> And since I cannot reproduce this here at the moment, I've decided not to 
> start with that.

O.K. The BUG_ON() should at least catch other drivers hitting the same
issue, and hopefully a search engine will point to this discussion.

However, i suggest you post the fix to netdev, and see what others
think.

	Andrew

