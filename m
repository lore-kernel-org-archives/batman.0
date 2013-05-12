Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 12 May 2013 14:48:15 +0800
References: <1368118097-1875-1-git-send-email-ordex@autistici.org>
 <1368118097-1875-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1368118097-1875-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305121448.15631.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 next 2/2] batman-adv: use VLAN_VID_MASK
	instead of BATADV_VID_MASK
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

On Friday, May 10, 2013 00:48:17 Antonio Quartulli wrote:
> VLAN_VID_MASK is already diefined in linux/if_vlan.h and
> therefore does not need to be privately re-defined
> 
> Introduced in 0b1da1765fdb00ca5d53bc95c9abc70dfc9aae5b
> ("batman-adv: change VID semantic in the BLA code")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  bridge_loop_avoidance.c | 2 +-
>  main.h                  | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)

Applied in revision 64fc7ed.

Thanks,
Marek
