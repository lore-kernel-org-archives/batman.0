Return-Path: <davem@davemloft.net>
Date: Fri, 17 Feb 2012 16:01:16 -0500 (EST)
Message-Id: <20120217.160116.2085001213275947134.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1329493411-25750-7-git-send-email-danny.kukawka@bisect.de>
References: <1329493411-25750-1-git-send-email-danny.kukawka@bisect.de>
	<1329493411-25750-7-git-send-email-danny.kukawka@bisect.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 06/10] batman-adv: use
 eth_hw_addr_random() instead of random_ether_addr()
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: danny.kukawka@bisect.de
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, dkukawka@suse.de, linux-kernel@vger.kernel.org, siwu@hrz.tu-chemnitz.de, lindner_marek@yahoo.de

From: Danny Kukawka <danny.kukawka@bisect.de>
Date: Fri, 17 Feb 2012 16:43:27 +0100

> Use eth_hw_addr_random() instead of calling random_ether_addr()
> to set addr_assign_type correctly to NET_ADDR_RANDOM.
> 
> Remove dev_addr in interface_setup(), it's not needed anymore.
> 
> Reset the state to NET_ADDR_PERM as soon as the MAC get
> changed via .ndo_set_mac_address.
> 
> v2: use bitops, adapt to eth_hw_addr_random()
> 
> Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>

Applied.
