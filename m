Return-Path: <andrew@lunn.ch>
Date: Sat, 1 May 2010 16:12:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100501141215.GO3734@lunn.ch>
References: <201005011533.41592.sven.eckelmann@gmx.de>
	<1272721576-9372-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1272721576-9372-1-git-send-email-sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Staging: batman-adv: send.c: Checkpatch
 cleanup
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Sat, May 01, 2010 at 03:46:16PM +0200, Sven Eckelmann wrote:
> From: Andrea Gelmini <andrea.gelmini@gelma.net>
> 
> drivers/staging/batman-adv/send.c:137: CHECK: multiple assignments should be avoided
> 
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
>  drivers/staging/batman-adv/send.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
> index 2a9fac8..ff7b1f1 100644
> --- a/drivers/staging/batman-adv/send.c
> +++ b/drivers/staging/batman-adv/send.c
> @@ -134,7 +134,8 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
>  	if (batman_if->if_active != IF_ACTIVE)
>  		return;
>  
> -	packet_num = buff_pos = 0;
> +	packet_num = 0;
> +	buff_pos = 0;
>  	batman_packet = (struct batman_packet *)
>  		(forw_packet->packet_buff);
>  
> -- 

I was too lazy to go searching upstream. We can just import this patch
and use your three checkpatch patches.

    Andrew
