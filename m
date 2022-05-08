Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Sun, 8 May 2022 18:37:26 +0300
From: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH 1/2] batman-adv: Start new development cycle
Message-ID: <YnfjtpuAaH+Zkf9S@unreal>
References: <20220508132616.21232-1-sw@simonwunderlich.de>
 <20220508132616.21232-2-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508132616.21232-2-sw@simonwunderlich.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Simon Wunderlich <sw@simonwunderlich.de>, kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

On Sun, May 08, 2022 at 03:26:15PM +0200, Simon Wunderlich wrote:
> This version will contain all the (major or even only minor) changes for
> Linux 5.19.
> 
> The version number isn't a semantic version number with major and minor
> information. It is just encoding the year of the expected publishing as
> Linux -rc1 and the number of published versions this year (starting at 0).
> 
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  net/batman-adv/main.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
> index f3be82999f1f..23f3d53f4b51 100644
> --- a/net/batman-adv/main.h
> +++ b/net/batman-adv/main.h
> @@ -13,7 +13,7 @@
>  #define BATADV_DRIVER_DEVICE "batman-adv"
>  
>  #ifndef BATADV_SOURCE_VERSION
> -#define BATADV_SOURCE_VERSION "2022.1"
> +#define BATADV_SOURCE_VERSION "2022.2"

It is so not kernel-style. I recommend to drop this patch.

Thanks

>  #endif
>  
>  /* B.A.T.M.A.N. parameters */
> -- 
> 2.30.2
> 
