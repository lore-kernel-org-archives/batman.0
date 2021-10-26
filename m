Return-Path: <patchwork-bot+netdevbpf@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: batman-adv: fix error handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <163525620673.3700.4010737178045204457.git-patchwork-notify@kernel.org>
Date: Tue, 26 Oct 2021 13:50:06 +0000
References: <20211024131356.10699-1-paskripkin@gmail.com>
In-Reply-To: <20211024131356.10699-1-paskripkin@gmail.com>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Pavel Skripkin <paskripkin@gmail.com>
Cc: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, sven@narfation.org, davem@davemloft.net, kuba@kernel.org, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, syzbot+28b0702ada0bf7381f58@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Sun, 24 Oct 2021 16:13:56 +0300 you wrote:
> Syzbot reported ODEBUG warning in batadv_nc_mesh_free(). The problem was
> in wrong error handling in batadv_mesh_init().
> 
> Before this patch batadv_mesh_init() was calling batadv_mesh_free() in case
> of any batadv_*_init() calls failure. This approach may work well, when
> there is some kind of indicator, which can tell which parts of batadv are
> initialized; but there isn't any.
> 
> [...]

Here is the summary with links:
  - net: batman-adv: fix error handling
    https://git.kernel.org/netdev/net/c/6f68cd634856

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


