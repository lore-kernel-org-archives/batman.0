Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 6 May 2013 11:24:45 +0800
References: <1367757476-1705-1-git-send-email-ordex@autistici.org>
 <1367757476-1705-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1367757476-1705-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305061124.45472.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: remove
	batadv_tt_global_add_orig declaration
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

On Sunday, May 05, 2013 20:37:56 Antonio Quartulli wrote:
> batadv_tt_global_add_orig is neither used nor implemented
> anymore, therefore it is possible to remove its declaration
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  translation-table.h | 3 ---
>  1 file changed, 3 deletions(-)

Applied in revision 469d4b4.

Thanks,
Marek
