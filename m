Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 9 Sep 2012 16:13:38 +0800
References: <1346057631-2382-1-git-send-email-sven@narfation.org>
In-Reply-To: <1346057631-2382-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201209091613.39032.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Write lockdep xmit class
	in late initialization phase
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

On Monday, August 27, 2012 16:53:50 Sven Eckelmann wrote:
> e27bb6fa916451e9eaced16e7c21d5b71a3b7f30 ("batman-adv: Set special lockdep
> classes to avoid lockdep warning") introduced a lockdep class for the tx
> queue, but did not set it in the correct initialization phase. The
> batman-adv specific lock class could be replaced by a later netdevice
> registration phase.
> 
> Reported-by: Antonio Quartulli <ordex@autistici.org>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  soft-interface.c |   35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)

Applied in revision b8f86c9.

Thanks,
Marek
