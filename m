Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 1 Oct 2012 16:24:53 +0800
References: <1348432717-20913-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1348432717-20913-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210011624.53857.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/4] batman-adv: substitute
	tt_poss_change with a per-tt_entry flag
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

On Monday, September 24, 2012 04:38:34 Antonio Quartulli wrote:
> tt_poss_change is a node-wide flag which tells whether the node is in a
> roaming state (a client recently moved to/away from it) in order to let it
> apply special re-routing rules. However this flag does not give a clear
> idea of the current state because it is not possible to understand which
> client is actually involved in the roaming. For this reason a better
> approach has been chosen: instead of using a node-wide variable, the
> roaming state is now given by a per-tt_entry ROAM flag which, in case of
> packet coming through the node, tells the node whether the real
> destination is in roaming state or not.
> 
> With this flag change, batadv_check_unicast_ttvn() has also been rearranged
> in order to better fit the new re-routing logic and to be much more
> readable.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  originator.c        |   1 -
>  routing.c           | 156
> +++++++++++++++++++++++++++++++++++-----------------
> soft-interface.c    |   1 -
>  translation-table.c |  43 ++++++++++-----
>  translation-table.h |   2 +
>  types.h             |   8 ---
>  6 files changed, 138 insertions(+), 73 deletions(-)

Applied in revision 3fbd7ac.

Thanks,
Marek
