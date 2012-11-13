Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 13 Nov 2012 16:32:25 +0800
References: <1352408130-22971-1-git-send-email-ordex@autistici.org>
 <1352408130-22971-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1352408130-22971-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211131632.26110.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: process broadcast
	packets in BLA earlier
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

On Friday, November 09, 2012 04:55:30 Antonio Quartulli wrote:
> The logic in the BLA mechanism may decide to drop broadcast packets
> because the node may still be in the setup phase. For this reason,
> further broadcast processing like the early client detection mechanism
> must be done only after the BLA check.
> 
> This patches moves the invocation to BLA before any other broadcast
> processing.
> 
> This was introduced by 724d05c8215e4e8186097121595ef20b6ba601b7
> ("batman-adv: detect not yet announced clients")
> 
> Reported-by: Glen Page <glen.page@thet.net>
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  soft-interface.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied in revision 4dba221.

Thanks,
Marek
