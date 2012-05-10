Return-Path: <davem@davemloft.net>
Date: Wed, 09 May 2012 20:43:04 -0400 (EDT)
Message-Id: <20120509.204304.1989479180629752763.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1336561976-16088-12-git-send-email-ordex@autistici.org>
References: <1336561976-16088-1-git-send-email-ordex@autistici.org>
	<1336561976-16088-12-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 11/14] batman-adv: Adding hard_iface
 specific sysfs wrapper macros for UINT
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
To: ordex@autistici.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, lindner_marek@yahoo.de

From: Antonio Quartulli <ordex@autistici.org>
Date: Wed,  9 May 2012 13:12:53 +0200

> +		/**
> +		* Mark the forwarded packet when it is not coming from our best
> +		* next hop. We still need to forward the packet for our neighbor
> +		* link quality detection to work in case the packet originated
> +		* from a single hop neighbor. Otherwise we can simply drop the
> +		* ogm.
> +		*/

Start comments with "/*" not "/**", and properly indent these lines.
