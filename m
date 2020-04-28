Return-Path: <oguzhan@kayhan.name.tr>
MIME-Version: 1.0
References: <CANKYHpeiWj7w2KEnkEfjUHWKfbhEAj7kMVE5hL5xv6O_1ZVFwg@mail.gmail.com>
 <CANKYHpcZU09emNFy3yf4K0F5s8gzT6giosqfCDNj278f6Z3_mQ@mail.gmail.com>
 <CANKYHpcYxPD1tF4EB2hFT891X=FwqiRbo3xCTofxSgdteqES6g@mail.gmail.com> <9817716.HyuBmzvnZK@bentobox>
In-Reply-To: <9817716.HyuBmzvnZK@bentobox>
From: Oguzhan Kayhan <oguzhan@kayhan.name.tr>
Date: Tue, 28 Apr 2020 13:36:53 +0300
Message-ID: <CANKYHpf+GVA8zWuc-eZXh_6aW5FkpM3Oj3QbTKiTkfDZvUgGHA@mail.gmail.com>
Subject: Re: configuration issue
Content-Type: text/plain; charset="UTF-8"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hello Sven ,
I really appreciate your kind help.
Yes I am sadly aware of the version problem of Gateworks and I already
notified them about an update on repo

It failed when I add
 option encryption 'psk2'
 option key 'thisisaverysecretkey'

but it was working with adhoc.. I will seach for if any needed package
is missing or not.

Regards


On Tue, Apr 28, 2020 at 12:51 PM Sven Eckelmann <sven@narfation.org> wrote:
>
> On Tuesday, 28 April 2020 11:28:25 CEST Oguzhan Kayhan wrote:
> [...]
> > Now my config is as follows on both wifi nodes
> >
> > wireless:
> > config wifi-iface 'wmesh'
> >         option device 'radio0'
> >         option ifname 'mesh0'
> >         option mode 'mesh'
> >         option mesh_id 'test'
> >         option mesh_fwding '0'
> >         option mesh_ttl '1'
> >         option mcast_rate '18000'
> >         option encryption 'none'
> [...]
> > Now here comes the second part..
> > How can I make the encryption over mesh?
>
> This is not an Gateworks OpenWrt 18.x support mailing list btw.
> And the OpenWrt documentation [1,2] explains how to do this.
>
> Anyway, you can enable it on OpenWrt by selecting wpad-mesh-openssl (or
> wpad-mesh on older OpenWrt versions). and then using something like:
>
>     config wifi-iface 'wmesh'
>          option device 'radio0'
>          option ifname 'mesh0'
>          option mode 'mesh'
>          option mesh_id 'test'
>          option mesh_fwding '0'
>          option mesh_ttl '1'
>          option mcast_rate '18000'
>          option encryption 'psk2+ccmp'
>          option key 'thisisaverysecretkey'
>
> But as said earlier, the gateworks OpenWrt 18.x is in rather bad shape. So
> expect that there are a lot of important fixes [3,4,5,6,7,8,9,10,11,12,13,..]
> missing.
>
> Kind regards,
>         Sven
>
>
> [1] https://openwrt.org/docs/guide-user/network/wifi/mesh/batman
> [2] https://openwrt.org/docs/guide-user/network/wifi/mesh/80211s
> [3] https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=166741240afd396c41b284edaa5180b162232741
> [4] https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=8f24653184536e1f8259bb43cffdae5673fb593a
> [5] https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=eba3b028e46dbfe54f1208e9edf47bb0c6f73ac8
> [6] https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=ff8df2b3f9c161edc3ab543bdbeb04a9fb45c959
> [7] https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=a4322eba2b129adde45e3f7ac6c3805889623dd5
> [8] https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=3a456683e5da7ed3a26ffb71e1dbbf1d1db0d036
> [9] https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=6e0fa4a76db667d7f0c1d84a3af5017df26d3fad
> [10] https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=574e4377fad5137595dea8a281061a3c945187c2
> [11] https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=547042398afac3ce702adab28c753e7c9ebed452
> [12] https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=ba5ec6b77c94a21bbd78b66c63317a4ff9b62962
> [13] https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=96f4792fdb036ecf5c8417fce6503412b0b27e5f
