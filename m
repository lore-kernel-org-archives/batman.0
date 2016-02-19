Return-Path: <davem@davemloft.net>
Date: Fri, 19 Feb 2016 15:37:18 -0500 (EST)
Message-Id: <20160219.153718.442738962662787470.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1455634888-29400-1-git-send-email-a@unstable.cc>
References: <1455634888-29400-1-git-send-email-a@unstable.cc>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request [net]: batman-adv 20160216
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: a@unstable.cc
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <a@unstable.cc>
Date: Tue, 16 Feb 2016 23:01:25 +0800

> this pull request is intended for net.
> 
> Two of the fixes included in this patchset prevent a wrong memory
> access - it was triggered when removing an object from a list
> after it was already free'd due to bad reference counting.
> This misbehaviour existed for both the gw_node and the
> orig_node_vlan object and has been fixed by Sven Eckelmann.
> 
> The last patch fixes our interface feasibility check and prevents
> it from looping indefinitely when two net_device objects
> reference each other via iflink index (i.e. veth pair), by
> Andrew Lunn

Pulled, thanks Antonio.

And thanks for the heads up about the potential merge issues, I'll watch
for that.
