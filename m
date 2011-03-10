Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 10 Mar 2011 01:53:54 +0100
References: <201103091835.10969.onelektra@gmx.net>
	<201103092341.19214.lindner_marek@yahoo.de>
	<201103100012.18223.onelektra@gmx.net>
In-Reply-To: <201103100012.18223.onelektra@gmx.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201103100153.54915.lindner_marek@yahoo.de>
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


Hi,

> I have been playing with batman-adv on the Mesh-Potato, and I will come up
> with a batman-adv based version of the MP firmware.

cool!


> However I have seen interesting new challenges. For example, if the MPs
> just get their IP configuration from a DHCP server this eliminates the
> process of configuring an IP for each device. That is cool. On the other
> hand, not knowing which IP is assigned to which device introduces new
> problems. It makes debugging radio problems and hardware issues much
> harder in the field. So picking up a phone and punching in a static IP via
> the keypad for each device is not all bad, if you just want to be able to
> call one MP from the other by dialling the last octet of its IP.

I don't really understand where you see the "new" challenges. If you require 
static IP addresses you can deal with that in the same way you did without 
batman-adv. You could configure alias interfaces, calculate an IP out of the 
MAC or even use DHCP to assign always the same IP address to a certain client.
How your setup looks like very much depends on your requirements.


> Is there a special way of handling IPv4 ARP packets in batman-adv? I figure
> ARP must be much more robust in a Layer 3 mesh.

There is no special handling yet (expect for the ARQ mechanism for all 
broadcast packets). I also suspect that ARP requires some more attention but 
nobody has done that so far.

Cheers,
Marek
