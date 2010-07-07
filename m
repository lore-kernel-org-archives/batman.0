Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 7 Jul 2010 12:40:27 +0200
References: <20100706175814.6927f767@rechenknecht>
	<1278431960-4636-2-git-send-email-an.langer@gmx.de>
In-Reply-To: <1278431960-4636-2-git-send-email-an.langer@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201007071240.27837.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: layer2 unicast packet
	fragmentation
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tuesday, July 06, 2010 17:59:20 Andreas Langer wrote:
> +       if (atomic_read(&bat_priv->frag_enabled) && batman_if->net_dev->mtu
> < +               ETH_DATA_LEN + BAT_HEADER_LEN)
> +               bat_info(soft_device,
> +               "The MTU of interface %s is too small (%zi) to handle "
> +               "the transport of batman-adv packets. Packets going "
> +               "over this interface will be fragmented on layer2 "
> +               "which could impact the performance. Setting the MTU "
> +               "to %zi would solve the problem.\n",
> +                batman_if->dev, ETH_DATA_LEN + BAT_HEADER_LEN,
> +                ETH_DATA_LEN + BAT_HEADER_LEN);

The required MTU gets printed twice here. I guess you wanted to print this:
 batman_if->dev, batman_if->net_dev->mtu,
 ETH_DATA_LEN + BAT_HEADER_LEN


> +       if (!atomic_read(&bat_priv->frag_enabled) &&
> batman_if->net_dev->mtu < +               ETH_DATA_LEN + BAT_HEADER_LEN)
> +               bat_info(soft_device,
> +               "The MTU of interface %s is too small (%zi) to handle "
> +               "the transport of batman-adv packets. If you experience"
> +               " problems getting traffic through try increasing the "
> +                "MTU to %zi.\n",
> +                batman_if->dev, ETH_DATA_LEN + BAT_HEADER_LEN,
> +                ETH_DATA_LEN + BAT_HEADER_LEN);

Here we have the same issue.

Regards,
Marek

