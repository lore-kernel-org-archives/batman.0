Return-Path: <joe@perches.com>
Message-ID: <1382547630.22433.23.camel@joe-AO722>
From: Joe Perches <joe@perches.com>
Date: Wed, 23 Oct 2013 10:00:30 -0700
In-Reply-To: <1382544303-2694-4-git-send-email-antonio@meshcoding.com>
References: <1382544303-2694-1-git-send-email-antonio@meshcoding.com>
 <1382544303-2694-4-git-send-email-antonio@meshcoding.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/16] batman-adv: add bat_orig_print API
	function
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, davem@davemloft.net, Antonio Quartulli <antonio@open-mesh.com>

On Wed, 2013-10-23 at 18:04 +0200, Antonio Quartulli wrote:
> Each routing protocol has its own metric and private
> variables, therefore it is useful to introduce a new API
> for originator information printing.
> 
> This API needs to be implemented by each protocol in order
> to provide its specific originator table output.
[]
> +static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
> +				     struct seq_file *seq)
[]
> +	seq_printf(seq, "  %-15s %s (%s/%i) %17s [%10s]: %20s ...\n",
> +		   "Originator", "last-seen", "#", BATADV_TQ_MAX_VALUE,
> +		   "Nexthop", "outgoingIF", "Potential nexthops");

This header printf really doesn't add much with the formatting sizes.
It's pretty obscure why some of these are sized and others not sized.
For instance: %-15s doesn't refer to a mac address size.
Perhaps it'd be better to just emit the fixed string just using
BATADV_TO_MAX_VALUE.  It'd also be easier to find via grep.


