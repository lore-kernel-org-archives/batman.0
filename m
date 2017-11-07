Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 7 Nov 2017 02:16:51 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20171107011651.GB1873@otheros>
References: <lsq.1510009377.526284287@decadent.org.uk>
 <lsq.1510009382.466414456@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lsq.1510009382.466414456@decadent.org.uk>
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

Hi Ben!

On Mon, Nov 06, 2017 at 11:03:02PM +0000, Ben Hutchings wrote:
> 3.16.50-rc1 review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Linus Lüssing <linus.luessing@c0d3.blue>
> 
> commit 54e22f265e872ae140755b3318521d400a094605 upstream.
[...]
> [bwh: Backported to 3.16:
>  - Drop changes to batadv_tt_global_dump_subentry()

May I ask, were there specific concerns for stable 3.16 kernel
releases with this change?

It's not bothering me, but I'm currently wondering whether
this could cause some confusion to users.

Regards, Linus
