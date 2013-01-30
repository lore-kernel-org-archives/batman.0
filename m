Return-Path: <gofb-b.a.t.m.a.n@m.gmane.org>
From: Rip route <riproute@gmail.com>
Date: Wed, 30 Jan 2013 22:25:27 +0000 (UTC)
Message-ID: <loom.20130130T231956-461@post.gmane.org>
References: <loom.20130130T212716-301@post.gmane.org>
 <20130130220316.GA11109@ritirata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Using BATMAN to create a repeater
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Antonio Quartulli <ordex@...> writes:

> 
> On Wed, Jan 30, 2013 at 08:30:52PM +0000, Rip route wrote:
> > All,
> > I am trying to create a WiFi repeater using hardware that cannot accommodate 
a 
> > normal "bridged repeater" mode. Is it possible to create this type of 
repeater 
> > using BATMAN adv?
> 
> If I correctly got your question you may want to connect two nodes via 
wireless,
> then install batman-adv on top of the wifi interfaces ans consequently bridge
> the bat0 with the ethernet interface:
> 
>      wlan0~~~~~~~wlan0
>        .          .
>       bat0       bat0
>        .          .
>       br0        br0
>        .          .
>      eth0        eth0
>        |          |
> ETH____/          \_______ETH
> 
> wlan0s can be two adhoc interfaces (common case for a mesh) or also an AP/sta
> pair.
> 
> Cheers,
> 

Thanks but I need to create a repeater where I can't load anything on the root 
AP, I can only access the repeater.

 client1~~~~~wlan0~~~~~~~wlan0~~~~~~client2
               |          
        ETH____/          


