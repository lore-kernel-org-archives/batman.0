Return-Path: <hexiled@nixbits.net>
Message-ID: <4F72E60C.2010300@nixbits.net>
Date: Wed, 28 Mar 2012 06:21:00 -0400
From: HeXiLeD <hexiled@nixbits.net>
MIME-Version: 1.0
References: <201203261241.32890.lindner_marek@yahoo.de>
	<4F70E2EF.4060009@nixbits.net>
	<201203271258.57514.lindner_marek@yahoo.de>
In-Reply-To: <201203271258.57514.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv load module patch
Reply-To: HeXileD@nixbits.net,
	The list for a Better Approach To Mobile Ad-hoc Networking
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
To: 

You are correct. I was patching while inside of the same directory as
the file to patch.

I was able to patch now, from ../files directory.
------------------------------------------------------------------------
OPENWRT/backfire/feeds/packages/net $ patch -p1<
batman-adv_load-module-when-needed.patch

patching file batman-adv/files/lib/batman-adv/config.sh

Hunk #2 succeeded at 36 with fuzz 1 (offset -3 lines).

Hunk #3 succeeded at 54 (offset -3 lines).

patching file batman-adv/files/usr/sbin/batman-adv

Hunk #1 succeeded at 25 (offset -1 lines).

patching file batman-adv/files/etc/hotplug.d/net/99-batman-adv

------------------------------------------------------------------------
After the patch i compiled and used the builds.
I tried one build from source and another made with the image builder

At boot; batman-adv still does not load both interfaces, only 1. (wlan0)
In other to load both: batman-adv restart must be executed.

config 'mesh' 'bat0'
        option 'ap_isolation' '0'
        option 'bonding' '0'
        option 'aggregation' '1'
        option 'fragmentation' '1'
        option 'gw_bandwidth' '3mbit/384kbit'
        option 'gw_mode' 'client'
        option 'gw_sel_class' '5'
        option 'orig_interval' '1000'
        option 'vis_mode' 'client'
        option 'interfaces' 'wlan0 eth0.0

This concludes that the patch might not be working.
Correct me if i am wrong.

------------------------------------------------------------------------






On 03/27/2012 05:58 AM, Marek Lindner wrote:
> On Tuesday, March 27, 2012 00:43:11 HeXiLeD wrote:
>> I have been trying to apply the patch which tries to fix the openwrt
>> scripts in regards having batman-adv to bring up all it's attached 
>> interfaces but something seems not to be working.
> Seems to be same problem we already discussed in the IRC channel.
>
>
>> $ patch -p2 < batman-adv_load-module-when-needed.patch 99-batman-adv
> That is not the way to apply a patch. Omit the last argument.
>
>
>> $ patch -p1< batman-adv_load-module-when-needed.patch
>> can't find file to patch at input line 3
> Wrong path.
>
>
>> $ patch -p1< batman-adv_load-module-when-needed.patch 
>> can't find file to patch at input line 3
> Wrong path.
>
>
> You have to find the correct package path and don't supply too many arguments 
> to make it work.
>
> Regards,
> Marek
>
