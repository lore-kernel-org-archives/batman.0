Return-Path: <davem@davemloft.net>
Date: Thu, 25 Apr 2013 01:33:53 -0400 (EDT)
Message-Id: <20130425.013353.779038075699652078.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1366619894-16857-1-git-send-email-ordex@autistici.org>
References: <1366619894-16857-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request net: batman-adv 2013-04-22
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 22 Apr 2013 10:38:13 +0200

> here we have another (I think the last) fix intended for net/linux-3.9.
> 
> This patch fixes a bug in the Translation Table component. In particular, when
> batman-adv accesses the "inner Ethernet header", it has have to jump over its
> header which can have two different lengths. The current code assumes
> that this length is always the same and so leading to a wrong access.
> This patch fixes it by making the "jump" generic.
> 
> The bug is not very critical because it "only" breaks our "smart rerouting
> feature" and does not lead to a crash since the memory it accesses is always
> allocated. I would send it to stable, but you can decide whether it is worth or
> not.

Pulled, thanks.
