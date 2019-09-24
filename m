Return-Path: <kvalo@codeaurora.org>
From: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH trivial 2/2] drivers: net: Fix Kconfig indentation
References: <20190923155243.6997-1-krzk@kernel.org>
 <20190923155243.6997-2-krzk@kernel.org>
Date: Tue, 24 Sep 2019 08:15:39 +0300
In-Reply-To: <20190923155243.6997-2-krzk@kernel.org> (Krzysztof Kozlowski's
 message of "Mon, 23 Sep 2019 17:52:43 +0200")
Message-ID: <87sgomi8as.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Michael Grzeschik <m.grzeschik@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Jiri Kosina <trivial@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, lvs-devel@vger.kernel.org, rds-devel@oss.oracle.com

Krzysztof Kozlowski <krzk@kernel.org> writes:

> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
>     $ sed -e 's/^        /\t/' -i */Kconfig
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

[...]

>  drivers/net/wireless/ath/Kconfig              |   2 +-
>  drivers/net/wireless/ath/ar5523/Kconfig       |   4 +-
>  drivers/net/wireless/ath/ath6kl/Kconfig       |   2 +-
>  drivers/net/wireless/ath/ath9k/Kconfig        |   2 +-
>  drivers/net/wireless/ath/carl9170/Kconfig     |   6 +-
>  drivers/net/wireless/atmel/Kconfig            |  32 ++---
>  drivers/net/wireless/intel/ipw2x00/Kconfig    | 116 +++++++++---------
>  drivers/net/wireless/intel/iwlegacy/Kconfig   |   6 +-
>  drivers/net/wireless/intel/iwlwifi/Kconfig    |   6 +-
>  drivers/net/wireless/ralink/rt2x00/Kconfig    |  24 ++--

I hope this goes through net or net-next, less chances of conflits then.

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
