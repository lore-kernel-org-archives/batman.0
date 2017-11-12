Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 12 Nov 2017 20:55:43 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20171112195543.GD1589@otheros>
References: <lsq.1510009377.526284287@decadent.org.uk>
 <lsq.1510009382.466414456@decadent.org.uk>
 <20171107011651.GB1873@otheros>
 <1510062155.2748.128.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1510062155.2748.128.camel@decadent.org.uk>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3.16 076/294] batman-adv: fix TT sync
 flag inconsistencies
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, akpm@linux-foundation.org, Antonio Quartulli <a@unstable.cc>, Simon Wunderlich <sw@simonwunderlich.de>

Hi Ben,

On Tue, Nov 07, 2017 at 01:42:35PM +0000, Ben Hutchings wrote:
> That function didn't exist in 3.16 (at least not under that name).

Ah, you're right, back then the netlink interface did not
exist in batman-adv yet, only the debugfs one.
batadv_tt_global_print_entry would be the equivalent function
for debugfs. But not worth the effort now, in my opinion.

I'm fine with this proposed patch for 3.16 now. Thanks for the
clarification! And I'm happy to see this patch backported.

Regards, Linus
