Return-Path: <kaushik.np.in@ieee.org>
MIME-Version: 1.0
In-Reply-To: <CAGghcR7QjF+yugxao-P5YsB_TkC_0D_YU2tc0+dinN9AJhZX9w@mail.gmail.com>
References: <CAGghcR5MNrmmeHWZBFFsHC88+Qj+-SW+kf548O23iOu963ZNTg@mail.gmail.com>
 <15be6bcfa10965e93dcfa6b609ade0cf@riseup.net>
 <CAGghcR59sCzYh5O3uhTkRrp__X6SNZMN5X-SKMQScrVWEZoUgQ@mail.gmail.com>
 <57F66926.2070404@rund.freifunk.net>
 <CAGghcR7QjF+yugxao-P5YsB_TkC_0D_YU2tc0+dinN9AJhZX9w@mail.gmail.com>
From: Kaushik N P <kaushik.np.in@ieee.org>
Date: Sat, 8 Oct 2016 01:23:40 +0530
Message-ID: <CAGghcR53ja+D8kz+mAcLgL_rt69=4RdQ3wic1pVMWiod2yS5wQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Help in setting up mesh test bed using qemu -
 BATMAN adv
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

Hello,

Good to hear it is tough to work on in Linux and that am not the only
person finding it difficult working on it.

@Ufo : Yes, it might be tough, but we learn from experience on working
on such stuff after all. I have two routers but want to setup a bigger
mesh bed with more nodes and would prefer not to spend more for now.
And mainly I think working on Linux would provide me a better
understanding and would allow me to experiment more on it. I have
worked with Virtual machines before, though with minimal
experimentation at that. And I will definitely check out LEDE. Thank
you for the suggestion.

@Marek : Yes, I know it was a half baked question I presented, but
wasn't sure how to put up my query more clearly. Now I will list out
the steps I have followed till now and what the results are.

Links I followed primarily:
[1] https://wiki.openwrt.org/doc/howto/qemu
[2] https://www.open-mesh.org/projects/open-mesh/wiki/Emulation

So, the link [1] defines setting up QEMU. Again, I am working on
Ubuntu 16.0, 64-bit.

As far as I could see, only the Commands in  'Booting from SD card
image' was related. Have downloaded openwrt-realview-vmlinux.elf ,
openwrt-realview-sdcard.img and type in the command below :

qemu-system-arm -M realview-pbx-a9 -m 1024M -nographic \
    -kernel openwrt-realview-vmlinux.elf \
    -sd openwrt-realview-sdcard.img \
    -append "console=ttyAMA0 verbose debug root=/dev/mmcblk0p1"


This command opened up a BusyBox which looks as follows :

BusyBox v1.24.2 () built-in shell (ash)

//Says OpenWrt below
  _______                     ________        __
 |            | .-----.-----.-----.|  |  |  |.----.|  |_
 |     -      | |  _  |  -__|    ||  |  |  ||   _||   _|
 |_______| |  __|____|__|__||________||__|  |____|
                |__| W I R E L E S S   F R E E D O M
 -----------------------------------------------------
 DESIGNATED DRIVER (Bleeding Edge, 49928)
 -----------------------------------------------------
  * 2 oz. Orange Juice         Combine all juices in a
  * 2 oz. Pineapple Juice      tall glass filled with
  * 2 oz. Grapefruit Juice     ice, stir well.
  * 2 oz. Cranberry Juice
 -----------------------------------------------------
root@OpenWrt:/# [   13.897119] smsc911x smsc911x.0 eth0: SMSC911x/921x
identified at 0xf0b40000, IRQ: 60
[   13.934741] device eth0 entered promiscuous mode
[   13.978166] IPv6: ADDRCONF(NETDEV_UP): br-lan: link is not ready
[   15.762764] br-lan: port 1(eth0) entered forwarding state
[   15.764526] br-lan: port 1(eth0) entered forwarding state
[   15.802643] IPv6: ADDRCONF(NETDEV_CHANGE): br-lan: link becomes ready
[   17.762480] br-lan: port 1(eth0) entered forwarding state
root@OpenWrt:/#

There is no details on what to do once this opens up though. And I
still need confirmation as to what this means. Is it that QEMU has
loaded OpenWRT in my system like a virtual machine or is it a console
to access OpenWRT functionalities, etc.

After this I made changes according to "openwrt virtualized using
debian, qemu/kvm and a lex twitter system with intel atom d525 and
chipset ich8m" section to 'Virtualization proper' too in case it was
required, but the Virtualization didn't work.


This done, I moved to link [2], where it explains how to set up mesh
testbed. It says"OpenWrt, kamikaze trunk version for x86 with minimal
modifications" and so I have downloaded 'openwrt-x86-ext2.image' from
Kamikaze. Changed the above code used to load QEMU as :
qemu-system-arm -M realview-pbx-a9 -m 1024M -nographic \
>     -kernel openwrt-realview-vmlinux.elf \
>     -sd openwrt- \
>     -sd openwrt-x86-ext2.image \
>     -append "console=ttyAMA0 verbose debug root=/dev/mmcblk0p1"

But loading this hasn't been successful as doing this gives :
...<loading and stuff>...
[    1.304028] VFS: Mounted root (ext2 filesystem) readonly on device 179:1.
[    1.317832] Freeing unused kernel memory: 196K (c0481000 - c04b2000)
[    1.328078] Kernel panic - not syncing: No working init found.  Try
passing init= option to kernel. See Linux Documentation/init.txt for
guidance.
[    1.332338] ---[ end Kernel panic - not syncing: No working init
found.  Try passing init= option to kernel. See Linux
Documentation/init.txt for guidance.


Next, running the script written in 'OpenWrt' section doesn't work as it says :
/tmp/logserver.sh: 3: /tmp/logserver.sh: cannot open
/sys/kernel/debug/batman_adv/bat0/log: No such file
/tmp/logserver.sh: 3: /tmp/logserver.sh: cannot open
/sys/kernel/debug/batman_adv/bat0/log: No such file

Commenting the lines that open this file :
while [ 1 ]; do
    nc -l -p 2050 < /sys/kernel/debug/batman_adv/bat0/log
done

gives the error :
RTNETLINK answers: File exists
Cannot find device "br-lan"
Cannot find device "br-lan"
./rc.local: 23: ./rc.local: cannot create
/proc/net/batman-adv/interfaces: Directory nonexistent
./rc.local: 24: ./rc.local: cannot create
/proc/net/batman-adv/interfaces: Directory nonexistent
./rc.local: 25: ./rc.local: cannot create
/proc/net/batman-adv/log_level: Directory nonexistent
/tmp/logserver.sh: 1: /tmp/logserver.sh: !/bin/sh: not found
Cannot find device "bat0"
Cannot find device "bat0"

Next, I have patched both 'vde2-2.3.2_colour.patch' and
'vde2-2.3.2-wirefilter-ethertype.patch'

The final step lists a script for running the scripts to start up all
the qemu windows. This throw up a lot many errors.
Below is the error it shows:

kaushik@kaushik-HP:~/QEMUopenwrt$ ./command.sh
Must be run inside a screen session
[sudo] password for kaushik:
wirefilter(8722): Operation not permitted
wirefilter(8724): Operation not permitted
wirefilter(8726): Operation not permitted
wirefilter(8728): Operation not permitted
wirefilter(8730): Operation not permitted
wirefilter(8732): Operation not permitted
wirefilter(8734): Operation not permitted
wirefilter(8736): Operation not permitted
wirefilter(8738): Operation not permitted
wirefilter(8740): Operation not permitted
wirefilter(8742): Operation not permitted
wirefilter(8744): Operation not permitted
wirefilter(8746): Operation not permitted
wirefilter(8748): Operation not permitted
wirefilter(8750): Operation not permitted
vde_switch(8567): Operation not permitted
vde_switch(8575): Operation not permitted
vde_switch(8583): Operation not permitted
vde_switch(8591): Operation not permitted
vde_switch(8599): Operation not permitted
vde_switch(8607): Operation not permitted
vde_switch(8615): Operation not permitted
vde_switch(8623): Operation not permitted
vde_switch(8631): Operation not permitted
ioctl(TUNSETIFF): Device or resource busy
RTNETLINK answers: File exists
ioctl(TUNSETIFF): Device or resource busy
RTNETLINK answers: File exists
ioctl(TUNSETIFF): Device or resource busy
RTNETLINK answers: File exists
ioctl(TUNSETIFF): Device or resource busy
RTNETLINK answers: File exists
ioctl(TUNSETIFF): Device or resource busy
RTNETLINK answers: File exists
ioctl(TUNSETIFF): Device or resource busy
.
.
.

This I run in a screen as it is mentioned in the guide. It creates
many files and folders named num0 to num9, but doesn't proceed after
that.


This and some more experimentation I have done with it. So, any help I
can get would be most welcome

Thanks and Regards,

Kaushik NP
LI | Tw | FB
SAP Ambassador,
General Secretary, Computer Society
Team IEEE UVCE,
3rd Year Undergraduate Student,
University Visvesvaraya College of Engineering,
Bangalore, IN


On Sat, Oct 8, 2016 at 1:21 AM, Kaushik N P <kaushik.np.in@ieee.org> wrote:
> Hello,
>
> Good to hear it is tough to work on in Linux and that am not the only person
> finding it difficult working on it.
>
> @Ufo : Yes, it might be tough, but we learn from experience on working on
> such stuff after all. I have two routers but want to setup a bigger mesh bed
> with more nodes and would prefer not to spend more for now. And mainly I
> think working on Linux would provide me a better understanding and would
> allow me to experiment more on it. I have worked with Virtual machines
> before, though with minimal experimentation at that. And I will definitely
> check out LEDE. Thank you for the suggestion.
>
> @Marek : Yes, I know it was a half baked question I presented, but wasn't
> sure how to put up my query more clearly. Now I will list out the steps I
> have followed till now and what the results are.
>
> Links I followed primarily:
> [1] https://wiki.openwrt.org/doc/howto/qemu
> [2] https://www.open-mesh.org/projects/open-mesh/wiki/Emulation
>
> So, the link [1] defines setting up QEMU. Again, I am working on Ubuntu
> 16.0, 64-bit.
>
> As far as I could see, only the Commands in  'Booting from SD card image'
> was related. Have downloaded openwrt-realview-vmlinux.elf ,
> openwrt-realview-sdcard.img and type in the command below :
>
> qemu-system-arm -M realview-pbx-a9 -m 1024M -nographic \
>     -kernel openwrt-realview-vmlinux.elf \
>     -sd openwrt-realview-sdcard.img \
>     -append "console=ttyAMA0 verbose debug root=/dev/mmcblk0p1"
>
>
> This command opened up a BusyBox which looks as follows :
>
> BusyBox v1.24.2 () built-in shell (ash)
>
> //Says OpenWrt below
>   _______                     ________        __
>  |            | .-----.-----.-----.|  |  |  |.----.|  |_
>  |     -      | |  _  |  -__|    ||  |  |  ||   _||   _|
>  |_______| |  __|____|__|__||________||__|  |____|
>                 |__| W I R E L E S S   F R E E D O M
>  -----------------------------------------------------
>  DESIGNATED DRIVER (Bleeding Edge, 49928)
>  -----------------------------------------------------
>   * 2 oz. Orange Juice         Combine all juices in a
>   * 2 oz. Pineapple Juice      tall glass filled with
>   * 2 oz. Grapefruit Juice     ice, stir well.
>   * 2 oz. Cranberry Juice
>  -----------------------------------------------------
> root@OpenWrt:/# [   13.897119] smsc911x smsc911x.0 eth0: SMSC911x/921x
> identified at 0xf0b40000, IRQ: 60
> [   13.934741] device eth0 entered promiscuous mode
> [   13.978166] IPv6: ADDRCONF(NETDEV_UP): br-lan: link is not ready
> [   15.762764] br-lan: port 1(eth0) entered forwarding state
> [   15.764526] br-lan: port 1(eth0) entered forwarding state
> [   15.802643] IPv6: ADDRCONF(NETDEV_CHANGE): br-lan: link becomes ready
> [   17.762480] br-lan: port 1(eth0) entered forwarding state
> root@OpenWrt:/#
>
> There is no details on what to do once this opens up though. And I still
> need confirmation as to what this means. Is it that QEMU has loaded OpenWRT
> in my system like a virtual machine or is it a console to access OpenWRT
> functionalities, etc.
>
> After this I made changes according to "openwrt virtualized using debian,
> qemu/kvm and a lex twitter system with intel atom d525 and chipset ich8m"
> section to 'Virtualization proper' too in case it was required, but the
> Virtualization didn't work.
>
>
> This done, I moved to link [2], where it explains how to set up mesh
> testbed. It says"OpenWrt, kamikaze trunk version for x86 with minimal
> modifications" and so I have downloaded 'openwrt-x86-ext2.image' from
> Kamikaze. Changed the above code used to load QEMU as :
> qemu-system-arm -M realview-pbx-a9 -m 1024M -nographic \
>>     -kernel openwrt-realview-vmlinux.elf \
>>     -sd openwrt- \
>>     -sd openwrt-x86-ext2.image \
>>     -append "console=ttyAMA0 verbose debug root=/dev/mmcblk0p1"
>
> But loading this hasn't been successful as doing this gives :
> ...<loading and stuff>...
> [    1.304028] VFS: Mounted root (ext2 filesystem) readonly on device 179:1.
> [    1.317832] Freeing unused kernel memory: 196K (c0481000 - c04b2000)
> [    1.328078] Kernel panic - not syncing: No working init found.  Try
> passing init= option to kernel. See Linux Documentation/init.txt for
> guidance.
> [    1.332338] ---[ end Kernel panic - not syncing: No working init found.
> Try passing init= option to kernel. See Linux Documentation/init.txt for
> guidance.
>
>
> Next, running the script written in 'OpenWrt' section doesn't work as it
> says :
> /tmp/logserver.sh: 3: /tmp/logserver.sh: cannot open
> /sys/kernel/debug/batman_adv/bat0/log: No such file
> /tmp/logserver.sh: 3: /tmp/logserver.sh: cannot open
> /sys/kernel/debug/batman_adv/bat0/log: No such file
>
> Commenting the lines that open this file :
> while [ 1 ]; do
>     nc -l -p 2050 < /sys/kernel/debug/batman_adv/bat0/log
> done
>
> gives the error :
> RTNETLINK answers: File exists
> Cannot find device "br-lan"
> Cannot find device "br-lan"
> ./rc.local: 23: ./rc.local: cannot create /proc/net/batman-adv/interfaces:
> Directory nonexistent
> ./rc.local: 24: ./rc.local: cannot create /proc/net/batman-adv/interfaces:
> Directory nonexistent
> ./rc.local: 25: ./rc.local: cannot create /proc/net/batman-adv/log_level:
> Directory nonexistent
> /tmp/logserver.sh: 1: /tmp/logserver.sh: !/bin/sh: not found
> Cannot find device "bat0"
> Cannot find device "bat0"
>
> Next, I have patched both 'vde2-2.3.2_colour.patch' and
> 'vde2-2.3.2-wirefilter-ethertype.patch'
>
> The final step lists a script for running the scripts to start up all the
> qemu windows. This throw up a lot many errors.
> Below is the error it shows:
>
> kaushik@kaushik-HP:~/QEMUopenwrt$ ./command.sh
> Must be run inside a screen session
> [sudo] password for kaushik:
> wirefilter(8722): Operation not permitted
> wirefilter(8724): Operation not permitted
> wirefilter(8726): Operation not permitted
> wirefilter(8728): Operation not permitted
> wirefilter(8730): Operation not permitted
> wirefilter(8732): Operation not permitted
> wirefilter(8734): Operation not permitted
> wirefilter(8736): Operation not permitted
> wirefilter(8738): Operation not permitted
> wirefilter(8740): Operation not permitted
> wirefilter(8742): Operation not permitted
> wirefilter(8744): Operation not permitted
> wirefilter(8746): Operation not permitted
> wirefilter(8748): Operation not permitted
> wirefilter(8750): Operation not permitted
> vde_switch(8567): Operation not permitted
> vde_switch(8575): Operation not permitted
> vde_switch(8583): Operation not permitted
> vde_switch(8591): Operation not permitted
> vde_switch(8599): Operation not permitted
> vde_switch(8607): Operation not permitted
> vde_switch(8615): Operation not permitted
> vde_switch(8623): Operation not permitted
> vde_switch(8631): Operation not permitted
> ioctl(TUNSETIFF): Device or resource busy
> RTNETLINK answers: File exists
> ioctl(TUNSETIFF): Device or resource busy
> RTNETLINK answers: File exists
> ioctl(TUNSETIFF): Device or resource busy
> RTNETLINK answers: File exists
> ioctl(TUNSETIFF): Device or resource busy
> RTNETLINK answers: File exists
> ioctl(TUNSETIFF): Device or resource busy
> RTNETLINK answers: File exists
> ioctl(TUNSETIFF): Device or resource busy
> .
> .
> .
>
> This I run in a screen as it is mentioned in the guide. It creates many
> files and folders named num0 to num9, but doesn't proceed after that.
>
>
> This and some more experimentation I have done with it. So, any help I can
> get would be most welcome
>
>
> Thanks and Regards,
>
> Kaushik NP
> LI | Tw | FB
> SAP Ambassador,
> General Secretary, Computer Society
> Team IEEE UVCE,
> 3rd Year Undergraduate Student,
> University Visvesvaraya College of Engineering,
> Bangalore, IN
>
> On Thu, Oct 6, 2016 at 8:39 PM, Ufo <ufo@rund.freifunk.net> wrote:
>>
>> Testing batman-adv in virtual maschines on laptops is the most complex and
>> non-realistic way to start with mesh-networking. So its a nice, very
>> demanding student thing.
>>
>> its much more easier to buy some (more than 2!!) cheap wifi-routers! they
>> have proper wifi, more than one ethernet-interface (!) and there are many
>> openwrt/lede mesh firmwares with a well-configured batman-adv. after that,
>> the next step could be to try to couple your first laptop into that mesh.
>> starting with nothing but laptops seems to be too "versatile".
>>
>> if you are unfamiliar with qemu and virtualization your should first try
>> to install ubuntu or windows in a virtual machine. please use
>> "virt-manager", a graphical interface for that.
>>
>> unfortunatly the mentioned "stable" openwrt was forced to use a very old
>> batman-adv version from 2014. So you might use trunk firmware, and use LEDE
>> instead of Openwrt, to have a proper system.
>>
>>
>> http://ftp.halifax.rwth-aachen.de/lede/snapshots/targets/x86/generic/lede-x86-generic-combined-ext4.img.gz
>>
>>
>>
>>
>>
>>
>> On 04.10.2016 12:11, Kaushik N P wrote:
>>>
>>> Hello,
>>>
>>> Thank you 'rise.net' for the suggestion. It has given me some ideas,
>>> but what I hoped to do was to run the laptop with OpenWRT working with
>>> Batman adv like a router. This would enable me in creating a more
>>> extensive network without having to buy more routers itself and
>>> hopefully provide me with a more versatile network to work on. I will
>>> ofcourse be experimenting more along your steps, but I hope to get the
>>> QEMU set up and running on my system.
>>>
>>> If any one has more info on the QEMU setup, pls do contact.
>>>
>>>
>>> Thanks and Regards,
>>>
>>> Kaushik NP
>>> General Secretary, Computer Society
>>> Team IEEE UVCE,
>>> 3rd Year Undergraduate Student,
>>> University Visvesvaraya College of Engineering,
>>> Bangalore, IN
>>>
>>>
>>> On Mon, Oct 3, 2016 at 10:38 PM,  <leftbydefault@riseup.net> wrote:
>>>>
>>>> Hello Kaushik
>>>>
>>>> On 2016-10-03 19:44, Kaushik N P wrote:
>>>>>
>>>>> Hello,
>>>>>
>>>>> What I hope to find is:-
>>>>>
>>>>> Another documentation maybe for setting up, or confirmation for
>>>>> setting up (because I can't tell sometimes if the instructions have
>>>>> been followed correctly).
>>>>
>>>>
>>>> I have no experience in simulating or emulating batman-adv, but I have
>>>> experience
>>>> in compiling openwrt from source along with batman-adv and batctl. I can
>>>> help you with that. batman-adv is built as a kernel module and so it is
>>>> included by default in Linux kernels >= 2.x. You have mentioned that you
>>>> are
>>>> using Linux based operating system, I hope by now, you should be running
>>>> Linux kernel 4.x. If you want to play around with batman-adv for
>>>> sometime
>>>> before emulating, you can use two three Linux based laptops with WiFi
>>>> interface cards that support IBSS (adhoc mode).
>>>>
>>>> You can check that using
>>>>
>>>>      iw list | grep IBSS
>>>>
>>>> if the command returned something like
>>>> Device supports RSN-IBSS.
>>>>                   * IBSS
>>>>
>>>> then your Wireless NIC can be switched to ad-hoc mode. We have a bash
>>>> shell
>>>> script that does it automatically for you. You can find the script and
>>>> terminal cast in the following links.
>>>>
>>>>   1. https://github.com/PYMeshnet/scripts
>>>>   2. https://asciinema.org/a/38575
>>>>
>>>>> Clarification for my doubt regarding the different types of OpenWRT
>>>>> images (like Kamikaze, Chaos Calmer, Attitude Adjustment,etc), what do
>>>>> they do and which one I should use for working with standard Batman
>>>>> adv setup.
>>>>
>>>>
>>>> Chaos Calmer (15.x) is the recent stable release of OpenWRT firmware.
>>>> 'Kamikaze, Altitude Adjustment, etc.,' are just different names given to
>>>> different versions of OpenWRT releases. OpenWRT are meant to be the
>>>> operating system for routers and modems. Depending on the configuration
>>>> of
>>>> devices, some versions may be supported and some may not be supported on
>>>> certain routers and modems.
>>>>
>>>> Since you are trying to create a virtual environment, I think should go
>>>> with
>>>> Chaos Calmer. (again I have no experience either with creating a virtual
>>>> environment for OpenWRT nor for batman-adv).
>>>>
>>>>
>>>>> Confirmation method to see if qemu having OpenWRT is setup in my
>>>>> system - as now I have a setup in terminal which says
>>>>>
>>>>> BusyBox v1.24.2 () built-in shell (ash)
>>>>>
>>>>> //Says OpenWrt below
>>>>>    _______                     ________        __
>>>>>   |            | .-----.-----.-----.|  |  |  |.----.|  |_
>>>>>   |     -      | |  _  |  -__|    ||  |  |  ||   _||   _|
>>>>>   |_______| |  __|____|__|__||________||__|  |____|
>>>>>                  |__| W I R E L E S S   F R E E D O M
>>>>>   -----------------------------------------------------
>>>>>   DESIGNATED DRIVER (Bleeding Edge, 49928)
>>>>>   -----------------------------------------------------
>>>>>    * 2 oz. Orange Juice         Combine all juices in a
>>>>>    * 2 oz. Pineapple Juice      tall glass filled with
>>>>>    * 2 oz. Grapefruit Juice     ice, stir well.
>>>>>    * 2 oz. Cranberry Juice
>>>>>   -----------------------------------------------------
>>>>> root@OpenWrt:/# [   13.897119] smsc911x smsc911x.0 eth0: SMSC911x/921x
>>>>> identified at 0xf0b40000, IRQ: 60
>>>>> [   13.934741] device eth0 entered promiscuous mode
>>>>> [   13.978166] IPv6: ADDRCONF(NETDEV_UP): br-lan: link is not ready
>>>>> [   15.762764] br-lan: port 1(eth0) entered forwarding state
>>>>> [   15.764526] br-lan: port 1(eth0) entered forwarding state
>>>>> [   15.802643] IPv6: ADDRCONF(NETDEV_CHANGE): br-lan: link becomes
>>>>> ready
>>>>> [   17.762480] br-lan: port 1(eth0) entered forwarding state
>>>>> root@OpenWrt:/#
>>>>>
>>>>>
>>>>> I have more doubts, but hopefully, I will get some answers to them
>>>>> from the above questions itself.
>>>>> Hope to hear soon!!!
>>>>>
>>>>> Thanks and Regards,
>>>>>
>>>>> Kaushik NP
>>>>> LI | Tw | FB
>>>>> SAP Ambassador,
>>>>> General Secretary, Computer Society
>>>>> Team IEEE UVCE,
>>>>> 3rd Year Undergraduate Student,
>>>>> University Visvesvaraya College of Engineering,
>>>>> Bangalore, IN
>>>>
>>>>
>>
>
