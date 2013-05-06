Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 6 May 2013 11:22:56 +0800
References: <1367775158-3989-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1367775158-3989-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305061122.56829.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: make tt_global_add
	static and return bool
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
Cc: Antonio Quartulli <ordex@autistici.org>

On Monday, May 06, 2013 01:32:38 Antonio Quartulli wrote:
> batadv_tt_global_add is not used anymore outside of the TT
> code thanks to the TVLV implementation. It can therefore be
> declared as static
> 
> Last user has been removed by 3de4e64df0f1326db7cc0ef25f5af8522850252d
> ("batman-adv: tvlv - convert roaming adv packet to use tvlv unicast
> packets")
> 
> Moreover make it return bool since its result can be either 0 or 1.
> 
> Reported-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> v1 name was: [PATCH 1/2] batman-adv: make tt_global_add stati
> 
> v2:
> - add some kernel doc
> - make the function return bool
> 
> 
>  translation-table.c | 14 ++++++++------
>  translation-table.h |  4 ----
>  2 files changed, 8 insertions(+), 10 deletions(-)

Applied in revision be7e115.

Thanks,
Marek
