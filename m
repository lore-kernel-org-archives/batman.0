Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Tue, 27 Dec 2022 12:58:41 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH v3 3/5] batman-adv: mcast: implement multicast packet
 reception and forwarding
Message-ID: <Y6rd8cwPi8JqTbkN@sellars>
References: <20221226204237.10403-1-linus.luessing@c0d3.blue>
 <20221226204237.10403-4-linus.luessing@c0d3.blue>
 <8399468.NyiUUSuA9g@sven-l14>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8399468.NyiUUSuA9g@sven-l14>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tue, Dec 27, 2022 at 10:07:36AM +0100, Sven Eckelmann wrote:
> ecsv/pu: checkpatch ./net/batman-adv/multicast_forw.c
> -----------------------------------------------------
> 
>     CHECK: Macro argument reuse 'num_dests' - possible side-effects?
>     #25: FILE: ./net/batman-adv/multicast_forw.c:25:
>     +#define batadv_mcast_forw_tracker_for_each_dest(dest, num_dests) \
>     +   for (; num_dests; num_dests--, (dest) += ETH_ALEN)
>     
>     total: 0 errors, 0 warnings, 1 checks, 274 lines checked
> 

For this I'm not quite sure how to best silence this. I tried
the workaround of passing num_dests as a pointer and dereferencing
it inside the macro:

#define batadv_mcast_forw_tracker_for_each_dest(dest, num_dests) \
        for (; (*(num_dests)); (*(num_dests))--, (dest) += ETH_ALEN)

So just like you'd do if you would want intentional side-effects with
a normal function. But seems like checkpatch does not recoginze it.

Also all the other for_each macros in the kernel code have
side-effects, as far as I know?

Or would you have another idea?
