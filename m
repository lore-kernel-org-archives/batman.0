Return-Path: <patchwork-bot+netdevbpf@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] net: Convert user to netif_rx(), part 3.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <164665441309.23552.3596500663864763691.git-patchwork-notify@kernel.org>
Date: Mon, 07 Mar 2022 12:00:13 +0000
References: <20220306215753.3156276-1-bigeasy@linutronix.de>
In-Reply-To: <20220306215753.3156276-1-bigeasy@linutronix.de>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, tglx@linutronix.de, agordeev@linux.ibm.com, wintera@linux.ibm.com, andrew@lunn.ch, a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, borntraeger@linux.ibm.com, Divya.Koppera@microchip.com, gregkh@linuxfoundation.org, hca@linux.ibm.com, hkallweit1@gmail.com, johan.hedberg@gmail.com, jmaloy@redhat.com, linux-bluetooth@vger.kernel.org, linux-s390@vger.kernel.org, linux-staging@lists.linux.dev, luiz.dentz@gmail.com, marcel@holtmann.org, mareklindner@neomailbox.ch, courmisch@gmail.com, linux@armlinux.org.uk, sw@simonwunderlich.de, sven@narfation.org, svens@linux.ibm.com, tipc-discussion@lists.sourceforge.net, gor@linux.ibm.com, wenjia@linux.ibm.com, ying.xue@windriver.com

Hello:

This series was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Sun,  6 Mar 2022 22:57:43 +0100 you wrote:
> This is the third and last batch of converting netif_rx_ni() caller to
> netif_rx(). The change making this possible is net-next and
> netif_rx_ni() is a wrapper around netif_rx(). This is a clean up in
> order to remove netif_rx_ni().
> 
> The micrel phy driver is patched twice within this series: the first is
> is to replace netif_rx_ni() and second to move netif_rx() outside of the
> IRQ-off section. It is probably simpler to keep it within this series.
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] s390: net: Use netif_rx().
    https://git.kernel.org/netdev/net-next/c/a70d20704ad5
  - [net-next,02/10] staging: Use netif_rx().
    https://git.kernel.org/netdev/net-next/c/4bcc4249b4cf
  - [net-next,03/10] tun: vxlan: Use netif_rx().
    https://git.kernel.org/netdev/net-next/c/3d391f6518fd
  - [net-next,04/10] tipc: Use netif_rx().
    https://git.kernel.org/netdev/net-next/c/a0f0db8292e6
  - [net-next,05/10] batman-adv: Use netif_rx().
    https://git.kernel.org/netdev/net-next/c/94da81e2fc42
  - [net-next,06/10] bluetooth: Use netif_rx().
    https://git.kernel.org/netdev/net-next/c/d33d0dc9275d
  - [net-next,07/10] phonet: Use netif_rx().
    https://git.kernel.org/netdev/net-next/c/63d57cd67454
  - [net-next,08/10] net: phy: micrel: Use netif_rx().
    https://git.kernel.org/netdev/net-next/c/e1f9e434617f
  - [net-next,09/10] net: Remove netif_rx_any_context() and netif_rx_ni().
    https://git.kernel.org/netdev/net-next/c/2655926aea9b
  - [net-next,10/10] net: phy: micrel: Move netif_rx() outside of IRQ-off section.
    https://git.kernel.org/netdev/net-next/c/67dbd6c0a2c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


