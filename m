Return-Path: <davem@davemloft.net>
Date: Fri, 17 Feb 2012 15:23:23 -0500 (EST)
Message-Id: <20120217.152323.2251437927591117547.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1329463110-856-1-git-send-email-lindner_marek@yahoo.de>
References: <1329463110-856-1-git-send-email-lindner_marek@yahoo.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2012-02-17
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
To: lindner_marek@yahoo.de
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 17 Feb 2012 15:18:20 +0800

> The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:
> 
>   Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)
> 
> are available in the git repository at:
> 
>   git://git.open-mesh.org/linux-merge.git batman-adv-for-davem

Somethings up:

[davem@drr net-next]$ git pull git://git.open-mesh.org/linux-merge.git batman-adv-for-davem
fatal: Couldn't find remote ref batman-adv-for-davem

which is strange because I can see the tag there on git.open-mesh.org when
I check it with my web browser.
