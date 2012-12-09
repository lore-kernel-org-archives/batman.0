Return-Path: <moritzwarning@web.de>
Message-ID: <50C471C0.2060407@web.de>
Date: Sun, 09 Dec 2012 12:10:56 +0100
From: Moritz Warning <moritzwarning@web.de>
MIME-Version: 1.0
References: <CAHD-aqKfNck0Z4Zqw_MJYzTFN=dEVp=Xxu6SfgRSwtOeCpPXnw@mail.gmail.com>
 <CAHD-aq+pkXDfaVXtvMtSV6OK-umobdvYrUMeVYkW1Rsh7uM7iQ@mail.gmail.com>
 <201211261840.20610.lindner_marek@yahoo.de> <11476276.Zba4Nueg8B@bentobox>
 <CAHD-aqLUc7YAsmgOdGS2nxdU06U3KTbCAtjXHa4v_64fzHNhWg@mail.gmail.com>
In-Reply-To: <CAHD-aqLUc7YAsmgOdGS2nxdU06U3KTbCAtjXHa4v_64fzHNhWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv boot setup scheme on OpenWRT
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

I have tried batman-adv-netifd-proto-batadv.patch along with some Makefile adjustments to get it compile.
Afaict it works.

On 12/02/2012 02:19 PM, Gui Iribarren wrote:
> Really Sorry for the whitespace headaches :( hope to get it straight this time.
> 
> As we discussed on irc with Marek, here's a first stab at netifd integration.
> I'm surprised at how simple it actually is to add a custom "proto" with netifd
> 
> No race condition with this approach, at least on the hardware i have
> at hand (ubnt2 , and tplinks)
> 
> an example uci config scheme changes from
> 
> batman-adv.bat0=mesh
> batman-adv.bat0.interfaces='mesh0 mesh1 mesh2'
> batman-adv.bat0.bridge_loop_avoidance=1
> network.mesh{0,1,2}=interface
> network.mesh{0,1,2}.proto=none
> network.mesh{0,1,2}.mtu=1528
> wireless.@wifi-iface[]=wifi-iface
> wireless.@wifi-iface[].network=mesh{0,1,2}
> wireless.@wifi-iface[].mode=adhoc
> 
> to
> 
> batman-adv.bat0=mesh
> batman-adv.bat0.bridge_loop_avoidance=1
> network.mesh{0,1,2}=interface
> network.mesh{0,1,2}.proto=batadv
> network.mesh{0,1,2}.mesh=bat0
> network.mesh{0,1,2}.mtu=1528
> wireless.@wifi-iface[1]=wifi-iface
> wireless.@wifi-iface[1].network=mesh{0,1,2}
> wireless.@wifi-iface[1].mode=adhoc
> 
> So /etc/config/batman-adv now deals only with bat0 tweakable parameters,
> /etc/config/network defines interfaces to be added to bat0
> and /etc/config/wireless is unchanged
> 
> and netifd is responsible of avoiding race conditions
> of course, this makes batman-adv package (on openwrt) depend on
> netifd, but openwrt devs are pushing it that way (and it's finally
> looking like an elegant move after all ;) )
> 
> Cheers!
> 
> On Mon, Nov 26, 2012 at 7:45 AM, Sven Eckelmann <sven@narfation.org> wrote:
>> On Monday 26 November 2012 18:40:20 Marek Lindner wrote:
>>> On Friday, November 23, 2012 22:00:47 Gui Iribarren wrote:
>>>> Boring bootlog at http://pastebin.com/59FEPttY
>>>>
>>>> Proposed patch follows (against current batman-adv in openwrt 'packages'
>>>> feed)
>>>>
>>>> Signed-off-by: Gui Iribarren <gui@altermundi.net>
>>>
>>> I made the necessary changes myself after I successfully de-scrambled your
>>> patch. You will find the patch in OpenWrt trunk. Give it try!
>>> Next time, please configure your mail client to not wrap lines.
>>
>> http://lxr.linux.no/linux+v2.6.30/Documentation/email-clients.txt
>>
>> Kind regards,
>>         Sven

