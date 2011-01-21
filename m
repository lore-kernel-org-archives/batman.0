Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 21 Jan 2011 18:26:07 +0100
References: <1295563736-27526-1-git-send-email-sven@narfation.org>
	<1295564419-28216-2-git-send-email-sven@narfation.org>
In-Reply-To: <1295564419-28216-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201101211826.08385.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: Calculate correct size
	for merged packets
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

On Friday 21 January 2011 00:00:19 Sven Eckelmann wrote:
> This patch is completely untested and is currently only to support marec
> and russell-- during their debugging sessions. Maybe it doesn't even
> compile.

Thanks Sven! I think this is another bugfix we'll need for the fragmentation.


> --- a/batman-adv/routing.c
> +++ b/batman-adv/routing.c
> @@ -1243,6 +1243,28 @@ static int check_unicast_packet(struct sk_buff *skb,
> int hdr_size) return 0;
>  }
> 
> +static int frag_can_reassemble(struct sk_buff *skb, int mtu)

I'd suggest we move this function into unicast.c to let it join all the other 
fragmentation related functions there. 
Apart from that it looks good. We might want to do some more testing though.

Regards,
Marek
