Return-Path: <dsahern@gmail.com>
References: <20171007121853.6278-1-sven@narfation.org>
 <20171007122122.6470-1-sven@narfation.org>
From: David Ahern <dsahern@gmail.com>
Message-ID: <514099d9-571b-f1c3-11a3-46f759cccc0d@gmail.com>
Date: Sat, 7 Oct 2017 08:23:44 -0600
MIME-Version: 1.0
In-Reply-To: <20171007122122.6470-1-sven@narfation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Add missing kerneldoc
 for extack
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: davem@davemloft.net, netdev@vger.kernel.org

On 10/7/17 6:21 AM, Sven Eckelmann wrote:
> The parameter extack was added to batadv_softif_slave_add without adding
> the kernel-doc for it. This caused kernel-doc warnings.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Cc: David Ahern <dsahern@gmail.com>
> ---
>  net/batman-adv/soft-interface.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
> index 543d2c3e..9f673cdf 100644
> --- a/net/batman-adv/soft-interface.c
> +++ b/net/batman-adv/soft-interface.c
> @@ -863,6 +863,7 @@ static int batadv_softif_init_late(struct net_device *dev)
>   * batadv_softif_slave_add - Add a slave interface to a batadv_soft_interface
>   * @dev: batadv_soft_interface used as master interface
>   * @slave_dev: net_device which should become the slave interface
> + * @extack: extended ACK report struct
>   *
>   * Return: 0 if successful or error otherwise.
>   */
> 

Thanks for the cleanup.

Acked-by: David Ahern <dsahern@gmail.com>
