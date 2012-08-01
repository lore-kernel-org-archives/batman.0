Return-Path: <emunicio@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKeC-QEe7DuHj9WV+23oiSpaYXurGJfaj9koz=B75fHq3Av_Cw@mail.gmail.com>
References: <CAMVTf1iTYLNL9xAuXsRwiAexNAfXmf5zPXocv=qrcWYSVBmYhA@mail.gmail.com>
 <9467854.H6YUclFirY@bentobox>
 <CAKeC-QEe7DuHj9WV+23oiSpaYXurGJfaj9koz=B75fHq3Av_Cw@mail.gmail.com>
From: Esteban Municio <emunicio@gmail.com>
Date: Wed, 1 Aug 2012 11:28:23 -0500
Message-ID: <CAMVTf1g-8YSEUCEiG4rWWe2sJJmaS1WtvtUAjkJVToVWj9oQ7w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] Problems to add Batman-adv in wlan0 Nanostation
	M5
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

Thanks you very much.

I got run batman-adv and and I can see 2 nodes between them:

root@OpenWrt:/# batctl o
[B.A.T.M.A.N. adv 2012.0.0, MainIF/MAC: wlan0/00:27:22:52:74:e2 (bat0)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:
Potential nexthops ...
00:27:22:52:71:a7    0.170s   (213) 00:27:22:52:71:a7 [     wlan0]:
00:27:22:52:71:a7 (213)

I transfer with scp and installed manually the packages
kmod-crc16_2.6.32.27-1_ar71xx.ipk and
kmod-batman-adv_2.6.32.27+2012.0.0-1_ar71xx.ipk that i had created
when compiled the image, and now all work OK

Thanks for your help! Now batman-adv seems really easy! ;-)


2012/8/1 Wayne Abroue <plettpc@gmail.com>:
> On Wed, Aug 1, 2012 at 12:19 PM, Sven Eckelmann <sven@narfation.org> wrote:
>> On Tuesday 31 July 2012 11:41:15 Esteban Municio wrote:
>>> Hi all
>>>
>>> I`m working on a academic develop project for improve the networks in
>>> rural areas in Peru. We are doing some test with 6 Nanostation M5 for
>>> create a mesh network.
>>>
>>> I tried Commotion software with OLSR and all was Ok. Now, we are
>>> testing BATMAN, with OpenWRT and batman-adv module, but I have some
>>> problems.
>>>
>>> I have compiled OpenWrt Backfire r32751 (Load: 0.09 0.10 0.05) and
>>> installed batman-adv with opkg following this
>>> http://wiki.openwrt.org/inbox/mesh.batman
>>
>> Why are you installing it with opkg? This sounds a little bit like you try to
>> load a kernel module that wasn't compiled for the kernel that is running on
>> the machine (which would be extreme bad when there are ABI differences). Also
>> this "pizza" link you showed at the bottom of the mail gives the impression
>> that you may have done something like that.
>>
>> The best way is to include it in your image.
>>
>>> When I put:
>>> lsmod | grep batman
>>> I get
>>> batman_adv             67936  0
>>>
>>> and seems to be load in the kernel
>>>
>>> But when I try to add the interface wlan0 for activate batman in it,
>>> the Nanostation remains locked and i need to reboot.
>>> I have tried this with:
>>>
>>> echo bat0 > /sys/class/net/wlan0/batman_adv/mesh_iface
>>>
>>> and
>>>
>>> batctl if add wlan0
>>>
>>> with the same bad result.
>>> What am i doing wrong?
>>
>> Hard to tell with the information we got here. Are you using the serial console
>> on your device? Does it print a backtrace (can you create a backtrace with
>> symbol tables enabled)? Are you sure that the kernel and batman-adv module are
>> 100% binary compatible? What version of batman-adv is it? Did you try the
>> newest openwrt devel package from
>>  http://downloads.open-mesh.org/svn/openwrt-feed/ (i think the package is
>> called kmod-batman-adv-devel)?
>>
>> batctl: acd06db051419d3b323675ab2d7c897f2a5efc2a
>> batman-adv: 3fdeaa6bfb404311b73a689e984672161403a0c2
>>
>> [...]
>>> I have noticed that i have not the bat0 interface created,is it normal?
>>> Do i need create another aditional interface like ath0?
>>
>> bat0 (or any other name you choose for your batman-adv device(s)) are created
>> after you attach an interface to it (this is what you are doing when you say
>> that your node "freezes").
>>
>>> I have been following that manuals:
>>> http://pizza.hskflashcards.com/index.php?page=B.A.T.M.A.N.+Advanced+on+OpenW
>>> rt+How-To
>>
>> Uh, please don't use this one. It is outdated as hell and has nearly nothing
>> to do with the stuff you are using (or at least should use).
>>
>>> Do you recomend me to change to batmand instead?
>>
>> Just to give an impression:
>>
>> Latest release of batmand:
>>  http://git.open-mesh.org/batmand.git/commit/3aeebaf87974a069278a3feee31345da664fc090
>>
>> Latest release of batman-adv
>>  http://git.open-mesh.org/batman-adv.git/commit/b82d11e243ec144c515e7d04e8e8c31b111a060d
>>
>> Commits in batmand in the last 6 months (master branch): 0
>> Commits in batman-adv in the last 6 months (master branch): ~250 (and this does
>> not include all the stuff that happens before a change is accepted)
>>
>> Of course, this can also be a sign of perfection. But I can say for sure that
>> the most development in the last two years happened in batman-adv and not in
>> batmand.
>>
>>> Do you know if there is any BATMAN implementation for a mesh network
>>> of Nanostation M5, easier to install and manipulate?
>>
>> Um, even easier? At least I find it extreme easy to get it running:
>>
>> $ modprobe batman-adv
>> $ batctl -m bat4 interface add eth0
>> $ ip addr add 192.168.3.11/24 dev bat4
>> $ ip link set dev bat4 up
>> $ batctl -m bat4 originators
>>
>> And only step 1 and 2 are batman-adv relevant. The rest is just to configure the
>> usual stuff and step 5 to check for detected originators. And "-m bat4" is
>> optional. I just wanted to call my device bat4. Please let me know how this can
>> be made easier without restricting users.
>>
>> And why are you refering to a specific product? I thought that you just use
>> OpenWRT.
>
> Yep, now that everybody has confused the hell out of you,,, try
> flashing the unit with
> http://downloads.openwrt.org/snapshots/trunk/atheros/openwrt-atheros-ubnt5-squashfs.bin
>
> setup to get internet access. and  correct wireless settings
> opkg update | opkg install kmod-batman-adv | enable with
> /etc/init.d/batman-adv enable
>
> edit /config/batman-adv to reflect wlan0
>
> reboot Done | check with batctl o
>
> Couldn't be simpler, no need to compile anything.
>
> Wayne A



-- 
Esteban
