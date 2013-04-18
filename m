Return-Path: <davem@davemloft.net>
Date: Thu, 18 Apr 2013 14:51:28 -0400 (EDT)
Message-Id: <20130418.145128.2233185650892865601.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1366232596-23172-1-git-send-email-ordex@autistici.org>
References: <1366232596-23172-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2013-04-17
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
Date: Wed, 17 Apr 2013 23:03:15 +0200

> here you have a patch intended for net/linux-3.9 (if it can still make it..).
> It is fixing a MAC address check routine which does not behave
> correctly in case of multiple mesh interfaces in the same node.

Pulled.

> This patch will generate some conflicts the next time you will merge net in
> net-next and will also break it (this happens because the function this patch is
> changing is used by some patches existing in net-next only).
> 
> I will send some instruction on how to solve the merge conflicts and a patch to
> fix net-next soon.

Thanks.
