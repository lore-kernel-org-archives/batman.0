Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 20 Oct 2009 23:33:53 +0800
References: <45f642440910200802u6864b4cfk6b52f03bed14f8fe@mail.gmail.com>
In-Reply-To: <45f642440910200802u6864b4cfk6b52f03bed14f8fe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200910202333.53437.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] basic B.A.T.M.A.N-adv setup
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

> From the beginning, I am using batman-adv 3.2 compiled along with batctl.

batman-adv 3.2 ? I guess you mean 0.2 ?


> $ insmod batman-adv.ko
> $ iwconfig wlan0 mode ad-hoc essid BATMAN_NET
> $ echo wlan0 > /proc/net/batman-adv/interfaces
> $ ifconfig wlan0 192.168.1.xxx up
> $ ifconfig bat0 up

The wlan0 device does not need an IP address. It needs to be up & running but 
the IP goes on the bat0 device.  


> I get a new bat0 interface, iwconfig shows nodes properly part of the
>  ad-hoc network.
> I see correct $batctl o  output but i cannot $batctl ping $mac_address

Would you mind showing us the batctl o output and the batctl ping call plus 
error message(s) ?


> There are no bridges between interfaces. I just want to run batman-adv  on
> wlan0.
> Do I need to set an IP address for wlan0, for bat0 or for both?
> Or I have to bridge bat0 and wlan0 together?

No, don't bridge bat0 and wlan0. Imagine you had another wifi interface in 
managed mode for non-batman nodes to connect to (e.g. wlan1). Then you would 
want to make the mesh accessible for the managed clients by bridging bat0 with 
wlan1.

Regards,
Marek
