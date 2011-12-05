Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 6 Dec 2011 02:41:59 +0800
References: <1323034707-25325-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1323034707-25325-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201112060242.00220.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: delete global entry in case
	of roaming
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

On Monday, December 05, 2011 05:38:27 Antonio Quartulli wrote:
> diff --git a/translation-table.c b/translation-table.c
> index cf3e2c2..6e01079 100644
> --- a/translation-table.c
> +++ b/translation-table.c
> @@ -663,6 +663,7 @@ void tt_global_del(struct bat_priv *bat_priv,
>  		   const char *message, bool roaming)
>  {
>  	struct tt_global_entry *tt_global_entry = NULL;
> +	struct tt_local_entry *tt_local_entry = NULL

Please make sure that your patch at least(!) compiles before you send it to 
the list. It also would be nice if the patches destined for the maint branch 
were based on based on this very branch. Saves some time and (merge) hair ..
 
Applied in revision db10af5.

Thanks,
Marek
