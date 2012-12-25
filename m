Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 25 Dec 2012 16:27:37 +0800
References: <1355577056-28833-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1355577056-28833-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201212251627.37792.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: a delayed_work has to be
	initialised once
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

On Saturday, December 15, 2012 21:10:56 Antonio Quartulli wrote:
> -	batadv_start_purge_timer(bat_priv);
> +	INIT_DELAYED_WORK(&bat_priv->orig_work, batadv_purge_orig);
> +	queue_delayed_work(batadv_event_workqueue,
> +			   &bat_priv->orig_work, msecs_to_jiffies(1000));
> +
>  	return 0;
> 
>  err:
> @@ -396,7 +392,8 @@ static void batadv_purge_orig(struct work_struct *work)
>  	delayed_work = container_of(work, struct delayed_work, work);
>  	bat_priv = container_of(delayed_work, struct batadv_priv, orig_work);
>  	_batadv_purge_orig(bat_priv);
> -	batadv_start_purge_timer(bat_priv);
> +	queue_delayed_work(batadv_event_workqueue,
> +			   &bat_priv->orig_work, msecs_to_jiffies(1000));
>  }

If the same numeric value is used multiple times we should have a define.


> @@ -2136,7 +2129,9 @@ int batadv_tt_init(struct batadv_priv *bat_priv)
>  	if (ret < 0)
>  		return ret;
> 
> -	batadv_tt_start_timer(bat_priv);
> +	INIT_DELAYED_WORK(&bat_priv->tt.work, batadv_tt_purge);
> +	queue_delayed_work(batadv_event_workqueue, &bat_priv->tt.work,
> +			   msecs_to_jiffies(5000));
> 
>  	return 1;
>  }
> @@ -2286,7 +2281,8 @@ static void batadv_tt_purge(struct work_struct *work)
>  	batadv_tt_req_purge(bat_priv);
>  	batadv_tt_roam_purge(bat_priv);
> 
> -	batadv_tt_start_timer(bat_priv);
> +	queue_delayed_work(batadv_event_workqueue, &bat_priv->tt.work,
> +			   msecs_to_jiffies(5000));
>  }

Same here.

Cheers,
Marek
