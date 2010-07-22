Return-Path: <greg@kroah.com>
Date: Thu, 22 Jul 2010 14:30:07 -0700
From: Greg KH <greg@kroah.com>
Message-ID: <20100722213007.GA26362@kroah.com>
References: <1279664722-27500-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1279664722-27500-1-git-send-email-sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.36 (5)
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
Cc: b.a.t.m.a.n@lists.open-mesh.net

On Wed, Jul 21, 2010 at 12:25:19AM +0200, Sven Eckelmann wrote:
> Hi,
> 
> first thing: thanks for your help to get some review for batman-adv from davem
> and the netdev ml. I've added some new points to the TODO list. They are partly
> resolved or work is done to solve them, but will postpone them and get them
> hopefully ready and tested for 2.6.37.
> 
> Nevertheless there are some smaller changes which want to resolve with 2.6.36.
> One is to allow to build it together with dt3155 directly into the kernel and
> the other one should fix that we try to change stats of a different device. The
> latter one will clash with an unlucky try by the netdev guys to change the
> behaviour of dev_get_stats and the batman-adv source code.
> 
> This merge conflict is quite easy to resolve. Just delete the dev_get_stats
> line in hard-interface.c in batman_skb_recv and the new variable temp added by
> them.
> 
> I can also provide a patch on top of linux-next instead of staging-next-2.6 if
> you would prefer it in this situation. I will call it
> "[PATCH-next 1/3] Staging: batman-adv: Don't increment stats of foreign device"
> 
> I hope that it doesn't create more confusion as necessary. :)

I just applied the 3 patches, I shouldn't need to apply the other one on
top of -next, right?

thanks,

greg k-h
