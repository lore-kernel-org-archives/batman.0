Return-Path: <andrew@lunn.ch>
Date: Thu, 28 Jan 2010 07:29:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100128062946.GA14813@lunn.ch>
References: <20100123174616.GA4795@Sellars>
	<201001261516.39057.lindner_marek@yahoo.de>
	<20100127001049.GA15002@Linus-Debian>
	<201001280809.58159.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201001280809.58159.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] slowpath warning
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

On Thu, Jan 28, 2010 at 08:09:57AM +0800, Marek Lindner wrote:
> 
> Hi,
> 
> > nope, does not seem to work, still the same issue
> > I also tried it on my laptop here with the patch installed 
> > and it is a very similar call trace, although here it is 
> > send_vis_packets instead of vis_quit in the call trace.
> 
> you should take the stack trace with a grain of salt. Stack tracing such an 
> issue is a quite tricky thing, hence can not be fully trusted. Since the skb 
> changes the code runs in interrupt context which probably introduced this bug. 
> All previous warnings of this kind were related to holding a lock while 
> sending packets. My patch unlocked the problematic orig_hash - maybe that was 
> not enough ? By adding retrun statements at the beginning of the vis send 
> function you might be able to get down to the problem.

It might also be worth running lockdep on the code. Normally you don^t
need the actually lockup, you just need to execute the code path that
would lockup under whatever conditions are required for it to lockup.

      Andrew
