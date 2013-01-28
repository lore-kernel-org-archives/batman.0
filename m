Return-Path: <davem@davemloft.net>
Date: Sun, 27 Jan 2013 19:11:40 -0500 (EST)
Message-Id: <20130127.191140.655904034749695176.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1359315839-24136-1-git-send-email-ordex@autistici.org>
References: <1359315839-24136-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2013-01-27
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
Date: Sun, 27 Jan 2013 20:43:56 +0100

> This is a small patchset intended for net/linux-3.8.
> Here there are three small patches from Matthias Schiffer aimed to fix some
> memory problems in the recently introduced D.A.T. component. One of them is
> fixing an skb memleak, one is fixing the ARP filter routine by preventing DAT to
> parse not useful messages (so reducing the amount of memory used by the local
> cache) and one fixing again the ARP filter routine by preventing DAT to
> overwrite correct entries with bogus ones in the local cache.
> 
> Please pull or let me know if there is any problem.

Pulled, thanks Antonio.
