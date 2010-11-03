Return-Path: <tklauser@sym.noone.org>
Date: Wed, 3 Nov 2010 11:25:12 +0100
From: Tobias Klauser <tklauser@distanz.ch>
Message-ID: <20101103102512.GD10579@distanz.ch>
References: <1288778342-10056-1-git-send-email-tklauser@distanz.ch>
	<201011031112.20044.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201011031112.20044.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] staging: batman-adv: Use
	linux/etherdevice.h address	helper functions
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
Cc: devel@driverdev.osuosl.org, b.a.t.m.a.n@lists.open-mesh.org, Greg Kroah-Hartman <gregkh@suse.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Marek Lindner <lindner_marek@yahoo.de>

On 2010-11-03 at 11:12:12 +0100, Sven Eckelmann <sven.eckelmann@gmx.de> wrote:
> On Wednesday 03 November 2010 10:59:02 you wrote:
> > Replace custom ethernet address check functions by calls to the helpers
> > in linux/etherdevice.h
> 
> Have you proven that the addresses are always two bytes aligned in memory? 
> Afaik this function needs it.

I don't think they need to be two bytes aligned, but I might be wrong.

> > In one case where the address was tested for broadcast and multicast
> > address, the broadcast address check can be omitted as broadcast is also
> > a multicast address.
> 
> We need to distinguish between these two types for different optimizations 
> (research is currently done for multicast over mesh - but currently not part 
> of batman-adv).

I was refering to the following part of the patch:

-       if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest)) {
+       if (is_multicast_ether_addr(ethhdr->h_dest)) {

I think this change should be legitimate as the same branch is done for
multicast and broadcast addresses.

Thanks
Tobias
