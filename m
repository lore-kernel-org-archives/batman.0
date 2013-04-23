Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 24 Apr 2013 03:58:56 +0800
References: <1366727676-23233-1-git-send-email-ordex@autistici.org>
 <1366727676-23233-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1366727676-23233-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304240358.56353.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/7] batman-adv: use vid when computing
	local and global TT CRC
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

On Tuesday, April 23, 2013 22:34:30 Antonio Quartulli wrote:
> @@ -1535,7 +1535,9 @@ static uint32_t batadv_tt_global_crc(struct
> batadv_priv *bat_priv, orig_node)) continue;
>  
> -                       crc ^= crc32c(0, tt_common->addr, ETH_ALEN);
> +                       crc_tmp = crc32c(0, &tt_common->vid,
> +                                        sizeof(tt_common->vid));
> +                       crc ^= crc32c(crc_tmp, tt_common->addr, ETH_ALEN);
>                 }
>                 rcu_read_unlock();

Is it necessary to define another variable ? Why not:

crc = crc32c(0, &tt_common->vid, sizeof(tt_common->vid));
crc ^= crc32c(crc, tt_common->addr, ETH_ALEN);


> @@ -1565,7 +1567,9 @@ static uint32_t batadv_tt_local_crc(struct batadv_priv 
*bat_priv)
>                         if (tt_common->flags & BATADV_TT_CLIENT_NEW)
>                                 continue;
>  
> -                       crc ^= crc32c(0, tt_common->addr, ETH_ALEN);
> +                       crc_tmp = crc32c(0, &tt_common->vid,
> +                                        sizeof(tt_common->vid));
> +                       crc ^= crc32c(crc_tmp, tt_common->addr, ETH_ALEN);
>                 }

Dito.

Cheers,
Marek
