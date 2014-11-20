Return-Path: <martin@hundeboll.net>
Message-ID: <546DC214.6050908@hundeboll.net>
Date: Thu, 20 Nov 2014 11:27:32 +0100
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1416347918.9920.10.camel@gmail.com>
 <546DA710.2040802@hundeboll.net> <1416476912.2747.5.camel@gmail.com>
In-Reply-To: <1416476912.2747.5.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] kernel BUG at net/core/skbuff.c:100
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

Hi Philipp,

On 2014-11-20 10:48, Philipp Psurek wrote:
> Hi Martin,
>
> Thank you for your response. I'm glad to help making Batman-adv better.
>
> Batman-adv ran with network_coding enabled while kernel panic. This was
> a misconfiguration because our nodes doesn't have nc compiled in their
> Batman kernel module. The VM is in production. I deactivated nc after
> someone told me I do not need nc. But I think my community forgive me
> another gateway failure for research sake.

Yeah, most people compile out network coding. Has the bug disappeared 
after disabling NC ?

> Am Donnerstag, den 20.11.2014, 09:32 +0100 schrieb Martin Hundebøll:
>> Thanks for you report. The bug is probably triggered by some bogus data
>> in an incoming packet. I have created a small debug patch that will
>> detect if this is the case, and print some debug info if so.
>
> Thank you for your work. I didn't find your Patch on
> http://git.open-mesh.org/batman-adv.git

It was attached to my previous mail :)

> I can not analyse the packages because the gateway is part of an ISP
> infrastructure and there is data privacy. But if you're capable to fish
> only the bogus data package during kernel panic with your patch there
> shouldn't be any problems, I think.

My debug patch should only print the header of the packet causing the 
panic, so no problems with privacy here. (But you should probably check 
the output before mailing it to a public list...)

>> Is it possible for you to checkout the source, add the patch, and
>> compile the module?
>
> Yes, I can checkout, patch and compile. The kernel is compiled with
> CONFIG_DEBUG_INFO=y
> # CONFIG_DEBUG_INFO_REDUCED is not set
> # CONFIG_ENABLE_WARN_DEPRECATED is not set
>
> Batman-adv is compiled as module. Is there a reboot of the VM needed if
> I patch the source, compile, replace, depmod and reload the Batman
> module?

A simple rmmod/insmod should be enough. (Including the following 
configuration, which is reset with rmmod.)

> Please send me the patch and tell me the additional make parameters to
> compile the module with debug symbols. Is it something like
> make \
> CONFIG_BATMAN_ADV_DEBUG=y \
> CONFIG_BATMAN_ADV_BLA=y \
> CONFIG_BATMAN_ADV_DAT=y \
> CONFIG_BATMAN_ADV_NC=y
> ?
> If I patch the (batman) kernel sources directly then a simply make in
> kernel directory should be enough, I presume. I also presume vmimage
> will be updated. Or should I rebuild the kernel from scratch?

Running make (as you write it above) in the module directory should do 
the trick. (Given you have the needed kernel header files installed) 
E.g. something like this:

git clone --branch v2014.3.0 git://git.open-mesh.org/batman-adv.git
cd batman-adv
git apply frag_debug_size.patch
make \
  CONFIG_BATMAN_ADV_DEBUG=y \
  CONFIG_BATMAN_ADV_BLA=y \
  CONFIG_BATMAN_ADV_DAT=y \
  CONFIG_BATMAN_ADV_NC=y

sudo rmmod batman_adv
sudo insmod batman-adv.ko
sudo batctl if add fastd0

And then your usual IP configuration on bat0 etc.

> I hope, this bug doesn't occur through the gentoo patches. But some
> similar freezes happened on Arch Linux with 3.14.23_ARCH and 3.17.1-ARCH
> with nc enabled. Unfortunately I can not analyse this bug on the Arch
> VMs because I'm not in total control of their VM terminal.

I am running with NC on my machines in the lab and haven't seen this 
frag-issue before. I have seen a similar issue (wrong size value in the 
header) in another context though, but this wasn't due to either network 
coding or fragmentation.

Would you mind sending me your fastd config (without the key), so that I 
can try to reproduce this in my VMs?

Thanks,
Martin
