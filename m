Return-Path: <linus.luessing@web.de>
Date: Tue, 7 Dec 2010 21:23:44 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20101207202344.GA19364@Sellars>
References: <1291732778-27441-1-git-send-email-linus.luessing@ascom.ch>
	<1291732778-27441-5-git-send-email-linus.luessing@ascom.ch>
	<201012071551.31575.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201012071551.31575.sven.eckelmann@gmx.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH 04/10] batman-adv: Send neighbor
 discovery packets
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

On Tue, Dec 07, 2010 at 03:51:21PM +0100, Sven Eckelmann wrote:
> On Tuesday 07 December 2010 15:39:32 Linus Lüssing wrote:
> > +	memcpy(skb_put(skb, packet_len), batman_if->ndp_packet_buff,
> > +	       packet_len);
> > +
> > +	send_skb_packet(skb, batman_if, broadcast_addr);
> 
> > --- a/types.h
> > +++ b/types.h
> > @@ -47,6 +47,7 @@ struct batman_if {
> >  	struct packet_type batman_adv_ptype;
> >  	struct net_device *soft_iface;
> >  	struct rcu_head rcu;
> > +	unsigned char *ndp_packet_buff;
> 
> Good way to never get included in the linux kernel by David S. Miller.
> 
> Best regards,
> 	Sven

Argh, damn it, you noticed my secret plan and attempt to sabotage
batman-adv's inclussion into the linux kernel...

Well, anyway, thanks for having a glance at it, I'll send a fixup
soon :).

Cheers, Linus
