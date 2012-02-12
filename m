Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 12 Feb 2012 21:10:17 +0800
References: <1807712.xKAsDcUsSn@g10h4cklab>
	<201202121350.22380.lindner_marek@yahoo.de>
	<CAFevQmMDLCAgma40kpmcX9AKGbBjzobTiU7ad-Bp3TMcnhODXg@mail.gmail.com>
In-Reply-To: <CAFevQmMDLCAgma40kpmcX9AKGbBjzobTiU7ad-Bp3TMcnhODXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201202122110.17820.lindner_marek@yahoo.de>
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
To: Filippo Sallemi <tonyputi@gmail.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Sunday, February 12, 2012 21:03:20 you wrote:
> 2012/2/12 Marek Lindner <lindner_marek@yahoo.de>:
> > On Saturday, February 11, 2012 08:36:22 Gioacchino Mazzurco wrote:
> >> After upgrading to latest batman version on openwt batman stopped adding
> >> ethernet or bridge interfaces at start...
> >> 
> >> it add only wireless interfaces
> > 
> > Last night we got to the bottom of this. The new hotplug based system is
> > at the core of the issue: The Ethernet driver on the device is compiled
> > into the kernel, thus loaded before the batman-adv kernel module is
> > loaded. As a result the "interface add" event is triggered before
> > batman-adv is active and the device can't be added to the batman-adv
> > mesh.
> > 
> > Filippo, I cc'ed you because you are the "father" of the hotplug based
> > system. Seems we are having some side effects. Any idea how to fix it ?
> > 
> > Regards,
> > Marek
> 
> I need a few more hours and i'll send a full worked patch.

Any particular reason that you always email me privately ?

At this point it would be better to discuss a possible solution first. What if 
your patch does not work ? We can save time by talking about a solution before 
implementing it.

Regards,
Marek
