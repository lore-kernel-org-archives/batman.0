Return-Path: <andrew@lunn.ch>
Date: Tue, 11 Feb 2014 18:22:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140211172212.GF24633@lunn.ch>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-9-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392122903-805-9-git-send-email-antonio@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 08/23] batman-adv: OGMv2 - implement
 originators logic
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

> +static struct batadv_orig_node *
> +batadv_v_ogm_orig_get(struct batadv_priv *bat_priv, const uint8_t *addr)
> +{
> +	struct batadv_orig_node *orig_node;
> +	int hash_added;
> +
> +	orig_node = batadv_orig_hash_find(bat_priv, addr);
> +	if (orig_node)
> +		return orig_node;
> +
> +	orig_node = batadv_orig_node_new(bat_priv, addr);

Can this fail and return NULL?

> +
> +	hash_added = batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
> +				     batadv_choose_orig, orig_node,
> +				     &orig_node->hash_entry);
> +	if (hash_added != 0) {
> +		batadv_orig_node_free_ref(orig_node);
> +		batadv_orig_node_free_ref(orig_node);

Looks odd. If it is correct, it should have a comment why it is
correct.

	Andrew
