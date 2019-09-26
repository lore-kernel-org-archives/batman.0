Return-Path: <davem@davemloft.net>
Date: Thu, 26 Sep 2019 08:56:02 +0200 (CEST)
Message-Id: <20190926.085602.2172736725970238315.davem@davemloft.net>
Subject: Re: [PATCH trivial 1/2] net: Fix Kconfig indentation
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190923155243.6997-1-krzk@kernel.org>
References: <20190923155243.6997-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: krzk@kernel.org
Cc: m.grzeschik@pengutronix.de, wg@grandegger.com, mkl@pengutronix.de, andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, trivial@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, lvs-devel@vger.kernel.org, rds-devel@oss.oracle.com

From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 23 Sep 2019 17:52:42 +0200

> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
>     $ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Ok, I'll apply these to 'net'.
