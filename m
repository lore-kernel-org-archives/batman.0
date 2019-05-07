Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 7 May 2019 06:22:53 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/6] batman-adv: Add routeable multicast
 optimizations
Message-ID: <20190507042253.GA1493@otheros>
References: <20190424011919.9821-1-linus.luessing@c0d3.blue>
 <12977711.pgt7cpdoR5@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12977711.pgt7cpdoR5@sven-edge>
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

On Sun, May 05, 2019 at 07:37:48PM +0200, Sven Eckelmann wrote:
> ecsv/pu: headers
> ----------------
> 
>     diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
>     index ca4898d3..f106728b 100644
>     --- a/net/batman-adv/multicast.c
>     +++ b/net/batman-adv/multicast.c
>     @@ -23,7 +23,6 @@
>      #include <linux/inetdevice.h>
>      #include <linux/ip.h>
>      #include <linux/ipv6.h>
>     -#include <linux/jiffies.h>
>      #include <linux/kernel.h>
>      #include <linux/kref.h>
>      #include <linux/list.h>

I did not make any changes to this as I believe jiffies.h is still
needed for msecs_to_jiffies()?

The rest should be addressed in the new patchsets.
