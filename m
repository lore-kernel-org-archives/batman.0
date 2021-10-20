Return-Path: <patchwork-bot+netdevbpf@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] batman-adv: prepare for const netdev->dev_addr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <163473661065.3411.17859623036163871066.git-patchwork-notify@kernel.org>
Date: Wed, 20 Oct 2021 13:30:10 +0000
References: <20211019163007.1384352-1-kuba@kernel.org>
In-Reply-To: <20211019163007.1384352-1-kuba@kernel.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, sven@narfation.org, b.a.t.m.a.n@lists.open-mesh.org

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Oct 2021 09:30:07 -0700 you wrote:
> netdev->dev_addr will be constant soon, make sure
> the qualifier is propagated thru batman-adv.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: mareklindner@neomailbox.ch
> CC: sw@simonwunderlich.de
> CC: a@unstable.cc
> CC: sven@narfation.org
> CC: b.a.t.m.a.n@lists.open-mesh.org
> 
> [...]

Here is the summary with links:
  - batman-adv: prepare for const netdev->dev_addr
    https://git.kernel.org/netdev/net-next/c/47ce5f1e3e4e

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


