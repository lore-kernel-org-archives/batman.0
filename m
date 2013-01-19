Return-Path: <davem@davemloft.net>
Date: Sat, 19 Jan 2013 10:50:17 -0500 (EST)
Message-Id: <20130119.105017.886816855929937540.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1358602079-24024-1-git-send-email-ordex@autistici.org>
References: <1358602079-24024-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2013-01-19
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
Date: Sat, 19 Jan 2013 21:27:46 +0800

> here is our second patchset intended for net-next/linux-3.9.
> In this batch you have some struct refactoring and a great kernel doc
> improvement by Marek Lindner. In patch 10/13 you have the random32() function
> renaming proposed by Akinobu Mita.
> 
> In 11/13 instead you have a behavioural change brought by Simon Wunderlich which
> is modifying the way a batman-adv virtual interface is unregistered in order to
> prevent a possible deadlock involving rntl_lock and s_active. We have
> already been discussing about this problem and its possible solution on the
> netdev mailing list.
> The rest is just clean up work.
> 
> Please pull or let me know if there is any problem.

Pulled, thanks Antonio.
