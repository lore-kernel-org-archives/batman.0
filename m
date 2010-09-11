Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 12 Sep 2010 01:56:19 +0200
References: <20100910184706.151a6728@rechenknecht>
	<1284137300-26277-1-git-send-email-an.langer@gmx.de>
	<201009111126.38504.sven.eckelmann@gmx.de>
In-Reply-To: <201009111126.38504.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201009120156.20364.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: layer2 unicast packet
	fragmentation enhancements
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

On Saturday 11 September 2010 11:26:37 Sven Eckelmann wrote:
> Is it possible to split the patch in those parts? It would make it easier
> to read it and understand the patches later.

I'm not sure that will do much good. He managed to reorganize the code and 
thereby remove redundancies. The second patch would probably be no bigger than 
3-5 lines of code.


> > -	/* packet for me */
> > -	if (is_my_mac(unicast_packet->dest)) {
> > -		interface_rx(recv_if->soft_iface, skb, hdr_size);
> > -		return NET_RX_SUCCESS;
> > -	}
> > -
> 
> There are different parts of the patch which makes ma a little bit curious
> - for example: why it is possible to drop that check entirely? Could that
> be an extra patch with an explanation why that can be dropped? Is it only
> valid in context of the new fragmentation handling? ...

I ran into the same question as it looks a bit odd here but if you apply the 
patch it all looks good. As I said: it seems he managed to purge quite a bit 
of redundancy (fragmented and non-fragmented packets are almost identical 
after all).

Cheers,
Marek
