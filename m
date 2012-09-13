Return-Path: <emunicio@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMVTf1j8S7-Ars4Ugt=jz_noyS0Zvs9SyVH-RTZoJ2qBGGO1UQ@mail.gmail.com>
References: <h1pf9bti26g2966o34ml5cv4.1347057546796@email.android.com>
 <CAMVTf1hKCgkmwgz_bUYwULcgFdoSraog2D1HRSZiTi46w7GcDw@mail.gmail.com>
 <CAHD-aqJzD54DXkW+wPJV0r4zOoTedgKsSSjPS6STSAYaxfMLOg@mail.gmail.com>
 <CAMVTf1j8S7-Ars4Ugt=jz_noyS0Zvs9SyVH-RTZoJ2qBGGO1UQ@mail.gmail.com>
From: Esteban Municio <emunicio@gmail.com>
Date: Thu, 13 Sep 2012 12:00:50 -0500
Message-ID: <CAMVTf1iC00WxRVs6ogHVcNqi590Nqtwtisv-TmSQm+vAPV=Bkg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] How to force a specific network topology
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

Hi again

I'm still having problems with this issue

I can not bridge wlan0 for use ebtables.Now I am bridging without
eth0, only with the wireless interfaces. With the device freshly
rebooted and with empty /etc/rc.local :

brctl addbr bridgeWlan
brctl addif bridgeWlan wlan0
brctl: bridge bridgeWlan: Operation not supported

I searched for this I found that you can set this if you do:

iw dev wlan0 set 4addr on

but you only can do this if your wireless interface is in mode ap, and
mine is on adhoc.
So I can't set the bridge with batman (batctl if add bridgeWlan)
This is my wireless device configuration in /etc/confiog/wireless

config wifi-iface
	option device   radio0
	option network  lan
	option mode     adhoc
	option ssid     netmesh
	option encryption none

=BFDo you know how could I set the bridges correctly for ebtables filtering=
?

Thanks!
Regards

Esteban


2012/9/10 Esteban Municio <emunicio@gmail.com>:
> Thanks you very much Gui and Sven
>
> Now I understand the configuration and install ebtables has seem quite si=
mple.
>
> Regards
>
>
> 2012/9/10 Gui Iribarren <gui@altermundi.net>:
>> On Mon, Sep 10, 2012 at 12:18 PM, Esteban Municio <emunicio@gmail.com> w=
rote:
>>> Hi Sven
>>>
>>> I don't understand very well what are you meaning. Now I have 1 bridge
>>> over with batman-adv:
>>>
>>> batctl if add wlan0
>>> brctl addbr mesh-bridge
>>> brctl addif mesh-bridge eth0
>>> brctl addif mesh-bridge bat0
>>>
>>> Then, should I add a bridge to wlan0 and after bridge it again with the=
 eth0?
>>>
>>> brctl addbr bridgeWlan
>>> brctl addif bridgeWlan wlan0
>>>
>>> batctl if add mesh-bridge
>>> brctl addbr mesh-bridge
>>> brctl addif mesh-bridge eth0
>>> brctl addif mesh-bridge bat0
>>
>> Not quite. I think he meant:
>>
>> brctl addbr mesh-bridge
>> brctl addif mesh-bridge eth0
>> brctl addif mesh-bridge bat0
>>
>> batctl if del wlan0
>> brctl addbr bridgeWlan
>> brctl addif bridgeWlan wlan0
>>
>> batctl if add bridgeWlan
>>
>> and from there, ebtables.
>
>
>
> --
> Esteban



--=20
Esteban
