Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 7 Nov 2012 23:16:45 +0800
References: <1352038798-29658-3-git-send-email-sven@narfation.org>
 <1352106924-6755-1-git-send-email-sven@narfation.org>
In-Reply-To: <1352106924-6755-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211072316.45774.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC-alt 3/4] batman-adv: Fix alignment for
	payload after batadv_unicast_4addr_packet
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

On Monday, November 05, 2012 17:15:24 Sven Eckelmann wrote:
> batadv_unicast_4addr_packet created an odd aligned ethernet header and a
> not 4 bytes boundary aligned IP header. Adding an extra reserved bytes
> avoids this problem.
> 
> This problem was introduced in 78fc6bbe0aca868b65b92723b1e259e7ef7b35c0
> ("batman-adv: add UNICAST_4ADDR packet type")
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> This is an alternative version of the third patch.
> 
> DONT APPLY PATCH 4 WHEN NOT APPLYING THE INITIAL VERSION OF THE THIRD PATCH
> 
>  packet.h  |    6 +++++-
>  unicast.c |    1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)

Applied in revision cc9fb91.

Thanks,
Marek
