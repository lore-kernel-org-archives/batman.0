Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 11 Feb 2012 21:59:57 +0800
References: <1328830902-11574-1-git-send-email-ordex@autistici.org>
	<1328830902-11574-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1328830902-11574-4-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201202112159.58282.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 3/9] batman-adv: Distributed ARP Table
	- create DHT helper functions
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

On Friday, February 10, 2012 07:41:36 Antonio Quartulli wrote:
> +       for (select = 0; select < DHT_CANDIDATES_NUM; select++) {
> +               max = 0;
> +               max_orig_node = NULL;
> +               if (!chosen_me) {
> +                       /* if true, wrap around the key space */
> +                       if (bat_priv->dht_hash > ip_key)
> +                               max = DAT_ADDR_MAX - bat_priv->dht_hash +
> +                                       ip_key;
> +                       else
> +                               max = ip_key - bat_priv->dht_hash;
> +                       max = bat_priv->dht_hash;

Somehow this does not make sense to me. Why do we calculate a magic value for 
"max" if we set it to bat_priv->dht_hash afterwards ?
Moreover, the name dht_hash is a bit confusing. At first I thought it is a 
pointer to a hash (read: orig_hash/tt_local_hash/tt_global_hash/etc). Perhaps 
the comment should explain what and why the magic is supposed to achieve 
instead of stating what the c code is obviously doing ?

Cheers,
Marek
