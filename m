Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 2 May 2014 13:06:43 +0200
References: <1397733571-1531-1-git-send-email-sven@open-mesh.com>
In-Reply-To: <1397733571-1531-1-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201405021306.43493.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] alfred: Handle EPERM on every sendto
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@open-mesh.com>

> The announcements are currently only sent by alfred instances in master
> mode. Slave instances don't announce themself and thus don't detect the
> broken socket. To also catch such problems, it is useful to handle the
> detection of EPERM during the send in send_alfred_packet which is always
> called when a link-local UDP packet is send over the network.
> 
> Signed-off-by: Sven Eckelmann <sven@open-mesh.com>

Sorry, I forgot to reply:

Both patches have been merged:

839cfd5 alfred: Check for changed interface properties
fcd4b0a alfred: Handle EPERM on every sendto

Thank you!!
   Simon

> ---
>  send.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/send.c b/send.c
> index 89e9c07..dc0e428 100644
> --- a/send.c
> +++ b/send.c
> @@ -32,7 +32,6 @@
> 
>  int announce_master(struct globals *globals)
>  {
> -	ssize_t ret;
>  	struct alfred_announce_master_v0 announcement;
> 
>  	if (globals->netsock < 0)
> @@ -42,14 +41,8 @@ int announce_master(struct globals *globals)
>  	announcement.header.version = ALFRED_VERSION;
>  	announcement.header.length = htons(0);
> 
> -	ret = send_alfred_packet(globals, &in6addr_localmcast, &announcement,
> -				 sizeof(announcement));
> -	if (ret == -EPERM) {
> -		fprintf(stderr, "Error during announcement\n");
> -		netsock_close(globals->netsock);
> -		globals->netsock = -1;
> -	}
> -
> +	send_alfred_packet(globals, &in6addr_localmcast, &announcement,
> +			   sizeof(announcement));
> 
>  	return 0;
>  }
> @@ -176,6 +169,11 @@ ssize_t send_alfred_packet(struct globals *globals,
> const struct in6_addr *dest, ret = sendto(globals->netsock, buf, length,
> 0,
>  		     (struct sockaddr *)&dest_addr,
>  		     sizeof(struct sockaddr_in6));
> +	if (ret == -EPERM) {
> +		fprintf(stderr, "Error during sent\n");
> +		netsock_close(globals->netsock);
> +		globals->netsock = -1;
> +	}
> 
>  	return ret;
>  }
