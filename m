Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 13 Jun 2016 21:26:43 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160613192643.GJ3293@otheros>
References: <lsq.1465842997.838358341@decadent.org.uk>
 <lsq.1465842997.536267398@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lsq.1465842997.536267398@decadent.org.uk>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3.16 046/114] batman-adv: Fix
 broadcast/ogm queue limit on a removed interface
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Marek Lindner <mareklindner@neomailbox.ch>, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, akpm@linux-foundation.org

On Mon, Jun 13, 2016 at 07:36:37PM +0100, Ben Hutchings wrote:
> 3.16.36-rc1 review patch.  If anyone has any objections, please let me know.
> 

Hi Ben,

This one looks weird. The version you added for 3.2.81-rc1 looked
better.

Cheers, Linus



> ------------------
> 
> From: Linus Lüssing <linus.luessing@c0d3.blue>
> 
> commit c4fdb6cff2aa0ae740c5f19b6f745cbbe786d42f upstream.
> 
> When removing a single interface while a broadcast or ogm packet is
> still pending then we will free the forward packet without releasing the
> queue slots again.
> 
> This patch is supposed to fix this issue.
> 
> Fixes: 6d5808d4ae1b ("batman-adv: Add missing hardif_free_ref in forw_packet_free")
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> [sven@narfation.org: fix conflicts with current version]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  net/batman-adv/send.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- a/net/batman-adv/send.c
> +++ b/net/batman-adv/send.c
> @@ -638,6 +638,12 @@ batadv_purge_outstanding_packets(struct
>  
>  		if (pending) {
>  			hlist_del(&forw_packet->list);
> +			if (!forw_packet->own)
> +				atomic_inc(&bat_priv->bcast_queue_left);
> +
> +			if (!forw_packet->own)
> +				atomic_inc(&bat_priv->batman_queue_left);
> +
>  			batadv_forw_packet_free(forw_packet);
>  		}
>  	}
> 
