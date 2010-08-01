Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 1 Aug 2010 17:28:53 +0200
References: <1279923269-26513-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1279923269-26513-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201008011728.53733.lindner_marek@yahoo.de>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Saturday 24 July 2010 00:14:29 Sven Eckelmann wrote:
> batman-adv tries to resend broadcasts on all interfaces up to three
> times. For each round and each interface it must provide a skb which
> gets consumed by the sending function.
> 
> It is unnecessary to copy the data of each broadcast because the actual
> data is either not shared or already copied by add_bcast_packet_to_list.
> So it is enough to just copy the skb control data

I think the reason to call skb_copy() is the following dev_queue_xmit() call 
which will consume the given skb. If we consider a case of having 3 interfaces 
all 3 cloned skbs point to the same data while going out via different 
interfaces ? I wonder whether that can work ?!

Cheers,
Marek
