Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 25 Apr 2012 20:18:53 +0800
References: <1334743210-12338-1-git-send-email-ordex@autistici.org>
	<20120419061026.GC8658@ritirata.org>
	<20120422064750.GX6871@ZenIV.linux.org.uk>
In-Reply-To: <20120422064750.GX6871@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201204252018.54154.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/5] batman-adv: trivial endianness
	annotations
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Sunday, April 22, 2012 14:47:50 Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  net/batman-adv/bridge_loop_avoidance.c |    6 +++---
>  net/batman-adv/distributed-arp-table.c |   16 ++++++++--------
>  net/batman-adv/distributed-arp-table.h |    4 ++--
>  net/batman-adv/packet.h                |   12 ++++++------
>  4 files changed, 19 insertions(+), 19 deletions(-)

Applied in revision 276f053.

Thanks,
Marek
