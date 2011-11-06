Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 6 Nov 2011 22:16:46 +0800
References: <1320586010-21931-1-git-send-email-julia@diku.dk>
	<1320586010-21931-2-git-send-email-julia@diku.dk>
In-Reply-To: <1320586010-21931-2-git-send-email-julia@diku.dk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201111062216.46584.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/5] net/batman-adv: use kstrtoul, etc
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Julia Lawall <julia@diku.dk>, "David S. Miller" <davem@davemloft.net>

On Sunday, November 06, 2011 21:26:46 Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> Use kstrtoul, etc instead of the now deprecated strict_strtoul, etc.

Thanks for the patch but we already have a patch lined up to address the 
issue. It will be submitted to net-next in the next week or so.

Regards,
Marek
