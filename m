Return-Path: <linus.luessing@web.de>
Date: Tue, 15 Jul 2014 01:38:58 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140714233858.GW2675@Linus-Debian>
References: <538314FE.9020808@mindeye.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <538314FE.9020808@mindeye.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Init and use batman
 interface with correc netns.
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

On Mon, May 26, 2014 at 12:18:38PM +0200, Daniel Ehlers wrote:
> diff --git a/hard-interface.c b/hard-interface.c
> index b851cc5..c3497de 100644
> --- a/hard-interface.c
> +++ b/hard-interface.c
> @@ -31,6 +31,7 @@
>   #include <linux/if_arp.h>
>  #include <linux/if_ether.h>
> +#include <net/net_namespace.h>

These includes in the various, changed files seem unnecessary, too.
At least it compiles fine with out them for me, too.
