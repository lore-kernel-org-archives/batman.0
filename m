Return-Path: <ordex@autistici.org>
Date: Mon, 27 Jun 2011 13:32:15 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110627113215.GC30872@ritirata.org>
References: <1309091169-27226-1-git-send-email-ordex@autistici.org>
	<1309127157-32507-1-git-send-email-ordex@autistici.org>
	<20110627053319.GH12315@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110627053319.GH12315@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: pass a unique flag arg
 instead of a sequence of bool ones
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

Hi Andrew,

On Mon, Jun 27, 2011 at 07:33:19AM +0200, Andrew Lunn wrote:
> Hi Antonio
> 
> > +	/* NOPURGE flag has not to go on the wire */
> > +	flags &= ~TT_CLIENT_NOPURGE;
> >  
> > +	tt_change_node->change.flags = flags;
> 
> I don't remember the packet format. But i assume flags on the wire is
> a u8? How about making TT_CLIENT_NOPURGE 1<<8 or bigger, so it is
> automatically not sent on the wire? It will also make it easier
> sometime in the future when you want to use the bit on the wire that
> TT_CLIENT_NOPURGE is currently taking.
> 

Even if we want to add other flags that don't need to be sent on the
wire. I like this idea.

We can have a uint16_t flags field in the
tt_local/global_entry structure, where the 8 tailing bits only are sent
within the messages. Instead, the 8 leading bits are reserved for local purposes.

> You might also want to change the function parameters flags from int
> to uint, so avoiding sign extension problems.

Yes, thanks!

> 
>    Andrew


-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
