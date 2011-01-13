Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 13 Jan 2011 14:25:53 +0100
References: <20110105115730.GB6723@Sellars>
In-Reply-To: <20110105115730.GB6723@Sellars>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201101131425.53563.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] bitarray.c / packet-counting / window questions
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


Hi,

> - for get_bit_status() it's especially not clear to me, what is
>   meant with "in range" in its comment. is it supposed to be "in
>   range" if it is after or before the last_seqno?

the function seems rather obvious to me. If curr_seqno is smaller than 
last_seqno it is in range (aka in the sliding window).


> - bit_get_packet(): just for clarification, if set_mark is set,
>   that means the window can still be slided, but the bit for the
>   according seqno in the window is not being set, right?
>   (what do you think about adding a sentence about its purpose in
>   this methods preceding comment?)

Correct - if set_mark decides whether the bit is set and not whether the 
window gets shifted.


> - what does bit_get_packet() return in case of a not very old, but
>   just old packet which is still inside of the window? (the
>   comment does not seem to cover this case)

Do you mean: "sequence number is slightly older. We already got a sequence 
number higher than this one, so we just mark it." ? It returns 0 ..


> - for the need_update in the code, this is just refering to an
>   updated last_real_seqno, right? need_update could also be 0 in
>   case of a out-of-order and not too old ogm, right?

Yes.


> - in count_real_packets(), why are the window update functions
>   (bit_get_packet(), bit_packet_count()) still called in case of
>   is_duplicate == 1?

Why should they not be called ?


> Do you think it might make sense to add some more abstraction in
> routing.c to reduce the number of functions in bitarray.c you have to look
> at and their purpose you'd have to get your head around? To avoid having
> to think of the window operations in routing.c and abstract that part?

What exactly do you have in mind ?

Regards,
Marek
