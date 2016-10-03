Return-Path: <leftbydefault@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Oct 2016 22:38:38 +0530
From: leftbydefault@riseup.net
In-Reply-To: <CAGghcR5MNrmmeHWZBFFsHC88+Qj+-SW+kf548O23iOu963ZNTg@mail.gmail.com>
References: <CAGghcR5MNrmmeHWZBFFsHC88+Qj+-SW+kf548O23iOu963ZNTg@mail.gmail.com>
Message-ID: <15be6bcfa10965e93dcfa6b609ade0cf@riseup.net>
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

Hello Kaushik

On 2016-10-03 19:44, Kaushik N P wrote:
> Hello,
> 
> What I hope to find is:-
> 
> Another documentation maybe for setting up, or confirmation for
> setting up (because I can't tell sometimes if the instructions have
> been followed correctly).

I have no experience in simulating or emulating batman-adv, but I have 
experience
in compiling openwrt from source along with batman-adv and batctl. I can 
help you with that. batman-adv is built as a kernel module and so it is 
included by default in Linux kernels >= 2.x. You have mentioned that you 
are using Linux based operating system, I hope by now, you should be 
running Linux kernel 4.x. If you want to play around with batman-adv for 
sometime before emulating, you can use two three Linux based laptops 
with WiFi interface cards that support IBSS (adhoc mode).

You can check that using

     iw list | grep IBSS

if the command returned something like
Device supports RSN-IBSS.
		 * IBSS

then your Wireless NIC can be switched to ad-hoc mode. We have a bash 
shell script that does it automatically for you. You can find the script 
and terminal cast in the following links.

  1. https://github.com/PYMeshnet/scripts
  2. https://asciinema.org/a/38575

> Clarification for my doubt regarding the different types of OpenWRT
> images (like Kamikaze, Chaos Calmer, Attitude Adjustment,etc), what do
> they do and which one I should use for working with standard Batman
> adv setup.

Chaos Calmer (15.x) is the recent stable release of OpenWRT firmware. 
'Kamikaze, Altitude Adjustment, etc.,' are just different names given to 
different versions of OpenWRT releases. OpenWRT are meant to be the 
operating system for routers and modems. Depending on the configuration 
of devices, some versions may be supported and some may not be supported 
on certain routers and modems.

Since you are trying to create a virtual environment, I think should go 
with Chaos Calmer. (again I have no experience either with creating a 
virtual environment for OpenWRT nor for batman-adv).

> Confirmation method to see if qemu having OpenWRT is setup in my
> system - as now I have a setup in terminal which says
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
> [   15.802643] IPv6: ADDRCONF(NETDEV_CHANGE): br-lan: link becomes 
> ready
> [   17.762480] br-lan: port 1(eth0) entered forwarding state
> root@OpenWrt:/#
> 
> 
> I have more doubts, but hopefully, I will get some answers to them
> from the above questions itself.
> Hope to hear soon!!!
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

