Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 1 Oct 2012 16:45:36 +0800
References: <1348432717-20913-1-git-send-email-ordex@autistici.org>
 <1348432717-20913-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1348432717-20913-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210011645.37279.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: refactor
	tt_global_del_struct()
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

On Monday, September 24, 2012 04:38:36 Antonio Quartulli wrote:
> batadv_tt_global_del_struct() function is not properly named.
> Having a more meaningful name which reflects the current behavior helps
> other developers to easily understand what it does.
> 
> A parameter has also been renamed in order to let the function header
> better fit the 80-chars line-width
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  translation-table.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

Applied in revision d4ad929.

Thanks,
Marek
