MIME-Version: 1.0
In-Reply-To: <200905192121.08028.sven.eckelmann@gmx.de>
References: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
	<200905192121.08028.sven.eckelmann@gmx.de>
Date: Tue, 19 May 2009 15:38:31 -0500
Message-ID: <4313f3060905191338n3ac9a795nd605da75ec1523aa@mail.gmail.com>
From: Nathan Wharton <naw@greptar.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Kernel crashes with batgat installed
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@open-mesh.net

Thanks for your reply.  I will answer inline below:

On Tue, May 19, 2009 at 2:21 PM, Sven Eckelmann <sven.eckelmann@gmx.de> wro=
te:
> Hi,
> thanks for your report. I am currently running some stress tests on x86 a=
nd
> mips and couldn't reproduce any such problems. So I have some questions
> regarding your configuration.
>
> On Tuesday 19 May 2009 16:27:25 Nathan Wharton wrote:
>> I am using batman 1256 on a very recent openwrt (linux version
>> 2.6.28.10) as well as a bit older one (linux version 2.6.26.8).
> What is your target architecture in openwrt? =A0Have you tried to reprodu=
ce that
> problem on another architecture?

The target is a Gateworks Avila 2348-4 board, which has an IXP425.
I haven't tried another target yet.

>> With batgat installed, I have problems with the kernel crashing when
>> turning the gateway on and off. =A0I start batman with -r 2. =A0If I
>> detect an uplink, I issue -c -g 11000. =A0If I lose the link, I issue -c
>> -r 2. =A0It is this final -c -r 2 that causes the kernel to either crash
>> with a bad page on the next process that is created, have a null
>> pointer error, or have a recursion error.
> Can you create a readable kernel backtrace with ksymoops?

I can, but it is never in the batman process, which is why I didn't
think it was batman until I figured out how to reproduce it.  For
example:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
root@SchaferRobotics_1_3:/# batmand -c -g 11000
WARNING: You are using the unstable batman branch. If you are
interested in *using* batman get the lat
est stable release !
root@SchaferRobotics_1_3:/# batmand -c
WARNING: You are using the unstable batman branch. If you are
interested in *using* batman get the lat
est stable release !
batmand -g 12MBit/1536KBit -a 10.1.3.0/24 -a 10.255.1.3/32 -d 3
--hop-penalty 5 --purge-timeout 10000
ath0 eth0
root@SchaferRobotics_1_3:/# batmand -c -r 2
WARNING: You are using the unstable batman branch. If you are
interested in *using* batman get the lat
est stable release !
Bad page state in process 'volts_temp'
page:c0335440 flags:0x00000000 mapping:00000000 mapcount:0 count:-1
Trying to fix it up, but a reboot is needed
Backtrace:
[<c0028680>] (dump_stack+0x0/0x14) from [<c0064a08>] (bad_page+0x74/0xb4)
[<c0064994>] (bad_page+0x0/0xb4) from [<c0065a0c>]
(get_page_from_freelist+0x45c/0x4a0)
 r6:c02bd7e8 r5:c02be02c r4:c0335440
[<c00655b0>] (get_page_from_freelist+0x0/0x4a0) from [<c0065afc>]
(__alloc_pages_internal+0xac/0x3e0)
[<c0065a50>] (__alloc_pages_internal+0x0/0x3e0) from [<c0065e50>]
(__get_free_pages+0x20/0x54)
[<c0065e30>] (__get_free_pages+0x0/0x54) from [<c0033af4>]
(copy_process+0x90/0xd40)
[<c0033a64>] (copy_process+0x0/0xd40) from [<c0034924>] (do_fork+0x70/0x2a4=
)
[<c00348b4>] (do_fork+0x0/0x2a4) from [<c0027c00>] (sys_fork+0x30/0x38)
[<c0027bd0>] (sys_fork+0x0/0x38) from [<c0024de0>] (ret_fast_syscall+0x0/0x=
2c)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
volts_temp, in this case, happens to be the next process that tried to
run.  I get a similar trace even if it is another process.

>> If I run batman without batgat, I don't get any crashes.
>>
>> Everything works fine otherwise. =A0Except one thing that just came to
>> mind, I had to remove -DDEBUG_MALLOC -DMEMORY_USAGE because batman
>> wouldn't do anything without crashing because of magic number
>> problems. =A0Could this be because I am on Big Endian hardware?
> I am running it also on big endian hardware and it seems to work. Does it
> happen right after the start or were extra interaction needed? What was t=
he
> error output?

It happens right after the start, and the error is debugRealloc -
invalid magic number in trailer.

>> Could anyone else see if they have the same problem? =A0All you have to
>> do is have batman running with batgat installed, start issuing batmand
>> -c -g 11000 ; batmand -c -r 2 multiple times and see if their system
>> stays stable.
> I am running it in a while true loop since an hour on x86 and mips on iso=
lated
> and non isolated (single partner) nodes and didn't get such problems.

Here is a little more on our setup:

All boards run the same software.  Each board has 2 mesh interfaces.
One is a radio, one is wired.  So, batman runs on 2 interfaces on
every board.
Each board has a downstream wired interface with a dhcp server.
batman announces this network.
This downstream network is different for every board due to a
group/node numbering scheme.  The network is 10.group.node.0/24.
Group and Node are 1-250.  The wireless interface is 10.0.group.node,
and the wired interface is 10.255.group.node.

A board can have an optional second radio, and if it does, it is used
to try to find an open wireless access point.
A board can also have an optional cellular modem and will try to use
it if it does.

If a default route gets set by one of these options, batmand -c -g is
used.  If the default route goes away, -c -r is used.

The boards are then either used as a mesh network extender, to provide
access to the mesh to a computer, or attached to a mobile platform
which can be controlled from any computer with access to the mesh.

The --hop-penalty of 5 was tested to be the best value for a mobile
platform just on the edge of needing to hop.

The --purge-timeout of 10000 is so that any boards that have been
turned off don't hang around long.

The current setup I am testing is 3 boards.  1 in the middle has a
wireless connection to one and a wired connection to the other.
The node in the middle has the optional wireless uplink.
The node connected via wired has the optional cellular uplink.

I appreciate you trying it out.  I'll try looking a bit deeper.
