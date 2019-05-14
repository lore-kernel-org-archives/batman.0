Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 14 May 2019 10:19:33 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH v2] batman-adv: Introduce no noflood mark
Message-ID: <20190514081933.GA1602@otheros>
References: <20190507072821.8147-1-linus.luessing@c0d3.blue>
 <3693433.LtgH54LjNc@bentobox> <3691280.TvIfeD7Em7@rousseau>
 <1895475.8kFdyZb9vl@bentobox> <20190507151723.GB1493@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190507151723.GB1493@otheros>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tue, May 07, 2019 at 05:17:23PM +0200, Linus Lüssing wrote:
> Maybe more importantly even before the bcast_packet->seqno is
> increased. It could become an issue if a node were increasing it's
> seqno quickly without other nodes noticing the new seqnos.
> Broadcast packets we actually let through might then be received
> with a seqno outside of the seqno window on the receiving nodes.

Hm, what do others think about this? If I'm not mistaken then we
currently have three places to consider, which would be affected
by high packet rate multicast:

1) Sender, batadv_forw_packet_alloc() in batadv_add_bcast_packet_to_list():
   -> BATADV_BCAST_QUEUE_LEN = 256

2) Receiver, batadv_test_bit() in batadv_recv_bcast_packet():
   -> BATADV_TQ_LOCAL_WINDOW_SIZE = 64 -> duplicate detection

3) Receiver, batadv_window_protected() in batadv_recv_bcast_packet():
   -> BATADV_EXPECTED_SEQNO_RANGE = 65536


I did some rough estimations with a 5Mbit/s multicast stream
(typical bitrate of a 720p video), quantified to 1250 byte
packets on a piece of paper. It seems ok-ish for the three cases
above, but also seems to get in a range I would start feeling
uncomfortable.

Dropping early via noflood instead of dropping later on the
hard-interfaces via BPF would avoid taking up queueing space and
sequence numbers.

(And I think the queueing onto the kworker also creates quite a
bit of load. At least something like that was my experience on
a Raspberry Pi One with a USB wifi dongle which used a driver
that queued everything onto the kworker, the kworker was
always very busy and never made it above 10-15MBit/s if I remember
correctly [1].)


[1]: https://wikidevi.com/wiki/TP-LINK_TL-WDN4200
