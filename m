Return-Path: <davem@davemloft.net>
Date: Mon, 04 Jul 2016 23:37:25 -0700 (PDT)
Message-Id: <20160704.233725.776967939409818077.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1467637379-6089-1-git-send-email-sw@simonwunderlich.de>
References: <1467637379-6089-1-git-send-email-sw@simonwunderlich.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 00/11] pull request for net-next:
	batman-adv 2016-07-04
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon,  4 Jul 2016 15:02:48 +0200

> this is our second and final feature pull request for batman-adv in this
> round.
> 
> Please pull or let me know of any problem!

Pulled, thanks.

I have no idea why you guys were using debugfs for anything that
actually matters like configuration. :-/  debugfs should only be
used for "debugging", such that if debugfs were not present the
full functionality of the facility would still be present.


