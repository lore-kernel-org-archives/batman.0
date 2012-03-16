Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 16 Mar 2012 23:47:32 +0800
References: <1331909900-25173-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1331909900-25173-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201203162347.33457.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: improve unicast packet
	(re)routing
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

On Friday, March 16, 2012 22:58:20 Antonio Quartulli wrote:
> +/* returns true whether we know that the client has moved from its old
> + * originator to another one. This entry is kept is still kept for
> consistency + * purposes */
> +bool tt_global_client_is_roaming(struct bat_priv *bat_priv, uint8_t *addr)
> +{
> +       struct tt_global_entry *tt_global_entry =
> +               tt_global_hash_find(bat_priv, addr);

Unless you wish to feel David's wrath you should make this 2 lines.

Regards,
Marek
