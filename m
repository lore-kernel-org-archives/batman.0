Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 18 Jan 2010 19:42:05 +0800
References: <20100118112706.91160@gmx.net>
In-Reply-To: <20100118112706.91160@gmx.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201001181942.05380.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
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

> The problem comes when I try to add my little ARM based linux box onto the
>  group. Again same sources used (latest stable from the wiki),
>  crosscompiles fine and I can load the module as normal on the box. Setup
>  goes as it should on both the device and the laptop, and both systems
>  seems to be running smoothly. But my laptop can only see the other laptop,
>  and the device doesn't see anyone. The wireless net is working and I can
>  ping each device directly if I assign IP's to the 'real' interfaces, but
>  through bat0 nothing is found. Any idea what is going wrong?

as soon as normal pings work batman-adv should also work. From what you 
describe I can't see any obvious mistake. Did you try to peek into the debug 
logs or capture some packets to see whether the nodes are communicating 
correctly ?


> I've also played with the batman daemon on the device, with it I the laptop
>  and device can see each other just fine. The problem there is that
>  apparently it doesn't really support multicast forwarding? i.e. If I have
>  3 devices A-B-C, where A does not have direct link to C (batman routes
>  through B), sending a multicast from A can be received in B and vice
>  versa, also same for C-B, but no messages from A to C. Will I have the
>  same problem with batman-adv? Or can this be fixed on the daemon?

The daemon operates on layer 3, therefore multicast forwarding can't work.

Some other layer 3 routing daemons try to support multicast by hacking a layer 
2 tunneling into the daemon. The performance is poor at the expense of CPU 
load but give it a try yourself in case this is no problem. 

However, batman-adv supports multicast out of the box.

Regards,
Marek
