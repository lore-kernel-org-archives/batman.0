Return-Path: <carlosmeralto@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALaFpeV+fto4F2iNFZT=VXdX9ZdK-XfyP2Kpyv++eFCBiS0FuA@mail.gmail.com>
References: <CALaFpeXinpuqi_5tZoih9jm77Ed0WsP_soZm3RbTpOmpzqWPSg@mail.gmail.com>
 <ba0c1c011cd6fb42c76276ec510c9acc@hilses.de>
 <CALaFpeV+fto4F2iNFZT=VXdX9ZdK-XfyP2Kpyv++eFCBiS0FuA@mail.gmail.com>
Date: Wed, 17 Jun 2015 22:36:53 +0100
Message-ID: <CALaFpeV+G6rVgtXiEpQ1qNBsg2r2hAcmit7Cxe-8PmnHS+MzZg@mail.gmail.com>
From: Carlos Meralto <carlosmeralto@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] [BATMAN] batman-adv PING layer 3
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi again.

Before some more research i found a solution...
The ip needs to be setup on bat0 and not on adhoc0.

So the final configuration:

config interface 'mesh'
       option ifname 'adhoc0'
       option mtu '1528'
       option proto 'batadv'
       option mesh 'bat0'

And run this commands to attribute a IP on bat0 interface:

uci set network.bat0=interface
uci set network.bat0.ifname=bat0
uci set network.bat0.proto=static
uci set network.bat0.mtu=1500
uci set network.bat0.ipaddr=NODE-IP
uci set network.bat0.netmask=NETMASK
uci set batman-adv.bat0.interfaces="adhoc0"
uci commit
reboot & exit

Thanks Hans-Werner ;) and and hopefully help someone with the same problem

2015-06-17 22:09 GMT+01:00 Carlos Meralto <carlosmeralto@gmail.com>:
> 2015-06-17 21:34 GMT+01:00 Hans-Werner Hilse <hw@haveyouseenthiscat.de>:
>> a batman interface is being set up, but left unconfigured.
>
> Why you say that has not been configured?
>
>> On the other hand, you set up IP adresses for the adhoc network, which
>> probably isn't needed and the point where the confusion arises.
>>
>> What you probably want to do is to add bat0 to the bridge's interfaces, and
>> maybe get rid of the IPv4 addresses on the adhoc interface, too (not that
>> they matter, though).
>>
>> Of course, when you do not want to bridge the LAN interfaces, you need
>> another way to setup IP addresses for bat0.
>
> What I want is to have an IP that allows me to ping from node A to
> node C. So join adhoc0 the bridge?
