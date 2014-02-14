Return-Path: <andrew@lunn.ch>
Date: Fri, 14 Feb 2014 19:18:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140214181850.GI17451@lunn.ch>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-19-git-send-email-antonio@meshcoding.com>
 <20140213105249.GH7193@lunn.ch> <52FCA639.9080204@meshcoding.com>
 <20140213114449.GI7193@lunn.ch> <52FDD2CB.70104@meshcoding.com>
 <20140214173841.GH17451@lunn.ch> <52FE5662.7000108@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52FE5662.7000108@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 18/23] batman-adv: ELP - use phydev to
 determine link characteristics
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> Are you 100% sure that the NETDEV_UP event was sent within those 3
> seconds and not after?
> If you use a serial console you should see the kernel output mixed with
> your test. (just to be 100% sure..)

http://lxr.free-electrons.com/source/net/core/dev.c#L1286

1286 int dev_open(struct net_device *dev)
1287 {
1288         int ret;
1289 
1290         if (dev->flags & IFF_UP)
1291                 return 0;
1292 
1293         ret = __dev_open(dev);
1294         if (ret < 0)
1295                 return ret;
1296 
1297         rtmsg_ifinfo(RTM_NEWLINK, dev, IFF_UP|IFF_RUNNING, GFP_KERNEL);
1298         call_netdevice_notifiers(NETDEV_UP, dev);
1299 
1300         return ret;
1301 }


So the NETDEV_UP is sent as soon as __dev_open() returns,
i.e. ndo_open().

What i do see is:

half
1000
half
1000
half
1000
half
1000
half
1000
half
1000
mv643xx_eth_port mv643xx_eth_port.0 eth0: link up, 1000 Mb/s, full duplex, flowd
full
1000

The link up is from:

http://lxr.free-electrons.com/source/drivers/net/ethernet/marvell/mv643xx_eth.c#L1990

There is no sign of a call_netdevice_notifiers() here, but i think a
netlink message will be sent to userspace because of the
netif_carrier_on() call.

   Andrew
