Return-Path: <davem@davemloft.net>
Date: Sun, 30 Jan 2011 03:56:56 -0800 (PST)
Message-Id: <20110130.035656.115941353.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <201101301036.57928.sven@narfation.org>
References: <1296337660-12376-1-git-send-email-sven@narfation.org>
	<20110129.190815.226768755.davem@davemloft.net>
	<201101301036.57928.sven@narfation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2011-01-29
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
To: sven@narfation.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Jan 2011 10:36:54 +0100

> On Sunday 30 January 2011 04:08:15 David Miller wrote:
>> I'm not taking 13 patches in one big bunch at this point post-merge-window,
>> now matter what they are.
> 
> Thats why I tried to provide the 6 bug fixes only version without polishing - 
> I could also try to reduce it to a 4 critical version (oops/memleak patches 
> only without protocol implementation failures).
> 
> Or is the problem that I tried to get them in as pull request?

Please make a new patch series posting and pull request with only the most
important fixes included.

Once I accept those, you can send me a second patch series and pull
request with the cleanups done on top.  Just mention explicitly in
this second pull request that there is a dependency upon the initial
bug fixes.  In this way I will know to pull net-2.6 into net-next-2.6
first, and then pull from your tree into net-next-2.6

Thanks.
