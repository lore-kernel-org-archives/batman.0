Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 2 Apr 2013 16:41:31 +0800
References: <1364760198-17043-1-git-send-email-ordex@autistici.org>
 <1364760198-17043-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1364760198-17043-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304021641.31457.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batctl: tcpdump - print subtype for
	UNICAST4ADDR packets
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

On Monday, April 01, 2013 04:03:18 Antonio Quartulli wrote:
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  tcpdump.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tcpdump.c b/tcpdump.c
> index 39239dd..bf4edd4 100644
> --- a/tcpdump.c
> +++ b/tcpdump.c
> @@ -562,7 +562,8 @@ static void dump_batman_4addr(unsigned char
> *packet_buff, ssize_t buff_len, int
> 
>  	printf("%s: 4ADDR, subtype %d, ttvn %d, ttl %hhu, ",
>  	       get_name_by_macaddr((struct ether_addr *)unicast_4addr_packet->u.dest, read_opt),
>  -	       unicast_4addr_packet->u.ttvn, unicast_4addr_packet->u.header.ttl); 
>  +	       unicast_4addr_packet->subtype, unicast_4addr_packet->u.ttvn, 
>  +	       unicast_4addr_packet->u.header.ttl);
> 

You added the subtype printf format string with the previous patch 
already. You might want to fix this.

Cheers,
Marek
