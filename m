Return-Path: <sasha.levin@oracle.com>
Message-ID: <5127BAD2.1040007@oracle.com>
Date: Fri, 22 Feb 2013 13:37:06 -0500
From: Sasha Levin <sasha.levin@oracle.com>
MIME-Version: 1.0
References: <5127A2AF.9030502@oracle.com> <20130222170621.GU3523@ritirata.org>
In-Reply-To: <20130222170621.GU3523@ritirata.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv: gpf in batadv_slide_own_bcast_window
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
To: Antonio Quartulli <ordex@autistici.org>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Dave Jones <davej@redhat.com>, Marek Lindner <lindner_marek@yahoo.de>, "David S. Miller" <davem@davemloft.net>

On 02/22/2013 12:06 PM, Antonio Quartulli wrote:
> Hi Sasha and thank you very much for reporting this issue.
> 
> IIRC this is similar to a bug you already reported in the past.
> This bug should be the result of a race condition batman-adv has in the
> hard-interface handling code (this is why it has been triggered while removing
> eth0).
> 
> Now that the rtnl-deadlock has been solved I think we can try to further
> investigate on this bug and try to find a solution..though it will not be easy
> as it probably requires another lock to protect the hard-interface during this
> operations.
> 
> If you have any fix proposal feel free to contribute!

I'm confused about how batadv_orig_hash_del_if removes an interface from the
hashtable. I see the hashtable is using rcu to protect it, but when we
delete an entry we free it straight away by calling batadv_orig_node_del_if()
and not going through kfree_rcu().

Is there a reason behind doing that, or might it be the cause of the problem
we're seeing here?


Thanks,
Sasha
