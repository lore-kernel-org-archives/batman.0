Return-Path: <davem@davemloft.net>
Date: Tue, 13 Nov 2012 14:24:01 -0500 (EST)
Message-Id: <20121113.142401.1673481049958731174.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1352798139-19458-2-git-send-email-ordex@autistici.org>
References: <1352798139-19458-1-git-send-email-ordex@autistici.org>
 <1352798139-19458-2-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 01/11] batman-adv: don't rely on
 positions in struct for hashing
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
To: ordex@autistici.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, siwu@hrz.tu-chemnitz.de

From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 13 Nov 2012 10:15:29 +0100

> @@ -37,18 +37,26 @@ static void batadv_bla_periodic_work(struct work_struct *work);
>  static void batadv_bla_send_announce(struct batadv_priv *bat_priv,
>  				     struct batadv_backbone_gw *backbone_gw);
>  
> +static inline void hash_bytes(uint32_t *hash, void *data, uint32_t size)
> +{
> +	const unsigned char *key = data;
> +	int i;
> +
> +	for (i = 0; i < size; i++) {
> +		*hash += key[i];
> +		*hash += (*hash << 10);
> +		*hash ^= (*hash >> 6);
> +	}
> +}
> +

Remove the inline tag.

Return the uint32_t resulting hash value rather than passing it by
reference.
