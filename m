Return-Path: <linus.luessing@web.de>
Date: Mon, 14 Jul 2014 18:28:52 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140714162852.GO2675@Linus-Debian>
References: <1405081595-23371-1-git-send-email-martin@hundeboll.net>
 <1405081595-23371-5-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1405081595-23371-5-git-send-email-martin@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH 05/13] batman-adv: kernel doc fix for
 multicast.h
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
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>

On Fri, Jul 11, 2014 at 02:26:27PM +0200, Martin Hundebøll wrote:
> Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
> ---
>  multicast.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/multicast.h b/multicast.h
> index 73b5d45..d790a71 100644
> --- a/multicast.h
> +++ b/multicast.h
> @@ -19,7 +19,7 @@
>  #define _NET_BATMAN_ADV_MULTICAST_H_
>  
>  /**
> - * batadv_forw_mode - the way a packet should be forwarded as
> + * enum batadv_forw_mode - the way a packet should be forwarded as
>   * @BATADV_FORW_ALL: forward the packet to all nodes (currently via classic
>   *  flooding)
>   * @BATADV_FORW_SINGLE: forward the packet to a single node (currently via the
> -- 
> 2.0.1
> 

Acked-by: Linus Lüssing <linus.luessing@web.de>
