Return-Path: <andrew@lunn.ch>
Date: Wed, 23 Nov 2011 16:47:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20111123154701.GB2656@lunn.ch>
References: <1321915993-29312-1-git-send-email-ordex@autistici.org>
	<1321915993-29312-5-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1321915993-29312-5-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 4/7] batman-adv: Distributed ARP Table
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

On Mon, Nov 21, 2011 at 11:53:10PM +0100, Antonio Quartulli wrote:

Hi Antonio

> +/* Returns arphdr->ar_op if the skb contains a valid ARP packet, otherwise
> + * returns 0 */
> +uint16_t arp_get_type(struct bat_priv *bat_priv, struct sk_buff *skb)
> +{
> +	struct arphdr *arphdr;
> +	struct ethhdr *ethhdr;
> +	uint16_t type = 0;
> +	char buf[30], *type_str[] = { "REQUEST", "REPLY", "RREQUEST", "RREPLY",
> +				      "InREQUEST", "InREPLY", "NAK" };

type_str could be marked as const. Saves a little bit of space on the
BSS.

> +
> +	if (type >= 1 && type <= 10)
> +		scnprintf(buf, 30, "%s", type_str[type - 1]);

type_str currently has 6 entries, so if somebody sends you an ARP
request with type greater than 6, you go off the end of the
array. Better to use ARRAY_SIZE().

       Andrew
