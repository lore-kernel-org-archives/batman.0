Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 8 Nov 2012 04:31:18 +0800
References: <1352199923-16653-1-git-send-email-ordex@autistici.org>
 <1352199923-16653-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1352199923-16653-6-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211080431.18573.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 5/5] batman-adv: fix local client
	recognition in is_my_client()
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

On Tuesday, November 06, 2012 19:05:23 Antonio Quartulli wrote:
> A tt_local_entry which ROAM flag is set cannot be considered a local
> client anymore. Having the ROAM flag set means that the client roamed
> away and that the nodes received a ROAMING_ADV for such event
> 
> This was introduced by ("batman-adv: roaming handling mechanism
> redesign")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  translation-table.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied in revision 7cfe135.

Thanks,
Marek
