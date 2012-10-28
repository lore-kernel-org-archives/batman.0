Return-Path: <davem@davemloft.net>
Date: Sun, 28 Oct 2012 18:59:27 -0400 (EDT)
Message-Id: <20121028.185927.374901219739099234.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1351423037-5292-4-git-send-email-ordex@autistici.org>
References: <1351423037-5292-1-git-send-email-ordex@autistici.org>
 <1351423037-5292-4-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/16] batman-adv: separate
 BATADV_ATTR_HIF_UINT sysfs name from hard-iface variable
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
To: ordex@autistici.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, lindner_marek@yahoo.de

From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 28 Oct 2012 12:17:04 +0100

> From: Marek Lindner <lindner_marek@yahoo.de>
> 
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  net/batman-adv/sysfs.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

I was wondering how you could possibly change the list of arguments to
these macros, yet avoid changing any of the users.

And sure enough it's because these macros are completely unused.

Please just remove them instead of changing their interfaces when no
users exist.
