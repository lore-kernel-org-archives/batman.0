Return-Path: <stephen@networkplumber.org>
Date: Thu, 1 Oct 2020 14:25:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net 00/12] net: iflink and link-netnsid fixes
Message-ID: <20201001142538.03f28397@hermes.local>
In-Reply-To: <cover.1600770261.git.sd@queasysnail.net>
References: <cover.1600770261.git.sd@queasysnail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>

On Thu,  1 Oct 2020 09:59:24 +0200
Sabrina Dubroca <sd@queasysnail.net> wrote:

> In a lot of places, we use this kind of comparison to detect if a
> device has a lower link:
> 
>   dev->ifindex != dev_get_iflink(dev)


Since this is a common operation, it would be good to add a new
helper function in netdevice.h

In your patch set, you are copying the same code snippet which
seems to indicate that it should be a helper.

Something like:

static inline bool netdev_has_link(const struct net_device *dev)
{
	const struct net_device_ops *ops = dev->netdev_ops;

	return ops && ops->ndo_get_iflink;
}
