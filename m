Return-Path: <davem@davemloft.net>
Date: Tue, 23 Feb 2016 14:49:52 -0500 (EST)
Message-Id: <20160223.144952.2136758155816779066.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1456207703-903-1-git-send-email-a@unstable.cc>
References: <1456207703-903-1-git-send-email-a@unstable.cc>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request [net-next]: batman-adv 20160223
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
Date: Tue, 23 Feb 2016 14:08:03 +0800

> This is another pull request intended for net-next and it is
> basically all cleanup work, mostly by Sven Eckelmann.
> 
> First the BATADV_BONDING_TQ_THRESHOLD
> constant gets removed as it was defined but not used anywhere,
> then all our *_free_ref functions are renamed to *_put in order
> to follow the kernel naming convention.

Pulled, thanks.
