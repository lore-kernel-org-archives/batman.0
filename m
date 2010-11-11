Return-Path: <gregkh@suse.de>
Date: Wed, 10 Nov 2010 17:11:37 -0800
From: Greg KH <gregkh@suse.de>
Message-ID: <20101111011137.GA23112@suse.de>
References: <12893476522148@site> <201011101117.03979.lindner_marek@yahoo.de>
	<20101110160455.GC10561@suse.de>
	<201011101746.42904.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201011101746.42904.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] patch "staging: batman-adv:
	Use	linux/etherdevice.h address helper functions" added to
	staging tree
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: tklauser@distanz.ch, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, siwu@hrz.tu-chemnitz.de

On Wed, Nov 10, 2010 at 05:46:37PM +0100, Sven Eckelmann wrote:
> On Wednesday 10 November 2010 17:04:55 Greg KH wrote:
> > > I'm wondering why you accepted this patch despite the raised objections
> > > regarding alignment problems. [1][2]
> > 
> > Because at the end of that thread, it sounded like you all agreed that
> > this patch was acceptable.
> > 
> > If not, then please let me know and I will revert it.
> 
> The end of the thread was that he should remove parts of the patch and resent 
> it - or prove that all the data is 2 bytes aligned.
> 
> 
> On Wednesday 03 November 2010 11:56:19 Sven Eckelmann wrote:
> [...]
> > > I don't think they need to be two bytes aligned, but I might be wrong.
> > 
> > compare_ether_addr uses a two byte pointer to access 3x two bytes. This
> > makes it necessary to have all those 3 bytes aligned to 2 byte boundaries.
> [correction sent later: "6x two bytes aligned to 2 byte boundaries"]
> > Otherwise the compiler has to generate special instructions on
> > architectures which don't support loads on non-aligned addresses. Usually
> > he doesn't do it unless he has some indications that it is necessary
> > (__attribute__ ((packed)) for example).
> > 
> > There is also documentation available on that topic in
> > Documentation/unaligned-memory-access.txt
> > 
> > And maybe it is good to use is_broadcast_ether_addr, but leave
> > compare_ether_addr part open (or prove that we always have those two
> > operands correctly aligned).
> [...]
> 
> None of that happened yet. And yes, this wasn't the last mail we sent to him 
> to get some response - no answer till now.

Oops, my fault, I've now reverted this patch, sorry about that.

thanks,

greg k-h
