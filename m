Return-Path: <jj@chaosbits.net>
Date: Tue, 7 Aug 2012 20:38:49 +0200 (CEST)
From: Jesper Juhl <jj@chaosbits.net>
In-Reply-To: <alpine.LNX.2.00.1208072030500.3227@swampdragon.chaosbits.net>
Message-ID: <alpine.LNX.2.00.1208072037380.3227@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1208072030500.3227@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix mem leak in the
 batadv_tt_local_event() function
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
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Marek Lindner <lindner_marek@yahoo.de>, "David S. Miller" <davem@davemloft.net>

On Tue, 7 Aug 2012, Jesper Juhl wrote:

> Memory is allocated for 'tt_change_node' with kmalloc().
> 'tt_change_node' may go out of scope really being used for anything

This should of course read "... go out of scope without really being used ..." .

> (except have a few members initialized) if we hit the 'del:' label.
> This patch makes sure we free the memory in that case.
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> ---
>  net/batman-adv/translation-table.c | 1 +
>  1 file changed, 1 insertion(+)
> 
>  Compile tested only.
> 
> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index a438f4b..99dd8f7 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -197,6 +197,7 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
>  del:
>  		list_del(&entry->list);
>  		kfree(entry);
> +		kfree(tt_change_node);
>  		event_removed = true;
>  		goto unlock;
>  	}
> 

-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.

