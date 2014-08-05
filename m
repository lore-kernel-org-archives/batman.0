Return-Path: <davem@davemloft.net>
Date: Tue, 05 Aug 2014 16:22:49 -0700 (PDT)
Message-Id: <20140805.162249.1442705693919283325.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1407167221-10575-1-git-send-email-antonio@meshcoding.com>
References: <1407167221-10575-1-git-send-email-antonio@meshcoding.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request net: batman-adv 2014-08-04
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
To: antonio@meshcoding.com
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon,  4 Aug 2014 17:47:00 +0200

> this is a pull request intended for net.
> 
> It just contains a patch by Sven Eckelmann that fixes the
> reception of out-of-order fragments. As explained in the
> commit message, the issue was due to a wrong assumption
> about hlist_for_each_entry() in batadv_frag_insert_packet().
> 
> Please pull or let me know of any problem.
> *If possible, this patch should also be enqueued for stable*

As you can see this didn't make it in time for the 3.16 release,
I've pulled and queued this patch up for -stable.
