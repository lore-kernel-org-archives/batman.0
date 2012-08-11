Return-Path: <sven@narfation.org>
Date: Sat, 11 Aug 2012 10:58:12 +0200
From: Sven Eckelmann <sven@narfation.org>
Message-ID: <20120811085812.GA2317@narfation.org>
References: <1344632966-24233-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1344632966-24233-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: return proper value in case
 of hash_add failure
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

On Fri, Aug 10, 2012 at 11:09:26PM +0200, Antonio Quartulli wrote:
> In case of hash_add failure tt_global_add() must return 0 (which means on entry
> insertion).
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> This patch is based on master. This bug exists since "a bit" but nobody actually
> found it because this bug should have been triggered in the unlikely case of hash
> adding failure. Therefore I do not think it is a crucial bug and it is not worth
> sending this patch to stable.
> 
> Cheers,
> 
> 
>  Makefile            |    2 +-
>  translation-table.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index bd8d30c..12aebe5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -20,7 +20,7 @@
>  
>  # changing the CONFIG_* line to 'y' enables the related feature
>  # B.A.T.M.A.N. debugging:
> -export CONFIG_BATMAN_ADV_DEBUG=n
> +export CONFIG_BATMAN_ADV_DEBUG=y
>  # B.A.T.M.A.N. bridge loop avoidance:
>  export CONFIG_BATMAN_ADV_BLA=y

Sry, but disapproved.

Kind regards,
	Sven
