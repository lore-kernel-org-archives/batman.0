Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 12 May 2013 16:20:07 +0800
References: <1367931069-7177-1-git-send-email-sven@narfation.org>
 <1367931069-7177-9-git-send-email-sven@narfation.org>
In-Reply-To: <1367931069-7177-9-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305121620.07720.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 8/9] batman-adv-devel: Use section
	garbage collection to reduce binary size
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
Cc: Sven Eckelmann <sven@narfation.org>

On Tuesday, May 07, 2013 20:51:08 Sven Eckelmann wrote:
> The linker can identify unused sections of a binary when each symbol is
> stored in a separate section. This mostly removes unused linker sections
> and reduces the size by ~3% on mipsel.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  batman-adv-devel/Makefile | 3 +++
>  1 file changed, 3 insertions(+)

Applied in revision 3e056f3.

Thanks,
Marek
