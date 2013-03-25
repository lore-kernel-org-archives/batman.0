Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 25 Mar 2013 16:44:35 +0800
References: <1363942195-21952-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1363942195-21952-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201303251644.35958.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: fix old master freeing
	operation
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

On Friday, March 22, 2013 16:49:55 Antonio Quartulli wrote:
> When a new hard_iface has a master already, ndo_del_slave
> has to be used in order to let the old master perform its
> cleaning up routine correctly. Unsetting the master iface
> only can lead to a inconsistent state in the master driver.
> 
> Introduced by 5e57e3bff429cd403f0e30af69cf87a2cd55598f
> ("batman-adv: free an hard-interface before adding it").
> 
> Reported-by: Marek Lindner <lindner_marek@yahoo.de>
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> v2:
> - patch restyled
> - added compat code for <2.6.39 (Thanks to Simon)
> 
> v3:
> - commit message rewording
> - change EINVAL to EBUSY to better describe the error
> 
>  compat.h         |  3 +++
>  hard-interface.c | 29 +++++++++++++++++++++++++++--
>  2 files changed, 30 insertions(+), 2 deletions(-)

Applied in revision 9e96c4d.

Thanks,
Marek
