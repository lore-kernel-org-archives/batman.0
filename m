Return-Path: <andrew@lunn.ch>
Date: Fri, 12 Feb 2016 16:25:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160212152536.GA13273@lunn.ch>
References: <1455225357-15756-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455225357-15756-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint v2] batman-adv: Avoid endless loop
 in bat-on-bat netdevice check
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

>  /**
> + * batadv_mutual_parents - check if two devices are each others parent
> + * @dev1: 1st net_device
> + * @dev2: 2nd net_device
> + *
> + * veth devices come in pairs and each is the parent of the other!
> + *
> + * Return: true if the devices are each others parent, otherwise false
> + */
> +static bool batadv_mutual_parents(const struct net_device *dev1,
> +				  const struct net_device *dev2)
> +{
> +	int dev1_parent_iflink = dev_get_iflink(dev1);
> +	int dev2_parent_iflink = dev_get_iflink(dev2);
> +
> +	if (!dev1_parent_iflink || !dev2_parent_iflink)
> +		return false;
> +
> +	return (dev1_parent_iflink == dev2->ifindex) &&
> +	       (dev2_parent_iflink == dev1->ifindex);
> +}

Hi Sven, et al,

So this is fine for the non netns case.

But what about the netns case? This is mainly a backward compatible
issue. It sounds like some of the older kernels you have via compat.h
are going to have issues with netns support. What do the maintainers
what to do about this? NACK my patches, drop support for some of the
older kernels? Something else?

Thanks
	Andrew
