Return-Path: <antonio@meshcoding.com>
Message-ID: <52A08DF4.3020604@meshcoding.com>
Date: Thu, 05 Dec 2013 15:30:12 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <529FD011.2090508@meshcoding.com>
 <1386253212-998-1-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1386253212-998-1-git-send-email-antonio@meshcoding.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 next 3/4] batman-adv: fix size of
	batadv_icmp_header
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

On 05/12/13 15:20, Antonio Quartulli wrote:

>  struct batadv_icmp_header {
>  	uint8_t  packet_type;
>  	uint8_t  version;
>  	uint8_t  ttl;
> -	uint8_t  msg_type; /* see ICMP message types above */

I think we should keep this comment. I'm going to send v3.

Cheers,

> +	uint8_t  msg_type;
>  	uint8_t  dst[ETH_ALEN];
>  	uint8_t  orig[ETH_ALEN];
>  	uint8_t  uid;
> +	uint8_t  align[3];
>  };

-- 
Antonio Quartulli
