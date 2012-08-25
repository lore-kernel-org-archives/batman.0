Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 25 Aug 2012 13:02:33 +0200
References: <1345822986-9079-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1345822986-9079-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201208251302.33951.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] batman-adv: pass the WIFI flag from
	the local to global entry
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
To: b.a.t.m.a.n@lists.open-mesh.org

On Friday, August 24, 2012 17:43:06 Antonio Quartulli wrote:
> @@ -779,13 +797,22 @@ int batadv_tt_global_add(struct batadv_priv
> *bat_priv, ret = 1;
>  
>  out_remove:
> +       tt_local_entry = batadv_tt_local_hash_find(bat_priv, tt_addr);
> +       if (!tt_local_entry)
> +               goto out;
> +
> +       wifi_flag = tt_local_entry->common.flags & BATADV_TT_CLIENT_WIFI;
> +       tt_global_entry->common.flags |= wifi_flag;
> +
>         /* remove address from local hash if present */
> -       batadv_tt_local_remove(bat_priv, tt_global_entry->common.addr,
> -                              "global tt received",
> -                              flags & BATADV_TT_CLIENT_ROAM);
> +       __batadv_tt_local_remove(bat_priv, tt_local_entry, "global tt
> received", +                                flags &
> BATADV_TT_CLIENT_ROAM);
> +
>  out:
>         if (tt_global_entry)
>                 batadv_tt_global_entry_free_ref(tt_global_entry);
> +       if (tt_local_entry)
> +               batadv_tt_local_entry_free_ref(tt_local_entry);
>         return ret;
>  }

Wouldn't it be much simplier if batadv_tt_local_remove() returned the tt_local 
flags somehow ?

Cheers,
Marek
