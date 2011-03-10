Return-Path: <onelektra@gmx.net>
From: elektra <onelektra@gmx.net>
Date: Thu, 10 Mar 2011 11:17:11 +0100
References: <201103091835.10969.onelektra@gmx.net>
	<201103100012.18223.onelektra@gmx.net>
	<20110310065858.GA12886@lunn.ch>
In-Reply-To: <20110310065858.GA12886@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201103101117.11268.onelektra@gmx.net>
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi all -

> An option would be to move to IPv6 and use stateless address
> autoconfiguration, where the MAC address is used to form part of the
> IPv6 address. You can then easily see from the IP address which device
> it is, assuming you know its MAC address.

the background of my thoughts was how far we can get with non-technical people just taking a 
bunch of Mesh-Potatoes out of the box, connecting one of them to an existing LAN segment with 
DHCP and Internet uplink. The setup should allow them to make calls amongst each other and 
simplifying the gateway setup, so they can use the Internet and make international calls. The 
MPs should also have a Accesspoint VAP.

This is an attempt of squaring the circle, of course...

Having said that batman-adv is pretty powerful with this regard. I just wanted to initiate some 
public brainstorming about how to solve the problem of identifying each device for debugging 
purposes when using DHCP.

Writing down each devices MAC address and using IPv6 is a feasible approach, but I figure it 
would be not intuitive.

However Mareks suggestion of adding a alias IP (we have a Asterisk IVR extension that can do 
this) is a valid suggestion.  

The requirement to enter a IP via the phone keypad is not exactly zero configuration, but given 
the enormous set of features that we can offer, it is pretty close. Thanks!


Cheers,
Elektra 
