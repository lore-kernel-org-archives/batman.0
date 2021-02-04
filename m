Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Wed, 3 Feb 2021 16:33:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 1/4] batman-adv: Start new development cycle
Message-ID: <20210203163302.13e8a2a7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210202174037.7081-2-sw@simonwunderlich.de>
References: <20210202174037.7081-1-sw@simonwunderlich.de>
	<20210202174037.7081-2-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

On Tue,  2 Feb 2021 18:40:33 +0100 Simon Wunderlich wrote:
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  net/batman-adv/main.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
> index 288201630ceb..2486efe4ffa6 100644
> --- a/net/batman-adv/main.h
> +++ b/net/batman-adv/main.h
> @@ -13,7 +13,7 @@
>  #define BATADV_DRIVER_DEVICE "batman-adv"
>  
>  #ifndef BATADV_SOURCE_VERSION
> -#define BATADV_SOURCE_VERSION "2021.0"
> +#define BATADV_SOURCE_VERSION "2021.1"
>  #endif
>  
>  /* B.A.T.M.A.N. parameters */

For just comment adjustments and the sizeof() change?
