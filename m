Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 4 Sep 2013 15:51:44 +0800
References: <1378199424-795-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1378199424-795-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201309041551.45065.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv8 1/2] batman-adv: provide orig_node
	routing API
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <ordex@autistici.org>

On Tuesday, September 03, 2013 17:10:23 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> Some operations executed on an orig_node depends on the
> current routing algorithm being used. To easily make this
> mechanism routing algorithm agnostic add a orig_node
> specific API that each algorithm can populate with its own
> routines.
> 
> Such routines are then invoked by the code when needed,
> without knowing which routing algorithm is currently in use
> 
> With this patch 3 API functions are added:
> - orig_free (to free routing depending internal structs)
> - orig_add_if (to change the inner state of an orig_node
>   when a new hard interface is added)
> - orig_del_if (to change the inner state of an orig_node
>   when an hard interface is removed)
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
> 
> changes from v7:
> - removed batadv_orig_node_del_if() (it has been accidentally re-introduced
>   during the last rebase)
> 
> Cheers,
> 
> 
>  bat_iv_ogm.c | 126
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ originator.c |
> 102 +++++++---------------------------------------- types.h      |  11
> ++++++
>  3 files changed, 151 insertions(+), 88 deletions(-)

Applied in revision fdafa7d.

Thanks,
Marek
