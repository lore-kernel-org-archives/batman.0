Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 12 Jun 2012 04:16:38 +0800
References: <1339425002-12682-1-git-send-email-sven@narfation.org>
In-Reply-To: <1339425002-12682-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201206120416.38388.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Revert "add support for DBG_DAT
	log level"
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Monday, June 11, 2012 22:30:02 Sven Eckelmann wrote:
> Distributed ARP table support was removed from the batman-adv module.
> Therefore, the support of the debug level should be removed from batctl
> until the support was readded.
> 
> This reverts commit c8c043b9953cec095b7705e99443b37f6361c9a1.
> 
> Reported-by: Marek Lindner <lindner_marek@yahoo.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> This one is for next
> 
>  README       |    1 -
>  man/batctl.8 |    2 +-
>  sys.c        |    7 +------
>  3 files changed, 2 insertions(+), 8 deletions(-)

Applied in revision d37cdf6.

Thanks,
Marek
