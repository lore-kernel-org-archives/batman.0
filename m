Return-Path: <davem@davemloft.net>
Date: Mon, 22 Apr 2013 20:41:13 -0400 (EDT)
Message-Id: <20130422.204113.1112043388924796755.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1366362292-22961-3-git-send-email-ordex@autistici.org>
References: <1366362292-22961-1-git-send-email-ordex@autistici.org>
 <1366362292-22961-3-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH next 2/2] batman-adv: fix global
 protection fault during soft_iface destruction
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, lindner_marek@yahoo.de

From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 19 Apr 2013 11:04:52 +0200

> batadv_mesh_free() schedules some RCU callbacks which need the bat_priv struct
> to do their jobs, while free_netdev(), which is called immediately after, is
> destroying the private data.
> 
> Put an rcu_barrier() in the middle so that free_netdev() is invoked only after
> all the callbacks returned.
> 
> This bug has been introduced by ab8f433dd39be94e8617cff2dfe9f7eca162eb15
> ("batman-adv: Move deinitialization of soft-interface to destructor")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>

Applied.
