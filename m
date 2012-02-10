Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 10 Feb 2012 22:21:19 +0800
References: <1328830902-11574-1-git-send-email-ordex@autistici.org>
	<1328830902-11574-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1328830902-11574-5-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201202102221.20158.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 4/9] batman-adv: Distributed ARP Table
	- add ARP parsing functions
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

On Friday, February 10, 2012 07:41:37 Antonio Quartulli wrote:
> +#define ARP_HW_SRC(skb) ((uint8_t *)(skb->data) + sizeof(struct ethhdr) +
> \ +                       sizeof(struct arphdr))

You could replace all occurences of "sizeof(struct ethhdr)" with ETH_HLEN.

Cheers,
Marek
