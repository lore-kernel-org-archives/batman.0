Return-Path: <davem@davemloft.net>
Date: Fri, 17 May 2013 01:41:40 -0700 (PDT)
Message-Id: <20130517.014140.2125848646591726751.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1368778211-2142-1-git-send-email-ordex@autistici.org>
References: <1368778211-2142-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request for net: batman-adv 2013-05-17
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
Date: Fri, 17 May 2013 10:10:10 +0200

> here you have one fix intended for net/linux-3.10.
> This patch is fixing a global fault protection that can be triggered on module
> removal due to the double invocation of call_rcu() in chain.
> 
> While fixing, the patch is also adding some kernel doc to the changed functions.
> Consider queueing this patch to -stable.

Pulled, thanks.
