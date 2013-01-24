Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 24 Jan 2013 21:47:51 +0800
References: <c15e0026ed81d2da11ee59ab7bfcb3a6271cd10b.1358961079.git.mschiffer@universe-factory.net>
 <201301242136.11695.lindner_marek@yahoo.de>
 <20130124133858.GB2507@ritirata.org>
In-Reply-To: <20130124133858.GB2507@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201301242147.51470.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: filter out invalid DAT
	entries
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <ordex@autistici.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Thursday, January 24, 2013 21:38:58 Antonio Quartulli wrote:
> On Thu, Jan 24, 2013 at 09:36:11PM +0800, Marek Lindner wrote:
> > On Thursday, January 24, 2013 05:53:52 Antonio Quartulli wrote:
> > > > It might make sense though to check for different types of addresses
> > > > that are invalid for ARP (zeronet, loopback, multicast, etc.), but I
> > > > wanted to keep the patch as simple as possible. If you think these
> > > > should be filtered as well, I'll prepare a v2.
> > > 
> > > in distributed-arp-table.c:784 you can already find these checks ;)
> > 
> > If most of the checking is done in batadv_arp_get_type() why not moving
> > these checks there too ? That would allow to have all checks in the same
> > place ?
> 
> I thought the same, but in batadv_arp_get_type() we have a general check
> that discards wrong/bogus ARP request.
> 
> Here instead we are filtering "correct" ARP requests that DAT should not
> handle.

What is the difference except for the naming ? In both cases we don't want 
these packets to be handled by DAT. 

Feel free to move these extra validation checks into a separate function that 
gets called from batadv_arp_get_type() if you wish to emphasize the difference 
between the types of checks. Having all checks in the same place will help to 
avoid overlooking things later (as already happened).

Cheers,
Marek
