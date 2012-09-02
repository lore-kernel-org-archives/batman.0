Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 2 Sep 2012 16:46:08 +0800
References: <1346060683-10228-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1346060683-10228-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201209021646.08934.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5] batman-adv: pass the WIFI flag from
	the local to global entry
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

On Monday, August 27, 2012 17:44:43 Antonio Quartulli wrote:
> in case of client roaming a new global entry is added while a corresponding
> local one is still present. In this case the node can safely pass the WIFI
> flag from the local to the global entry.
> 
> This change is required to let the AP-isolation correctly working in case
> of roaming: if a generic WIFI client C roams from node A to B, A adds a
> global entry for C without adding any WIFI flag. The latter will be set
> only later, once A has received C's advertisement from B. In this time
> period the AP-Isolation (if enabled) would not correctly work since C is
> not marked as WIFI, so allowing it to communicate with other WIFI clients.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> v5:
> - reduced code complexity
> - batadv_tt_local_remove() now returns the flags set on the removed entry.
> 
>  translation-table.c | 31 +++++++++++++++++++++++++------
>  translation-table.h |  6 +++---
>  2 files changed, 28 insertions(+), 9 deletions(-)

Applied in revision 0ac0147.

Thanks,
Marek
