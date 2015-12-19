Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 19 Dec 2015 09:04:05 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20151219080405.GJ30160@otheros>
References: <1448901241-30844-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1448901241-30844-1-git-send-email-sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: fix lockdep splat when
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
Cc: Simon Wunderlich <simon@open-mesh.com>

> From: Simon Wunderlich <simon@open-mesh.com>
> 
> While testing, we got something like this:
> 
> WARNING: CPU: 0 PID: 238 at net/batman-adv/multicast.c:142 batadv_mcast_mla_tt_retract+0x94/0x205 [batman_adv]()
> [...]
> Call Trace:
> [<ffffffff815fc597>] dump_stack+0x4b/0x64
> [<ffffffff810b34dc>] warn_slowpath_common+0xbc/0x120
> [<ffffffffa0024ec5>] ? batadv_mcast_mla_tt_retract+0x94/0x205 [batman_adv]
> [<ffffffff810b3705>] warn_slowpath_null+0x15/0x20
> [<ffffffffa0024ec5>] batadv_mcast_mla_tt_retract+0x94/0x205 [batman_adv]
> [<ffffffffa00273fe>] batadv_mcast_free+0x36/0x39 [batman_adv]
> [<ffffffffa0020c77>] batadv_mesh_free+0x7d/0x13f [batman_adv]
> [<ffffffffa0036a6b>] batadv_softif_free+0x15/0x25 [batman_adv]
> [...]
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>

Fixes: 5b95c427d187 ("batman-adv: Annotate deleting functions with external lock via lockdep")
Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
