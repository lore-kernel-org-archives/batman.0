Return-Path: <davem@davemloft.net>
Date: Mon, 14 Mar 2016 15:25:02 -0400 (EDT)
Message-Id: <20160314.152502.1823929263984045274.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <56E2BCD8.9010200@users.sourceforge.net>
References: <564EFC67.7050307@users.sourceforge.net>
 <1655341.WCvHHx7pqD@bentobox>
 <56E2BCD8.9010200@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Less function calls in
 batadv_is_ap_isolated() after error detection
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: elfring@users.sourceforge.net
Cc: kernel-janitors@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, a@unstable.cc, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr

From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 11 Mar 2016 13:40:56 +0100

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 11 Mar 2016 13:10:20 +0100
> 
> The variables "tt_local_entry" and "tt_global_entry" were eventually
> checked again despite of a corresponding null pointer test before.
> 
> * Avoid this double check by reordering a function call sequence
>   and the better selection of jump targets.
> 
> * Omit the initialisation for these variables at the beginning then.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

I am assuming Antonio will take this in via his tree.
