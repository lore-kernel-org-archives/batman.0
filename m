Return-Path: <linus.luessing@web.de>
Date: Wed, 5 Jan 2011 12:57:30 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110105115730.GB6723@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] bitarray.c / packet-counting / window questions
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi everyone,

For the NDP patches, the usage of the methods for determening the
link qualities with the window is the code I'm most uncertain
about (right after the fancy rcu-locking/refcounting ;) ).

Therefore I'd like to ask some questions about code in bitarray.c
and routing.c that came to my mind while reading some of those
parts and which parts confused me, partly due to their naming
style I think. It's great though, that the purpose of the methods
in bitarray.c are well explained, I'm just missing some minor cases
that are not explained in their comment.

- for get_bit_status() it's especially not clear to me, what is
  meant with "in range" in its comment. is it supposed to be "in
  range" if it is after or before the last_seqno?
- bit_get_packet(): just for clarification, if set_mark is set,
  that means the window can still be slided, but the bit for the
  according seqno in the window is not being set, right?
  (what do you think about adding a sentence about its purpose in
  this methods preceding comment?)
- what does bit_get_packet() return in case of a not very old, but
  just old packet which is still inside of the window? (the
  comment does not seem to cover this case)
- what do you think of renaming bit_get_packet() to something like
  update_window()? With function names having a "get" in their
  name I'd usually think that they'd not modify anything. And for
  instance renaming set_mark to "slide_only" or something else
  that might explain a little more the difference when setting or
  not setting it?

- for the need_update in the code, this is just refering to an
  updated last_real_seqno, right? need_update could also be 0 in
  case of a out-of-order and not too old ogm, right?
  (maybe renaming it to something like window_slided or
  update_last_rq_seqno?)
- in count_real_packets(), why are the window update functions
  (bit_get_packet(), bit_packet_count()) still called in case of
  is_duplicate == 1?

Do you think it might make sense to add some more abstraction in
routing.c to reduce the number of functions in bitarray.c you have to look at
and their purpose you'd have to get your head around? To avoid having to think
of the window operations in routing.c and abstract that part?

And one more question for the TQ_LOCAL_WINDOW_SIZE, when i.e. I'd
change that to a lower value, for instance 4, I'd have to set
WORD_BIT_SIZE to (sizeof(unsigned long) / 2), right? Would that
cause any trouble on the code side (and yeah, I know that this is
causing unusable link quality measurements, but I wanted to reduce
that to play a little with an exponentially weighted moving
average on top of that).

Cheers, Linus
