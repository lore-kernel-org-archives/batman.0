Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 13 Nov 2012 18:29:58 +0800
References: <1352749701-19288-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1352749701-19288-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211131829.58637.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: remove useless !! when
	converting to bool
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

On Tuesday, November 13, 2012 03:48:21 Antonio Quartulli wrote:
> In C standard any expression different from 0 will be converted to
> 'true' when casting to bool (whatever is the length of the value).
> Therefore the "!!" conversion can be removed.
> 
> This was introduced by 3fbd7ac8c71b3778c5751b3d096ea36f96ef534e
> ("batman-adv: substitute tt_poss_change with a per-tt_entry flag")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  translation-table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 7f05664.

Thanks,
Marek
