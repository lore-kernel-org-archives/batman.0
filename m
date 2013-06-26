Return-Path: <linus.luessing@web.de>
Date: Wed, 26 Jun 2013 11:38:00 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130626093800.GC22334@Linus-Debian>
References: <1371232209-7808-1-git-send-email-linus.luessing@web.de>
 <1371232209-7808-2-git-send-email-linus.luessing@web.de>
 <201306250547.20341.lindner_marek@yahoo.de>
 <20130625125508.GA20017@Linus-Debian>
 <20130625130316.GC3136@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130625130316.GC3136@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv6 1/3] batman-adv: Multicast Listener
 Announcements via Translation Table
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

On Tue, Jun 25, 2013 at 03:03:16PM +0200, Antonio Quartulli wrote:
> > > All struct defines should go into types.h or packet.h if they are sent over 
> > > the wire.

I just noticed that I had misread this sentence as: "All struct
defines which are sent over the wire go into types.h or packet.h"

> > 
> > This struct isn't sent over the wire, it's just for local book
> > keeping. I was thinking about naming it 'struct batadv_mcast_hw_addr'
> > but didn't do that because it is so generic and thought maybe
> > because of that it might be reusable in the future.
> > 
> > Hm, maybe it's better to rename it to 'struct
> > batadv_mcast_hw_addr' anyways and leave it in that place to avoid
> > bloating types.h/packet.h with "unimportant" structs and defines?
> 
> I think this struct should go into type.h too. Many structs in there are used by
> a single component only, but it is better to keep them into the same file.
> And yes, renaming to batadv_mcast_hw_addr is probably better (given that it is
> used by the mcast component only).

And now this makes sense :). I'm going to move it into types.h (and
will keep the name as batadv_hw_addr).

> 
> Cheers,
> 
> -- 
> Antonio Quartulli
> 
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara


