Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 12 Feb 2012 13:50:21 +0800
References: <1807712.xKAsDcUsSn@g10h4cklab>
In-Reply-To: <1807712.xKAsDcUsSn@g10h4cklab>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201202121350.22380.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman openwrt
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

On Saturday, February 11, 2012 08:36:22 Gioacchino Mazzurco wrote:
> After upgrading to latest batman version on openwt batman stopped adding 
> ethernet or bridge interfaces at start...
> 
> it add only wireless interfaces

Last night we got to the bottom of this. The new hotplug based system is at 
the core of the issue: The Ethernet driver on the device is compiled into the 
kernel, thus loaded before the batman-adv kernel module is loaded. As a result 
the "interface add" event is triggered before batman-adv is active and the 
device can't be added to the batman-adv mesh.

Filippo, I cc'ed you because you are the "father" of the hotplug based system. 
Seems we are having some side effects. Any idea how to fix it ?

Regards,
Marek
