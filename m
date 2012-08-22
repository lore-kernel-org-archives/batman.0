Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 22 Aug 2012 02:28:43 +0200
References: <1344632966-24233-1-git-send-email-ordex@autistici.org>
 <1344676260-24951-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1344676260-24951-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201208220228.44031.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: return proper value in
	case of hash_add failure
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

On Saturday, August 11, 2012 11:11:00 Antonio Quartulli wrote:
> In case of hash_add failure tt_global_add() must return 0 (which means on
> entry insertion).
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> This patch is based on master. This bug exists since "a bit" but nobody
> actually found it because this bug should have been triggered in the
> unlikely case of hash
> adding failure. Therefore I do not think it is a crucial bug and it is not
> worth sending this patch to stable.
> 
> Cheers,
> 
> 
>  translation-table.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 956c0b8.

Thanks,
Marek
