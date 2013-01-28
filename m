Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 29 Jan 2013 01:23:07 +0800
References: <1359023915-31358-1-git-send-email-ordex@autistici.org>
 <1359024099-5158-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1359024099-5158-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201301290123.07372.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 next] batman-adv: fix local translation
	table output
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

On Thursday, January 24, 2013 18:41:39 Antonio Quartulli wrote:
> The last-seen field has to be printed for all the local
> entries but the one marked with the no-purge flag
> 
> Introduced by 15727323d9f8864b2d41930940acc38de987045a
> ("batman-adv: don't print the last_seen time for bat0 TT local entry")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> v2:
> - commit message "fixed"
> 
>  translation-table.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied in revision 46360b2.

Thanks,
Marek
