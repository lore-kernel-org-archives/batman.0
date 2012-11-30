Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 30 Nov 2012 17:42:00 +0800
References: <1353923417-29900-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1353923417-29900-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211301742.01228.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: use ETH_P_BATMAN
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

On Monday, November 26, 2012 17:50:17 Antonio Quartulli wrote:
> ETH_P_BATMAN is now defined in linux/if_ether.h. batctl does not need
> to use the private BATADV_ETH_P_BATMAN define.
> However, depending on the kernel-headers version installed on the
> system, this new constant may not be available, therefore a redefinition
> inside an ifndef check is needed.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  packet.h  | 2 --
>  tcpdump.c | 5 ++++-
>  2 files changed, 4 insertions(+), 3 deletions(-)

Applied in revision 9ed1b2e.

Thanks,
Marek
