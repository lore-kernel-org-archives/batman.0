Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 13 Nov 2012 17:55:12 +0800
References: <50A1A816.3070900@gmail.com>
In-Reply-To: <50A1A816.3070900@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201211131755.13299.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 9/9] net: batman-adv: use per_cpu_add
	helper
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
Cc: NetDev <netdev@vger.kernel.org>, Kernel-Maillist <linux-kernel@vger.kernel.org>, siwu@hrz.tu-chemnitz.de, Shan Wei <shanwei88@gmail.com>, Christoph Lameter <cl@linux.com>, David Miller <davem@davemloft.net>

On Tuesday, November 13, 2012 09:53:26 Shan Wei wrote:
> From: Shan Wei <davidshan@tencent.com>
> 
> this_cpu_add is an atomic operation.
> and be more faster than per_cpu_ptr operation.
> 
> Signed-off-by: Shan Wei <davidshan@tencent.com>
> Reviewed-by: Christoph Lameter <cl@linux.com>
> ---
> v4: no changes vs v3.
> ---
>  net/batman-adv/main.h |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)

Applied in our tree (revision f8b19e1). We will pass along this patch through 
our standard workflow. No need to resend this patch in the future.

Thanks,
Marek
