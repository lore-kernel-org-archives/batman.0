Return-Path: <davem@davemloft.net>
Date: Thu, 16 Jan 2014 17:17:11 -0800 (PST)
Message-Id: <20140116.171711.1684801994017990455.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1389827444-3911-1-git-send-email-antonio@meshcoding.com>
References: <1389827444-3911-1-git-send-email-antonio@meshcoding.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request [net]: batman-adv 2014-01-16
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
Date: Thu, 16 Jan 2014 00:10:43 +0100

> here you have a very small fix intended for net/linux-3.13.
> 
> This patch is fixing the batman-adv overhead computation
> (by Marek Lindner).
> The result of such operation is used to initialize the
> hard_header_len member of the soft-interface netdev object.
> 
> Please pull or let me know of any problem!

Pulled, thanks Antonio.
