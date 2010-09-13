Return-Path: <an.langer@gmx.de>
Date: Mon, 13 Sep 2010 17:45:31 +0200
From: Andreas Langer <an.langer@gmx.de>
Message-ID: <20100913174531.21580041@rechenknecht>
In-Reply-To: <201009122211.07839.sven.eckelmann@gmx.de>
References: <20100910184706.151a6728@rechenknecht>
	<201009111126.38504.sven.eckelmann@gmx.de>
	<201009120156.20364.lindner_marek@yahoo.de>
	<201009122211.07839.sven.eckelmann@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: b.a.t.m.a.n@lists.open-mesh.org

Am Sun, 12 Sep 2010 22:11:06 +0200
schrieb Sven Eckelmann <sven.eckelmann@gmx.de>:

> Marek Lindner wrote:
> > On Saturday 11 September 2010 11:26:37 Sven Eckelmann wrote:
> > > Is it possible to split the patch in those parts? It would make it easier
> > > to read it and understand the patches later.
> > 
> > I'm not sure that will do much good. He managed to reorganize the code and
> > thereby remove redundancies. The second patch would probably be no bigger
> > than 3-5 lines of code.
> 
> That would not be bad. But refactoring and adding two new features isn't 
> something I personally like. Guessing what part could belong to which other 
> part just makes it hard to find the real problems. Take for example the 
> missing failure checks in the patch.
> 
> Something I had in mind would be  a patch which adds frag_send_skb and starts 
> to use it, one that removes the duplicated code, another one that does the 
> cleanup/renaming stuff, the next adds the fragmentation on routing and finally 
> there is the defragmentation (probably skipped some steps) - you could much 
> more easily check the actual change in its own context. That would for example 
> remove the question why those lines were removed - the patch itself would 
> answer that question using its commit message which states: "hey those lines 
> aren't needed because we already check that fact here and there and don't need 
> that information before".
> 
> And if a patch real adds a cool feature only by changing some lines and 
> without rewriting the whole code then we must have done something right.
> 
> If you think different - ok, leave it that way.

No it's ok, you are right. I will split the patch.
> 
> > > > -	/* packet for me */
> > > > -	if (is_my_mac(unicast_packet->dest)) {
> > > > -		interface_rx(recv_if->soft_iface, skb, hdr_size);
> > > > -		return NET_RX_SUCCESS;
> > > > -	}
> > > > -
> > > 
> > > There are different parts of the patch which makes ma a little bit
> > > curious - for example: why it is possible to drop that check entirely?
> > > Could that be an extra patch with an explanation why that can be
> > > dropped? Is it only valid in context of the new fragmentation handling?
> > > ...
> > 
> > I ran into the same question as it looks a bit odd here but if you apply
> > the patch it all looks good. As I said: it seems he managed to purge quite
> > a bit of redundancy (fragmented and non-fragmented packets are almost
> > identical after all).
>  
> Andreas Langer wrote:
> > what are the other parts which makes you curious ?
> 
> That a failure in frag_reassemble_skb is a good successfully rx, that 
> frag_create_buffer is magically always successful even when the called 
> functions can fail, that you use skb_pull and directly afterward access the 
> data pointer, that no one frees the skb when frag_reassemble_skb cannot find a 
> matching originator, ...

I will look into it.Thanks for your hints.

regards,
andreas

