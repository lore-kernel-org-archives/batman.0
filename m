Return-Path: <andrew@lunn.ch>
Date: Tue, 17 May 2016 15:58:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160517135820.GA25569@lunn.ch>
References: <1463414932-1152-1-git-send-email-andrew@lunn.ch>
 <1646180.Hz16yHrbtt@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646180.Hz16yHrbtt@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 00/11] netns and netlink support
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

> headers ecsv/netlink
> --------------------
> 
>     diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
>     index 25fd4be..c5e6db5 100644
>     --- a/net/batman-adv/bat_v.c
>     +++ b/net/batman-adv/bat_v.c
>     @@ -19,9 +19,9 @@
>      #include "main.h"
>      
>      #include <linux/bug.h>
>     +#include <linux/cache.h>
>      #include <linux/errno.h>
>      #include <linux/if_ether.h>
>     -#include <linux/cache.h>
>      #include <linux/init.h>
>      #include <linux/jiffies.h>
>      #include <linux/netdevice.h>

So this is i think a false positive. Linus moved cache.h according the
git blame. Nothing to do with my patch.

>     diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
>     index 949a048..e0fd914 100644
>     --- a/net/batman-adv/netlink.c
>     +++ b/net/batman-adv/netlink.c
>     @@ -36,10 +36,10 @@
>      #include <net/sock.h>
>      #include <uapi/linux/batman_adv.h>
>      
>     -#include "originator.h"
>      #include "bridge_loop_avoidance.h"
>      #include "gateway_client.h"
>      #include "hard-interface.h"
>     +#include "originator.h"
>      #include "soft-interface.h"
>      #include "translation-table.h"

This one is interesting. I copied this from your
rebased_split_netlink/v4-0008-batman-adv-netlink-add-originator-and-neighbor-ta.patch

I did consider changing the order, but since you wrote it that way, it
must be O.K.

>     diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
>     index ef861db..fac7d91 100644
>     --- a/net/batman-adv/netlink.h
>     +++ b/net/batman-adv/netlink.h
>     @@ -18,12 +18,9 @@
>      #ifndef _NET_BATMAN_ADV_NETLINK_H_
>      #define _NET_BATMAN_ADV_NETLINK_H_
>      
>      #include "main.h"
>      
>     -#include <linux/compiler.h>
>     -#include <linux/genetlink.h>
>      #include <net/genetlink.h>
>     -#include <net/netlink.h>
>      
>      struct nlmsghdr;

Another false positive. These are from:

9492a25881c75ab9910328ff27834707c83df124

which has your Signed-off-by.

So overall, nothing useful in this report.

   Andrew


