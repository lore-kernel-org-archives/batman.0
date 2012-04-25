Return-Path: <davem@davemloft.net>
Date: Wed, 25 Apr 2012 14:09:04 -0400 (EDT)
Message-Id: <20120425.140904.935584797119761625.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B6EF4@saturn3.aculab.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6026B6EF3@saturn3.aculab.com>
	<AE90C24D6B3A694183C094C60CF0A2F6026B6EF4@saturn3.aculab.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/15] batman-adv: add
	biggest_unsigned_int(x) macro
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
To: David.Laight@ACULAB.COM
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: "David Laight" <David.Laight@ACULAB.COM>
Date: Wed, 25 Apr 2012 15:57:39 +0100

>  
>> > +/* Returns the biggest unsigned integer with the sizeof x */
>> > +#define biggest_unsigned_int(x) (~(x)0)
>> 
>> Nope - biggest_unsigned_int(unsigned char) is probably 0xffffffff
> 
> To correct myself, it is actually ((int)(-1)) (ie a signed value).

In any event this is just a terrible macro, and too stupid to live.
