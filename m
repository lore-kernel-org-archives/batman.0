Return-Path: <rdunlap@infradead.org>
Subject: Re: [PATCH 4/4] batman-adv: Fix names for kernel-doc blocks
References: <20210208165938.13262-1-sw@simonwunderlich.de>
 <20210208165938.13262-5-sw@simonwunderlich.de>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <44df86a7-e7a9-246a-e941-a7ec6f4c8774@infradead.org>
Date: Mon, 8 Feb 2021 10:00:48 -0800
MIME-Version: 1.0
In-Reply-To: <20210208165938.13262-5-sw@simonwunderlich.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>, kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>

On 2/8/21 8:59 AM, Simon Wunderlich wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> kernel-doc can only correctly identify the documented function or struct
> when the name in the first kernel-doc line references it. But some of the
> kernel-doc blocks referenced a different function/struct then it actually
> documented.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  net/batman-adv/distributed-arp-table.c | 2 +-
>  net/batman-adv/multicast.c             | 2 +-
>  net/batman-adv/netlink.c               | 4 ++--
>  net/batman-adv/tp_meter.c              | 2 +-
>  net/batman-adv/types.h                 | 3 ++-
>  5 files changed, 7 insertions(+), 6 deletions(-)


-- 
~Randy

