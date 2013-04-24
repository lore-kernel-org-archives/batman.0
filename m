Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 25 Apr 2013 00:54:01 +0800
References: <1366818176-21765-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1366818176-21765-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304250054.01565.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] net: vlan: add protocol argument
	to packet tagging functions
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

On Wednesday, April 24, 2013 23:42:56 Simon Wunderlich wrote:
> From: Patrick McHardy <kaber@trash.net>
> 
> Add a protocol argument to the VLAN packet tagging functions. In case of HW
> tagging, we need that protocol available in the ndo_start_xmit functions,
> so it is stored in a new field in the skb. The new field fits into a hole
> (on 64 bit) and doesn't increase the sks's size.
> 
> Signed-off-by: Patrick McHardy <kaber@trash.net>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> [siwu@hrz.tu-chemnitz.de: added compat code]
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
>  bridge_loop_avoidance.c |    2 +-
>  compat.h                |   16 +++++++++++++++-
>  2 files changed, 16 insertions(+), 2 deletions(-)

Applied in revision 82d1a8e.

Thanks,
Marek
