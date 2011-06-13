Return-Path: <ordex@autistici.org>
Date: Mon, 13 Jun 2011 15:25:07 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110613132507.GA18690@ritirata.org>
References: <201106121152.02177.sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201106121152.02177.sven@narfation.org>
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

Hi Sven, hi all,

On Sun, Jun 12, 2011 at 11:52:00AM +0200, Sven Eckelmann wrote:
> Hi,
> 
> just looked a little bit closer at your tt_query implementation and was 
> reminded that we had a small discussion in IRC some weeks ago.
> 
> <ecsv> can those flags be mixed?
> <ordex> mixed? in which way?
> <ecsv> request | table -> still a valid package
> <ecsv> sry, packet
> <ordex> yes it is, because it means "I'm requesting a full table"
> <ordex> all the combinations are valid
> 
> This sounds wrong when I look at the tt_query packet. There we have a tt_data 
> field which can used used exclusive by either TT_REQUEST (x)or TT_RESPONSE. 
> Therefore, it is not possible to use both flags at the same time. Can you 
> please explain how this is handled or otherwise change it so that only one bit 
> in flags is used to decide if it is an response or a request.
> 

At the beginning we had one bit only with this meaning:

0 => TT_REQUEST
1 => TT_RESPONSE

But then we had a disussion about:
1) what will we do if we want to add more packet types in the future?
2) is it correct or not to use 0x0 as flag?

Regarding 1) I thought that using a "two bits flag" could help in reserving two 
configurations more for the future (0x0 and 0x3).

Regarding 2) we switched to TT_REQ = 0x01 and TT_RESP = 0x2.

In my opinion, leaving tt_req = 0x0 and tt_resp = 0x1 would be better,
but it seemed to be not so correct.


I hope my explanation is clear.
Morover I think that someone should explain me if using 0x0 as a
meaningful flag is correct or not :P (I know that field & 0x0 will
always be false :P)

> Maybe this was the result of the discussion with Marek about the roaming stuff 
> - but i don't think that it applies here.

No, this is not related to the roaming stuff.


Regards,


-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
