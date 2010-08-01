Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 1 Aug 2010 17:39:14 +0200
References: <1279923269-26513-1-git-send-email-sven.eckelmann@gmx.de>
	<201008011728.53733.lindner_marek@yahoo.de>
In-Reply-To: <201008011728.53733.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201008011758.54120.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Only copy skb data for
	multiple broadcasts
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

On Sunday 01 August 2010 17:28:53 Marek Lindner wrote:
> On Saturday 24 July 2010 00:14:29 Sven Eckelmann wrote:
> > batman-adv tries to resend broadcasts on all interfaces up to three
> > times. For each round and each interface it must provide a skb which
> > gets consumed by the sending function.
> > 
> > It is unnecessary to copy the data of each broadcast because the actual
> > data is either not shared or already copied by add_bcast_packet_to_list.
> > So it is enough to just copy the skb control data
> 
> I think the reason to call skb_copy() is the following dev_queue_xmit()
> call which will consume the given skb. If we consider a case of having 3
> interfaces all 3 cloned skbs point to the same data while going out via
> different interfaces ? I wonder whether that can work ?!

Can we try to explain what we think will happen? I would assume following:
 * payload is there in skb
 * skb will be cloned to skb1 (not copied, so the actual data is shared)
 * send_skb_packet will be called and a ethernet header with the actual
   address is added to the data of skb and skb1 - only skb1 will know about
   that new stuff and point to the new data
 * skb1 will be consumed by dev_queue_xmit (not the data, because the refcount
   will not become 0)
 * next if will be processed
 * skb (without the knowledge about the ethernet header stuff) will be cloned
   to skb1
 * send_skb_packet will be called with skb1 and new, personalized ethernet
   header is added
 * skb1 will be consumed by dev_queue_xmit
 * and so on

So the data will be touched, but only the part which is not "know" by the 
initial/original skb. It is not accessed at the same time by other 
cpus/threads/whatever. The skb control data is only cloned because it will be 
consumed and changed in a way which would affect other batman-ifs.

So I would assume that this works with skb_clone instead of skb_copy.

Best regards,
	Sven
