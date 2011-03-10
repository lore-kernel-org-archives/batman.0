Return-Path: <andrew@lunn.ch>
Date: Thu, 10 Mar 2011 07:58:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110310065858.GA12886@lunn.ch>
References: <201103091835.10969.onelektra@gmx.net>
	<201103092341.19214.lindner_marek@yahoo.de>
	<201103100012.18223.onelektra@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201103100012.18223.onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] Maintainer of vis and batmand
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

> However I have seen interesting new challenges. For example, if the
> MPs just get their IP configuration from a DHCP server this
> eliminates the process of configuring an IP for each device. That is
> cool. On the other hand, not knowing which IP is assigned to which
> device introduces new problems. It makes debugging radio problems
> and hardware issues much harder in the field. 

Hi Elektra

An option would be to move to IPv6 and use stateless address
autoconfiguration, where the MAC address is used to form part of the
IPv6 address. You can then easily see from the IP address which device
it is, assuming you know its MAC address.

   Andrew
