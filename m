Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 7 Dec 2015 23:12:42 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20151207221242.GR27041@otheros>
References: <1448305042-5806-1-git-send-email-sw@simonwunderlich.de>
 <1448305042-5806-2-git-send-email-sw@simonwunderlich.de>
 <56591657.6070401@meshcoding.com> <8889525.bHy7H9IMLu@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8889525.bHy7H9IMLu@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: fix lockdep splat when
 doing mcast_free
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
Cc: Simon Wunderlich <simon@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>

Hi,

Sorry for the late reply, I had also missed the Sven's
lockdep-assert-patch back then.

> On Saturday 28 November 2015 10:49:59 Antonio Quartulli wrote:
> > Linus,
> > 
> > can you please comment as of why batadv_mcast_mla_tt_retract() requires
> > to hold the tt.commit_lock ?

I don't think it does. At least if you say that a call to
batadv_tt_local_remove() as is does not need it (and it seems
there are other places calling tt_local_remove() without this
lock, too).

> [...]

On Sat, Nov 28, 2015 at 09:21:02AM +0100, Sven Eckelmann wrote:
> mcast.mla_list is protected by tt.commit_lock (see batadv_mcast_mla_tt_add,
> batadv_mcast_mla_list_free and batadv_mcast_mla_tt_retract).
> 

mcast.mla_list changes should be protected by the non-parallel code
flow: During runtime, batadv_mcast_mla_tt_update() is only called from
the self-rearming OGM scheduler thread -
batadv_mcast_mla_tt_update() will never run more than once at the
same time.

The second place for mcast.mla_list changes, batadv_mcast_free(), is
called only on shutdown after the OGM scheduling thread was stopped.


I don't think there should be such races regarding mcast.mla_list
- was something like that observed in the wild which lead to inserting
the lockdep-asserts?

Cheers, Linus
