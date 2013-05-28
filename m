Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 28 May 2013 15:02:52 +0800
References: <1369520121-5998-1-git-send-email-lindner_marek@yahoo.de>
 <1369520121-5998-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1369520121-5998-2-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305281502.52888.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: properly align roaming
	tvlv container
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Sunday, May 26, 2013 06:15:21 Marek Lindner wrote:
> 4bytes long members must start at an address multiple of 4
> in order to avoid unaligned memory access.
> 
> Introduced by 3de4e64df0f1326db7cc0ef25f5af8522850252d
> "batman-adv: tvlv - convert roaming adv packet to use
> tvlv unicast packets"
> 
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  packet.h            |    4 +++-
>  translation-table.c |    1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)

Applied in revision 05a7111.

Regards,
Marek
