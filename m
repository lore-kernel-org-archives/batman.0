Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 17 Oct 2012 01:57:05 +0800
References: <1350246055-18000-1-git-send-email-sven@narfation.org>
 <1350246055-18000-2-git-send-email-sven@narfation.org>
In-Reply-To: <1350246055-18000-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210170157.05384.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 2/4] batctl: Allow to use IPv4
	addresses for ping/traceroute
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
To: b.a.t.m.a.n@lists.open-mesh.org

On Monday, October 15, 2012 04:20:53 Sven Eckelmann wrote:
> IPv4 addresses and hostnames are easier to remember than many MAC
> addresses. batctl can automatically resolve the MAC address of the target
> device when the IP is configured on top of the batman-adv device and the
> source and destination batman-adv interface are in the same IPv4 subnet.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> rebased on DAT
> 
>  README       |    4 +-
>  functions.c  |  149
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> functions.h  |    1 +
>  man/batctl.8 |   18 ++++---
>  ping.c       |    6 +--
>  traceroute.c |    6 +--
>  6 files changed, 170 insertions(+), 14 deletions(-)

Applied in revision cb75e01.

Thanks,
Marek
