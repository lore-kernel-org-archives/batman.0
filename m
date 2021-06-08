Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: Re: [PATCH 01/11] batman-adv: Start new development cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162318000579.7737.13404086203664485668.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jun 2021 19:20:05 +0000
References: <20210608152700.30315-2-sw@simonwunderlich.de>
In-Reply-To: <20210608152700.30315-2-sw@simonwunderlich.de>
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Tue,  8 Jun 2021 17:26:50 +0200 you wrote:
> This version will contain all the (major or even only minor) changes fo=
r
> Linux 5.14.
>=20
> The version number isn't a semantic version number with major and minor
> information. It is just encoding the year of the expected publishing as
> Linux -rc1 and the number of published versions this year (starting at =
0).
>=20
> [...]

Here is the summary with links:
  - [01/11] batman-adv: Start new development cycle
    https://git.kernel.org/netdev/net-next/c/9a959cab2219
  - [02/11] batman-adv: Always send iface index+name in genlmsg
    https://git.kernel.org/netdev/net-next/c/d295345abb3e
  - [03/11] batman-adv: bcast: queue per interface, if needed
    https://git.kernel.org/netdev/net-next/c/3f69339068f9
  - [04/11] batman-adv: bcast: avoid skb-copy for (re)queued broadcasts
    https://git.kernel.org/netdev/net-next/c/4cbf055002c5
  - [05/11] batman-adv: mcast: add MRD + routable IPv4 multicast with bri=
dges support
    https://git.kernel.org/netdev/net-next/c/7a68cc16b82c
  - [06/11] batman-adv: Remove the repeated declaration
    https://git.kernel.org/netdev/net-next/c/1cf1ef60a1a6
  - [07/11] batman-adv: Fix spelling mistakes
    https://git.kernel.org/netdev/net-next/c/791ad7f5c17e
  - [08/11] batman-adv: Drop implicit creation of batadv net_devices
    https://git.kernel.org/netdev/net-next/c/bf6b260b8a96
  - [09/11] batman-adv: Avoid name based attaching of hard interfaces
    https://git.kernel.org/netdev/net-next/c/fa205602d46e
  - [10/11] batman-adv: Don't manually reattach hard-interface
    https://git.kernel.org/netdev/net-next/c/170258ce1c71
  - [11/11] batman-adv: Drop reduntant batadv interface check
    https://git.kernel.org/netdev/net-next/c/020577f879be

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

