Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 6 Sep 2011 20:33:17 +0200
References: <4E5D69E3.30403@robotech.de>
	<201109051006.13844.lindner_marek@yahoo.de>
	<4E65E286.7080600@robotech.de>
In-Reply-To: <4E65E286.7080600@robotech.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201109062033.17427.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.2.0 hop somtimes does not work
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

> i needed to get this working so i switched to 2011.2 last weekend and
> the problems are gone.

ok.


> I have some similar devices as spare parts. I'll try to set them up and
> reproduce the problems - but that can take a while.

Understood. We hopefully come up with a patch soon that will need to be 
tested.


> - every node has only one wlan-network on which batman runs and only the
> node itself uses the bat0 interface - no bridging, no routing
> - at the end, most of the time only the directly connected nodes were
> reachable via a normal ping - the "hopping" was not working
> - i had the *feeling* that the problems got bigger the more nodes we added
> - also i *think* the problems began when we mixed Fonera- and
> TP-Link-devices (sightly different architecture i think)

Can you tell us what TP-Link model you are using (name, hardware revision, 
etc). Or post the output of /proc/cpuinfo ?


> - the log was always spammed with messages - because of the tiny devices
> i use it's not easy to save the log and inspect it when the connection
> is working again - which can take an hour...

It is somewhat troublesome that the problem went away after a while. If we 
have a bug in the architecture handling you would expect it to be a permanent 
problem. But who knows ...

Regards,
Marek
