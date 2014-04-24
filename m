Return-Path: <dicht@operamail.com>
Message-Id: <1398346706.1416.109931001.56F7753F@webmail.messagingengine.com>
From: Thijs van Veen <dicht@operamail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Date: Thu, 24 Apr 2014 15:38:26 +0200
In-Reply-To: <20140424125820.GR26376@medion.lan>
References: <5358CCA4.2050203@wirelesspt.net>
 <201404241148.19217.sw@simonwunderlich.de>
 <1398340673.9414.109890229.7C3D1C45@webmail.messagingengine.com>
 <20140424125820.GR26376@medion.lan>
Subject: Re: [B.A.T.M.A.N.] [Battlemesh] Batman-adv high TQ and Low
	throughput
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>

It depends a bit on the receiver's quality, I've had experiences where
the SNR could drop to about 8 and the link would still somewhat work.

The thermal noise is mostly intrinsic to how energy relates at a
particle level, this is denoted by the Boltzmann constant (k). 
Further, it depends on the bandwidth (B) used and temperature (T).
Nthermal = B * k * T = 20*10^6 Hz (802.11 channel) * 1.38065*10^-23 J/K 
* 300 K (27 Celsius) ~= 8.28 * 10^-11
This gives the noise in Watts, to change it to dBm (which references
miliWatts), you take 10*log10( N * 1000 ) ~= -100.
[1] Has a nice table with examples of this noise.

In reality, there's more interference than just from the temperature.
It's quite probable your receiver adds another 5 dBm to its reported
noise to account for this.
I also recall from my time working on my thesis that receivers/drivers
tend to return a static value for noise, rather than actually measure
it.

[1]:http://en.wikipedia.org/wiki/Thermal_noise#Noise_power_in_decibels

-- 
  Thijs van Veen
  dicht@operamail.com


On Thu, Apr 24, 2014, at 14:58, Bastian Bittorf wrote:
> * Thijs van Veen <dicht@operamail.com> [24.04.2014 14:45]:
> > N is usually somewhere around -100 dBm, meaning that a Prx of about -85
> 
> unsure about that: it depends on the WiFi-receiver's quality, isn't it?
> 
> when i use 'iwinfo' the noise is always '-95', no matter on which
> location.
> it seems to come from nl80211_get_noise() but i dont understand it fully.
> 
> or do i mix something up? bye, bastian

-- 
http://www.fastmail.fm - Or how I learned to stop worrying and
                          love email again

