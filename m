Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 28 May 2013 15:10:03 +0800
References: <1369409129-1760-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1369409129-1760-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305281510.03302.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: fix num_changes type to
	uint16_t
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

On Friday, May 24, 2013 23:25:28 Antonio Quartulli wrote:
> Since the introduction of the tvlv_tt_data struct variables
> storing the number of TT changes are always declared as
> uint16_t, however some of them were not changed.
> 
> Switch them al to uint16_t.
> 
> Introduced by 8405301b979466610a726b7d595b6bfee5306cf7
> ("batman-adv: tvlv - convert tt data sent within OGMs")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  translation-table.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied in revision 49d9c47.

Thanks,
Marek
