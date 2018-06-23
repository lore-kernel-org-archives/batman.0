Return-Path: <davem@davemloft.net>
Date: Sat, 23 Jun 2018 10:50:55 +0900 (KST)
Message-Id: <20180623.105055.470247977870986966.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <c558b59181756dfe647bcdeaf659c386701c0948.1529689773.git.joe@perches.com>
References: <c558b59181756dfe647bcdeaf659c386701c0948.1529689773.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] net: drivers/net: Convert
 random_ether_addr to eth_random_addr
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: joe@perches.com
Cc: derek.chickles@caviumnetworks.com, satananda.burla@caviumnetworks.com, felix.manlunas@caviumnetworks.com, raghu.vatsavayi@caviumnetworks.com, ulli.kroll@googlemail.com, linus.walleij@linaro.org, yisen.zhuang@huawei.com, salil.mehta@huawei.com, jeffrey.t.kirsher@intel.com, bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com, harish.patil@cavium.com, manish.chopra@cavium.com, Dept-GELinuxNICDev@cavium.com, linux-net-drivers@solarflare.com, ecree@solarflare.com, bkenward@solarflare.com, grygorii.strashko@ti.com, w-kwok2@ti.com, m-karicheri2@ti.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, woojung.huh@microchip.com, ath9k-devel@qca.qualcomm.com, mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, kvalo@codeaurora.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, intel-wired-lan@lists.osuosl.org, linux-omap@vger.kernel.org, linux-ntb@googlegroups.com, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Joe Perches <joe@perches.com>
Date: Fri, 22 Jun 2018 10:51:00 -0700

> random_ether_addr is a #define for eth_random_addr which is
> generally preferred in kernel code by ~3:1
> 
> Convert the uses of random_ether_addr to enable removing the #define
> 
> Miscellanea:
> 
> o Convert &vfmac[0] to equivalent vfmac and avoid unnecessary line wrap
> 
> Signed-off-by: Joe Perches <joe@perches.com>

I'll apply this to net-next, thanks Joe.
