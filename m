Return-Path: <davem@davemloft.net>
Date: Fri, 17 Feb 2012 15:50:49 -0500 (EST)
Message-Id: <20120217.155049.1321221133602638857.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1990573.JisbTKXt7B@sven-laptop.home.narfation.org>
References: <1329463110-856-1-git-send-email-lindner_marek@yahoo.de>
	<20120217.152323.2251437927591117547.davem@davemloft.net>
	<1990573.JisbTKXt7B@sven-laptop.home.narfation.org>
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
To: sven@narfation.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, lindner_marek@yahoo.de

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 17 Feb 2012 21:44:19 +0100

> Have you tried:
> 
>  git pull git://git.open-mesh.org/linux-merge.git tags/batman-adv-for-davem
> 
> But this will drop Mareks signature when done with an old git version (so no 
> merged tag is created).

Yes, that works, and I've pulled it into my tree.

I'm reluctant to pull tags which are signed, I certainly don't have
your personal keys in my key ring for example.  And distributions
ship with GIT versions that don't support signed tags, so...
