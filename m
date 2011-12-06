Return-Path: <wuchi@nerdshack.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
References: <DM__111206165734_29183085106@smtp.gmail.com>
Date: Tue, 06 Dec 2011 11:23:33 +0100
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Wuchi <wuchi@nerdshack.com>
Message-ID: <op.v52chjg7wsdi2w@winxp-aspire>
In-Reply-To: <DM__111206165734_29183085106@smtp.gmail.com>
Subject: Re: [B.A.T.M.A.N.] about batman performance
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

Hi zb981gm,

we had a (somewhat) similar performance issue with our setup some time ago. We found out that a setup of two n-Cards in a single room decrease performance heavily, if both cards are under load at the same time. Forcing the cards into b/g mode did not help, so changing the cards to b/g hardware solved the problem for us.

May had to do with those fallback window override issues some n-Cards have, but not sure. In general, don't expect too much of an performance increase with n-Hardware on a USB 2.0 interface.

May be worth a try to look at first before fiddling around with the protocol, IMHO.

- Wuchi

Am 06.12.2011, 10:01 Uhr, schrieb zb1981gm <zb80211@gmail.com>:

> I have used batman on my project for several months.It performs very well,stable especially!
> But,actually,I am not satisfied with the performance of Batman.I found that the bandwidth would drop sharply with the wireless hop increase.
> Now I provide my test result here:
>
> routerA and routerB is composed of compex wp543ahv mainboard (AR7161 platform) and two AR9220 wireless card.Firmware is Openwrt backfire.
> one card is working on 2.4G channel as AP mode,the other is working on 5G channel as mesh backbone
> batman version:2.0
> notebook1 and notebook2 is equiped with 802.11n usb wireless card which access to the AP mode card of routerA and routerB
>
>             channel 1                 channel 36              channel 11
> notebook1 ---------------  routerA --------------  routerB -------------- notebook2
>
> I use iperf to test bandwidth
>
> notebook1 ----------- routerA    45Mbps
> routerA   ----------- routerB    46Mbps
> routerB   ----------- notebook2  45Mbps
>
> But the bandwidth between notebook1 and notebook2 remains 8Mbps
> bandwidth between notebook1 and routerB remain 18Mbps
>
> So the conclution is that the bandwidth will be halfed with the 1 hop increase! right?
>
> I also found that the interface alternating mode and bonding mode doesn't take effect
>
>               channel 1
> routerA  ------------------  routerB
>               channel 36
>
> The test result is no difference whatever I configured alternating or bonding or just single radio
>
> According to the batman official site, alternating or bonding mode would improve the performance compared with the single radio mode
>
> looking forward  somebody's help
> highly appreciated!

