Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 26 Jul 2009 18:00:37 +0800
References: <f7dbe3920907251632q24bde7c0w87dee1eb009f4520@mail.gmail.com>
In-Reply-To: <f7dbe3920907251632q24bde7c0w87dee1eb009f4520@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907261800.38267.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [batman-advanced]beginner questions
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


Hi,

> Could it work on "standard" broadcom hardware like WRT54gl?

WRT54G hardware comes with a choice of 2 drivers:
* The proprietary and binary only driver from Broadcom itself. This driver 
works quite well but does not support linux 2.6 (which is required by batman 
advanced).
* The open source driver written by the community. AFAIK OpenWRT supports this 
driver as well but the adhoc mode does not work sufficiently well. My 
information regarding the stability of that driver might be outdated. 


> Do I need multi ssid hardware? only atheros?

Multi-SSID hardware is not mandatory more a convenience feature. I'm not sure 
whether broadcom supports that as well.


> What about the ahdemo mode? is it like adhoc?

Yes, the ahdemo is quite similar to adhoc mode. In ahdemo the nodes don't send 
beacons, hence you "loose" all the features that are communicated via beacon 
packets. E.g. no network announcements, bitrate negotiations, etc


> If I want standard AP mode, must I create several ssid (1 ahdemo + 1 AP)
> then bridge bat0 to the AP ssid?

Yes, the AP mode clients access the mesh network transparently via the bridge.


> If I want to setup coova-chilli to drive the mesh (hotspot mesh), how could
> I ssh to the repeaters? Is some sort of VLAN supported? there would be 2
> separate networks in the mesh, one for gateway to repeater communication,
> the other for the hotspot mesh.
> Or maybe would it be possible that repeaters use a specific dhcp server
> (not chilli) to get their ip addresses?
> It looks that we can get the mac addresses of all repeaters. Can I use arp
> to get their IP?
> You would say "why ssh to the repeaters?", I don't know... Maybe for
> configuration/ monitoring...

In general, it is a good idea to contact the coova-chilli project for details 
related to their project. Batman-adv acts like an ordinary switch therefore 
all switch "features" are supported. VLAN should be no problem.

Regards,
Marek

