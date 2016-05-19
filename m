Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 19 May 2016 21:45:53 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160519194553.GD12565@otheros>
References: <1462525107-19750-1-git-send-email-apape@phoenixcontact.com>
 <1462525107-19750-3-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1462525107-19750-3-git-send-email-apape@phoenixcontact.com>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/6] batman-adv: speed up dat by
 snooping received ip traffic
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

On Fri, May 06, 2016 at 10:58:23AM +0200, Andreas Pape wrote:
> +void batadv_dat_entry_check(struct batadv_priv *bat_priv, struct sk_buff *skb,
> +			    unsigned short vid)
> +{
[...]
> +	if (iphdr) {
> +		batadv_dbg(BATADV_DBG_DAT, bat_priv,
> +			   "Snooped IP address: %pI4 %pM (vid: %d)\n",
> +			   &iphdr->saddr, ethhdr->h_source,
> +			   BATADV_PRINT_VID(vid));
> +		batadv_dat_entry_add(bat_priv, iphdr->saddr,
> +				     ethhdr->h_source, vid);
> +	}

Not sure whether it is necessary, or whether there is a check
somewhere later within DAT. But should we exclude some
iphdr->saddr or ethhdr->h_source addresses? For instance a
DHCPDISCOVER usually has a zero-ip address.
