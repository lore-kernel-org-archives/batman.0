Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 25 Aug 2012 01:16:57 +0200
References: <1345588805-27249-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1345588805-27249-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201208250116.57820.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: swap lines to get in sync
	with networking branch
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

On Wednesday, August 22, 2012 00:40:05 Antonio Quartulli wrote:
> due to a merge conflict resolution handled differently in the networking
> branch, we now have a small divergence between our next branch and what we
> already have in net/batman-adv/ in the kernel. Since we cannot ask the
> kernel guys to "swap two lines", with this patch we fix the problem in our
> repo
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> - this patch is for next
> 
> 
>  soft-interface.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 28d246e.

Thanks,
Marek
