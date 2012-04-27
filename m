Return-Path: <ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 27 Apr 2012 14:51:08 +0200
From: Antonio Quartulli <ordex@autistici.org>
In-Reply-To: <20120425.140904.935584797119761625.davem@davemloft.net>
References: <AE90C24D6B3A694183C094C60CF0A2F6026B6EF3@saturn3.aculab.com>
	<AE90C24D6B3A694183C094C60CF0A2F6026B6EF4@saturn3.aculab.com>
	<20120425.140904.935584797119761625.davem@davemloft.net>
Message-ID: <f56ca946ce96504fcedbbfef0967b210@autistici.org>
Subject: Re: [B.A.T.M.A.N.]
 =?utf-8?q?=5BPATCH_03/15=5D_batman-adv=3A_add_bigg?=
 =?utf-8?q?est=5Funsigned=5Fint=28x=29_macro?=
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
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, david.laight@aculab.com, b.a.t.m.a.n@lists.open-mesh.org

Il 25.04.2012 20:09 David Miller ha scritto:
> From: "David Laight" <David.Laight@ACULAB.COM>
> Date: Wed, 25 Apr 2012 15:57:39 +0100
>
>>
>>> > +/* Returns the biggest unsigned integer with the sizeof x */
>>> > +#define biggest_unsigned_int(x) (~(x)0)
>>>
>>> Nope - biggest_unsigned_int(unsigned char) is probably 0xffffffff
>>
>> To correct myself, it is actually ((int)(-1)) (ie a signed value).
>
> In any event this is just a terrible macro, and too stupid to live.

Hello David,

ok. So the suggestion is to directly use the ~ operator in the code 
without creating a macro.
If the rest of the patchset is ok, I will eliminate this macro and 
resend the pull request again.

Cheers,


-- 
Antonio Quartulli
