Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 28 May 2013 14:59:42 +0800
References: <1369400684-1937-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1369400684-1937-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305281459.43111.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: correctly align the
	tt_tvlv_data struct
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
Cc: Antonio Quartulli <ordex@autistici.org>

On Friday, May 24, 2013 21:04:44 Antonio Quartulli wrote:
> 4bytes long members must start at an address multiple of 4
> in order to avoid unaligned memory access.
> 
> Add 2 padding bytes to satisfy this requirement.
> 
> Introduced by c5e7a06a29612056006e4dc01910c0b44e858583
> "batman-adv: use CRC32C instead of CRC16 in TT code"
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  packet.h | 2 ++
>  1 file changed, 2 insertions(+)

Applied in revision 2fb072a.

Thanks,
Marek
