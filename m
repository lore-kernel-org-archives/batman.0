Return-Path: <davem@davemloft.net>
Date: Wed, 18 Sep 2013 12:23:20 -0400 (EDT)
Message-Id: <20130918.122320.1303866480594733298.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1379485658-2317-1-git-send-email-ordex@autistici.org>
References: <1379485658-2317-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request net: batman-adv 2013-09-18
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
Date: Wed, 18 Sep 2013 08:27:37 +0200

> this is a very small (but important) fix intended for net/linux-3.{11,12} (since
> 3.12-rc1 is out I guess this patch needs to be enqueued for stable in order to
> reach 3.11?)
> 
> This change fixes a regression introduced in 3.11 that prevents the Bridge Loop
> Avoidance component from correctly operate on VLANs.

Pulled and queued up for -stable.
