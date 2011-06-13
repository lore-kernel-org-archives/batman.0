Return-Path: <ordex@autistici.org>
Date: Mon, 13 Jun 2011 19:02:07 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110613170207.GC9787@ritirata.org>
References: <201106121152.02177.sven@narfation.org>
	<20110613132507.GA18690@ritirata.org>
	<201106131629.19141.sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201106131629.19141.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] Combination of flags in tt_query packets
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Mon, Jun 13, 2011 at 04:29:16PM +0200, Sven Eckelmann wrote:
> Antonio Quartulli wrote:
> > > just looked a little bit closer at your tt_query implementation and was
> > > reminded that we had a small discussion in IRC some weeks ago.
> > > 
> > > <ecsv> can those flags be mixed?
> > > <ordex> mixed? in which way?
> > > <ecsv> request | table -> still a valid package
> > > <ecsv> sry, packet
> > > <ordex> yes it is, because it means "I'm requesting a full table"
> > > <ordex> all the combinations are valid
> > > 
> > > This sounds wrong when I look at the tt_query packet. There we have a
> > > tt_data field which can used used exclusive by either TT_REQUEST (x)or
> > > TT_RESPONSE. Therefore, it is not possible to use both flags at the same
> > > time. Can you please explain how this is handled or otherwise change it
> > > so that only one bit in flags is used to decide if it is an response or
> > > a request.
> > 
> > At the beginning we had one bit only with this meaning:
> > 
> > 0 => TT_REQUEST
> > 1 => TT_RESPONSE
> 
> Could be correct - never followed the discussion in detail. I asked Marek and 
> he said something about roaming.

We did something similar for the tt_change flag field. I think I have to
give a look at it too.


> 
> > But then we had a disussion about:
> > 1) what will we do if we want to add more packet types in the future?
> 
> Depends on the type. For example full-table creates different packet types 
> together with the TT_REQUEST and TT_RESPONSE. But using TT_REQUEST and 
> TT_RESPONSE together doesn't work at all. So forget about the flag and think 
> more about a currently undefined amount of bits which encode the type of 
> packet. Encoding the request and reply in two different bits and call them 
> flags doesn't really make sense. 
> 
> > 2) is it correct or not to use 0x0 as flag?
> 
> A not existing bit position is not really a "flag". The bit at position zero 
> (lsb) could be used as flag to decide if it is a request or a response - but 
> using nothing to store something is... <please insert your favourite swear 
> word here>.
> 
> > Regarding 1) I thought that using a "two bits flag" could help in reserving
> > two configurations more for the future (0x0 and 0x3).
> 
> Then you say that you don't use flags but 2 bits to store 2 values. Please 
> don't use it in your code as flags, but use something like (x & TT_TYPE_MASK) 
> to extract the corresponding bits and compare the resulting values against 
> representation of TT_RESPONSE and TT_RESPONSE (TT_TYPE_MASK would be 0x3, 
> TT_RESPONSE 0 and TT_REQUEST 3). Also remove the TT_RESPONSE and TT_REQUEST 
> from the enum tt_query_flags and use another enum for them.

Ok, I agree. I'm going to propose a patch to clean it up. Thanks for all
the suggestions.

Regards,


-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
