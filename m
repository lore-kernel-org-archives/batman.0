Return-Path: <davem@davemloft.net>
Date: Tue, 31 May 2011 20:52:16 -0700 (PDT)
Message-Id: <20110531.205216.202460915.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1306740182-2665-1-git-send-email-sven@narfation.org>
References: <1306740182-2665-1-git-send-email-sven@narfation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011-05-30
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
Date: Mon, 30 May 2011 09:22:45 +0200

> I would like to propose following patches for net-next-2.6/3.1 [1]. It
> is not really based on your net-next-2.6 tree, but directly on v3.0-rc1.
> I hope that this is ok - thought that you will merge that version
> anyway. Just wanted to get these patches out before doing the really
> work (reducing the amount of patches you get in a single pull request).
> 
> Most patches are only cleanup patches - nothing really interesting.
> Antonio also moved the protocol specific seq_before/seq_after function
> to main.h like you told us [2]. Now he can use it in his translation
> table query patches (they are still moving, so he needs to hunt them
> down before I can submit them).

Pulled, thanks Sven.
