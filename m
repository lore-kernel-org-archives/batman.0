Return-Path: <sailashm@gmail.com>
MIME-Version: 1.0
In-Reply-To: <2544329.jNlMzIK2XD@bentobox>
References: <CAM3k=84krmoLaW2X59VujDb_ZxuMJW-6pwGDhDLx=0-HHG6O=Q@mail.gmail.com>
 <2544329.jNlMzIK2XD@bentobox>
From: Sailash Moirangthem <sailashm@gmail.com>
Date: Thu, 23 Jun 2016 15:40:53 +0530
Message-ID: <CAM3k=87WXavPXTCZ9SaTbE62-qK=9SvHmtZQ5A-hSXEF=t3w2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Adhoc0 Interface not showing up
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

My wireless configuration is:

config wifi-iface wmesh
option device radio1
option ifname adhoc0
option network mesh
option mode adhoc
option ssid mesh
option bssid 02:ca:ca::ca:40
option encryption none

So, it is almost the same as mentioned in
[1]  https://www.open-mesh.org/projects/batman-adv/wiki/Batman-adv-openwrt-config

Yes, I tried batctl if add adhoc0, and when i put batctl if.. it days
adhoc inactive.
Nothing critical says in dmesg. One line is to increase the mtu from
1500 to 1532 for eth0.

Thanks for your help. Please check. I hope we can fix this.

Thanks,
Sailash M


On Thu, Jun 23, 2016 at 3:25 PM, Sven Eckelmann <sven@narfation.org> wrote:
> On Thursday 23 June 2016 14:54:37 Sailash Moirangthem wrote:
> [..]
>> I am trying to set-up mesh network using tplink WR1043ND routers and
>> raspberry pi B+ integrated with ra2800usb (wi pi). The tplink routers
>> are working as expected. Howoever, the raspberry pi is not working.
>
> Sounds more like an OpenWrt/LEDE question. But I think the persons which
> created the OpenWrt/LEDE scripts for batman-adv are subscribed to this
> list.
>
>> The configuration file for the Pi board is as follows:
>>
> [...]
>>  config interface 'mesh'
>> option ifname 'adhoc0'
>> option mtu '1528'
>>  option proto 'batadv'
>>  option mesh 'bat0'
> [...]
>
> Why are you adding the interface in /etc/config/wireless and not as
> described in the quick start guide [1] to /etc/config/wireless? I would
> suggest to try to use the /etc/config/wireless because these are
> "dynamically" created interfaces and (not tested) should work better with
> netifd.
>
> Is it working when you do `batctl if add adhoc0`? Is something shown
> in dmesg related to an error while adding the interface?
>
> Kind regards,
>         Sven
>
> [1] https://www.open-mesh.org/projects/batman-adv/wiki/Batman-adv-openwrt-config
