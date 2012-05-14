Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 15 May 2012 00:37:34 +0800
References: <1337010808.2814.70.camel@E-PC-JJ>
In-Reply-To: <1337010808.2814.70.camel@E-PC-JJ>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201205150037.35178.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Some problems with batman-adv
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

> I've set up the ad-hoc network with WPA-Encryption. This is working
> fine. I can access all nodes if i configure the ra0 (ralink wifi)
> interface with static ip addresses. I've done this for testing purpose
> only. Normally only the bat0 interface has an ip address.
>
> [..]
>
> # iwconfig 
> lo        no wireless extensions.
> dummy0    no wireless extensions.
> usb0      no wireless extensions.
> eth0      no wireless extensions.
> ra0       Ralink STA  ESSID:"ceR{)|n$v#pp|fJX"  Nickname:"RT2870STA"
>           Mode:Ad-Hoc  Frequency=2.442 GHz  Cell: DE:BB:8C:08:B8:EC   
>           Bit Rate=36 Mb/s   
>           RTS thr:off   Fragment thr:off
>           Encryption key:D83E-521A-8B9F-7C95-3ACE-D477-****-****

the ralink driver misses one very important feature to reliably run a larger 
adhoc mode cell: Assigning a manually chosen BSSID. Therefore, it would not 
suprise me if you experienced "cell splits" from time to time.
To verify this theory you can watch the BSSID (Cell) field on the involved 
nodes and run a continuous ping on your statically configured setup. If I am 
correct you also will experience packet loss and the BSSID will change.

Regards,
Marek
