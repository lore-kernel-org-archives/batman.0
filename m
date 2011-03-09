Return-Path: <onelektra@gmx.net>
From: elektra <onelektra@gmx.net>
Date: Thu, 10 Mar 2011 00:12:17 +0100
References: <201103091835.10969.onelektra@gmx.net>
	<201103092341.19214.lindner_marek@yahoo.de>
In-Reply-To: <201103092341.19214.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201103100012.18223.onelektra@gmx.net>
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

Hi Marek -

> meaning you are maintaining batmand ? Should we change our wiki pages that 
> claim batmand has no maintainer ?

yes, I am glad to do this. I feel there is room for a simple Layer 3 implementation of Batman beside the exiting batman-adv. And hey, I have started the Batman project with the early bits of this code together with Thomas. Call it nostalgia ;-) And I am also thinking about using a scaled-down batmand version as a proactive mesh protocol for microcontrollers and for shortwave radio meshes with low bandwidth.

As a sidenote:

I have been playing with batman-adv on the Mesh-Potato, and I will come up with a batman-adv based version of the MP firmware. It opens up a exciting set of new features. Bridging a VAP AP with the LAN port and the bat0 interface is really cool.

However I have seen interesting new challenges. For example, if the MPs just get their IP configuration from a DHCP server this eliminates the process of configuring an IP for each device. That is cool. On the other hand, not knowing which IP is assigned to which device introduces new problems. It makes debugging radio problems and hardware issues much harder in the field. So picking up a phone and punching in a static IP via the keypad for each device is not all bad, if you just want to be able to call one MP from the other by dialling the last octet of its IP. 

Is there a special way of handling IPv4 ARP packets in batman-adv? I figure ARP must be much more robust in a Layer 3 mesh. 
 
Cheers,
Elektra
