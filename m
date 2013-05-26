Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 26 May 2013 14:07:42 +0800
References: <1368881817-2087-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1368881817-2087-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305261407.42288.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: create common header for
	ICMP packets
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <ordex@autistici.org>

On Saturday, May 18, 2013 20:56:57 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> the icmp and the icmp_rr packets share the same initial
> fields since they use the same code to be processed and
> forwarded.
> 
> Extract the common fields and put them into a separate
> struct so that future ICMP packets can be easily added
> without bloating the packet definition.
> 
> However, keep the seqno field outside of the newly created
> common header because future ICMP types may require a
> bigger sequence number space.
> 
> This change breaks compatibility due to fields reordering
> in the ICMP headers.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
> 
> 
> v2:
> - merge of
> [PATCH 1/2] batman-adv: simplify ICMP packet structures
> and
> [PATCH 2/2] batman-adv: move seqno field outside of the common ICMP header
> 
> - reword commit subject and message
> - rename the new member from "ih" to "icmph"
> 
> 
> 
>  icmp_socket.c | 22 +++++++++++-----------
>  main.c        |  4 ++--
>  packet.h      | 38 ++++++++++++++++++++++++++++----------
>  routing.c     | 40 +++++++++++++++++++++-------------------
>  4 files changed, 62 insertions(+), 42 deletions(-)

Applied in revision 1897ab7.

Thanks,
Marek
