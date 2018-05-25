Return-Path: <sergei.shtylyov@cogentembedded.com>
References: <20180524120300.15829-1-sw@simonwunderlich.de>
 <20180524120300.15829-3-sw@simonwunderlich.de>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <fec8128d-0021-74db-b047-305fb1f70104@cogentembedded.com>
Date: Fri, 25 May 2018 13:33:59 +0300
MIME-Version: 1.0
In-Reply-To: <20180524120300.15829-3-sw@simonwunderlich.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/8] batman-adv: Disable
 CONFIG_BATMAN_ADV_DEBUGFS by default
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>

Hello!

On 5/24/2018 3:02 PM, Simon Wunderlich wrote:

> From: Sven Eckelmann <sven@narfation.org>
> 
> All tools which were known to the batman-adv development team are
> supporting the batman-adv netlink interface since a while. Also debugfs is
> not supported for batman-adv interfaces in any non-default netns. Thus
> disabling CONFIG_BATMAN_ADV_DEBUGFS by default should not cause problems on
> most systems. It is still possible to enable it in case it is still
> required in a specific setup.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>   net/batman-adv/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
> index e4e2e02b7380..bee034a95208 100644
> --- a/net/batman-adv/Kconfig
> +++ b/net/batman-adv/Kconfig
> @@ -94,13 +94,13 @@ config BATMAN_ADV_DEBUGFS
>   	bool "batman-adv debugfs entries"
>   	depends on BATMAN_ADV
>   	depends on DEBUG_FS
> -	default y
> +	default n

    N is the default default. :-) You don't need this line.

[...]

MBR, Sergei
