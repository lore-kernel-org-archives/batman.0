Return-Path: <linus.luessing@c0d3.blue>
Date: Wed, 5 Jul 2017 07:59:40 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170705055939.GF3112@otheros>
References: <20170623154826.7792-1-linus.luessing@c0d3.blue>
 <3606832.Ug1eaxX1Ot@lafayette> <20170701173456.GB13650@otheros>
 <20170703040801.GD27857@prodigo.unstable.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170703040801.GD27857@prodigo.unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix TT sync flag
 inconsistencies
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

Hi Antonio,

Thanks for looking at it, too :-).

On Mon, Jul 03, 2017 at 12:08:01PM +0800, Antonio Quartulli wrote:
> [...]
> 
> Linus,
> 
> each originator announces flags covered by BATADV_TT_REMOTE_MASK (0x00FF),
> however you are extracting only those covered by BATADV_TT_SYNC_MASK (0x00F0).
> 
> Am I wrong or this is preventing the other 4 REMOTE flags (0x000F) to be set in
> tt_global_entry->common->flags (because you always filter them out when updating
> the entry)?

Hm, as far as I can tell, the ROAM flag is still set here:
http://elixir.free-electrons.com/linux/latest/source/net/batman-adv/translation-table.c#L787

And unset here:
http://elixir.free-electrons.com/linux/latest/source/net/batman-adv/translation-table.c#L1720

And the TEMP flag is unset here:
http://elixir.free-electrons.com/linux/latest/source/net/batman-adv/translation-table.c#L1702

And is set... hm, ok, was the TEMP flag set by the now deleted
"common->flags |= flags;"?

But then I'm confused, how would the TEMP flag have worked before
patch fa614fd04692? Or was that patch not only supposed to fix the
WIFI but also the TEMP flag?

If so, what would you prefer, should I replace the
"common->flags |= flags" with something like a
"common->flags |= flags & (~BATADV_TT_SYNC_MASK)"? Or would you
prefer setting the TEMP flag somewhere else explicitly, similarly
like we seemingly handle the ROAM flag explicitly, too?

Regards, Linus
