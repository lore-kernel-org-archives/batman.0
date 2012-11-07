Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 7 Nov 2012 22:44:35 +0800
References: <1352038798-29658-1-git-send-email-sven@narfation.org>
 <1352045505-8435-1-git-send-email-sven@narfation.org>
In-Reply-To: <1352045505-8435-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211072244.35334.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFCv2 1/4] batman-adv: Reserve extra bytes in
	skb for better alignment
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

On Monday, November 05, 2012 00:11:45 Sven Eckelmann wrote:
> The ethernet header is 14 bytes long. Therefore, the data after it is not 4
> byte aligned and may cause problems on systems without unaligned data
> access. Reserving NET_IP_ALIGN more byes can fix the misalignment of the
> ethernet header.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Oops, the allocation of the skb also has to be changed
> 
>  bat_iv_ogm.c        |    8 +++++---
>  icmp_socket.c       |    4 ++--
>  translation-table.c |   20 ++++++++++----------
>  vis.c               |    9 +++++----
>  4 files changed, 22 insertions(+), 19 deletions(-)

Applied in revision 7f91790.

Thanks,
Marek
