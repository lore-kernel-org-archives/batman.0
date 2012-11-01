Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 1 Nov 2012 12:42:29 +0800
References: <1351524929-21921-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1351524929-21921-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211011242.29939.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: don't free resource when
	DAT is disabled
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

On Monday, October 29, 2012 23:35:29 Antonio Quartulli wrote:
> Freeing all the resources when DAT is disabled need a much more complicated
> locking system to prevent concurrent enable/disable operations to destroy
> the internal state of the component. For now it is safe to avoid such
> freeing operation when DAT is disabled.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> v2:
>  - removed declaration of batadv_dat_switch() in distributed-arp-table.h
> 
>  distributed-arp-table.c | 10 ----------
>  distributed-arp-table.h |  1 -
>  sysfs.c                 |  3 +--
>  3 files changed, 1 insertion(+), 13 deletions(-)

Applied in revision 94d9158.

Thanks,
Marek
