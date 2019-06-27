Return-Path: <davem@davemloft.net>
Date: Thu, 27 Jun 2019 09:50:43 -0700 (PDT)
Message-Id: <20190627.095043.1607458136575294159.davem@davemloft.net>
Subject: Re: [PATCH 06/10] batman-adv: mcast: collect softif listeners from
 IP lists instead
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190627103938.7488-7-sw@simonwunderlich.de>
References: <20190627103938.7488-1-sw@simonwunderlich.de>
 <20190627103938.7488-7-sw@simonwunderlich.de>
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
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linus.luessing@c0d3.blue, sven@narfation.org

From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 27 Jun 2019 12:39:34 +0200

> +	in_dev = in_dev_get(dev);
> +	if (!in_dev)
> +		return 0;

Move this below the rcu_read_lock() and use __in_dev_get_rcu()
instead.

And then...

> +
> +	rcu_read_lock();
 ...
> +	rcu_read_unlock();
> +	in_dev_put(in_dev);

You can drop this in_dev_put() as well.

> +	in6_dev = in6_dev_get(dev);
> +	if (!in6_dev)
> +		return 0;
> +
> +	read_lock_bh(&in6_dev->lock);

Similarly here you can use __in6_dev_get().
