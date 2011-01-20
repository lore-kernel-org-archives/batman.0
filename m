Return-Path: <tcannon@generalpacket.com>
Message-ID: <4D3855DD.3020604@generalpacket.com>
Date: Thu, 20 Jan 2011 07:33:49 -0800
From: Tom Cannon <tcannon@generalpacket.com>
MIME-Version: 1.0
References: <9593ED11D39C4938AB059ECE63244111@granch.local>	<20110120082521.GA14117@Sellars>
	<4D37F45B.9000106@gmail.com> <20110120125259.GA14504@Sellars>
In-Reply-To: <20110120125259.GA14504@Sellars>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] Stup batman ADv devel on openWRT
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
To: b.a.t.m.a.n@lists.open-mesh.org

Linus is correct.  You cannot bridge the wireless interface with bat0.
The wireless interface is managed by bat0.
bat0 gets bridged with your lan port(s).

If you remove the line 'option network  lan' from /etc/config/wireless 
it should start working.

I have batman-adv running quite well on both kamikaze and backfire with 
atheros/madwifi.

I did, however have to play around with MTU settings to get it working 
at an acceptable throughput.
Also, by default, the interface 'wlan0' is in /etc/config/batman-adv and 
I had to change that to 'ath0' for atheros..


On 1/20/2011 4:52 AM, Linus Lüssing wrote:
> On Thu, Jan 20, 2011 at 10:37:47AM +0200, wayne wrote:
>> Linus Lüssing wrote:
>>> Hi Michael,
>>>
>>> You have a bridge loop here, you cannot put an interface into
>>> batman-adv and bridge the same one with bat0 again which seems to
>>> be the case for wlan0. Packets will enter wlan0, batman will grab
>>> them, encapsulate it in its own batman header and send the same
>>> packet on wlan0 again, reaching another batman-adv
>>> node, which encapsulates the same packet again etc.
>>>
>>
>> Hi All
>>
>> If I can jump in here, I had the same prob with batman L3 in wrt
>> with the bridge!
>>
>> Killing the Br-lan bridge kills everything, I eventually solved it
>> by flashing a old kamakaze version : pre bridge version, which
>> provides the simple ,
>>
>> eth0, eth1 , scenario!
>>
>> Wayne A
>>
> Sorry, but I don't get it, how are the batman-adv and batmand
> bridge issues related? Why should an older OpenWRT "fix" this? In
> this scenario I'm 100% that using a different OpenWRT version will
> _not_ help Michael, as it is a conceptual issue, not a bug or so.
>
> What kind of pre bridge version are you talking about?
>
> Cheers, Linus
