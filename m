Return-Path: <linus.luessing@web.de>
Date: Fri, 2 Aug 2013 10:04:44 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130802080444.GA25436@Linus-Debian>
References: <1374888285-20775-1-git-send-email-linus.luessing@web.de>
 <1374888285-20775-2-git-send-email-linus.luessing@web.de>
 <cec8de3ff4ea6c6853536d1b32dc7352@autistici.org>
 <201308021205.28767.lindner_marek@yahoo.de>
 <20130802071806.GE3936@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20130802071806.GE3936@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH next 2/2] batman-adv: fix potential
 kernel paging error for unicast transmissions
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

On Fri, Aug 02, 2013 at 09:18:06AM +0200, Antonio Quartulli wrote:
> On Fri, Aug 02, 2013 at 12:05:28PM +0800, Marek Lindner wrote:
> > On Monday, July 29, 2013 04:17:57 Antonio Quartulli wrote:
> > > Il 27.07.2013 03:24 Linus Lüssing ha scritto:
> > > > batadv_send_skb_prepare_unicast(_4addr) might reallocate the skb's
> > > > data. If it does then our ethhdr pointer is not valid anymore in
> > > > batadv_send_skb_unicast(), resulting in a kernel paging error.
> > > > 
> > > > This patch fixes this issue by storing the few bytes we are interested
> > > > in on the stack before modifying the skb.
> > > 
> > > Good fix! thanks!
> > > 
> > > 
> > > However, I think it would be nice to send another patch aiming master
> > > which could polish this situation a bit better: e.g. by calling
> > > skb_reset_mac_header() in the batadv_send_skb_prepare_unicast_*
> > > functions and then get the Ethernet header with eth_hdr() right after
> > > having changed the skb.
> > 
> > I like that approach because it seems cleaner that way. Is there a reason not 
> > do it right away ?
> 
> I thought the second approach would consist in a bigger patch and so I preferred
> to send this to net and the bigger patch to net-next later.
> 
> But you may be right. The change I suggested is not really big.
> Linus, would you like to provide "the next" patch so that we can clearly
> understand if it is worth sending to net or not?

Sure! I think it could actually be a lot easier than I thought (if I
didn't misread or miss something in the skb code).

> 
> Cheers,
> 
> -- 
> Antonio Quartulli
> 
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara


