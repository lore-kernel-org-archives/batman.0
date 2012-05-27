Return-Path: <spyrosgaster@gmail.com>
MIME-Version: 1.0
Sender: spyrosgaster@gmail.com
In-Reply-To: <20120527160437.GB15532@ritirata.org>
References: <CA+wR77oJFdK9RZN+zoJ0wL30bv-K=ifwU2tLbFUaNKNecx2YaA@mail.gmail.com>
	<20120527160437.GB15532@ritirata.org>
From: NorthPole <morfeas3000@gmail.com>
Date: Sun, 27 May 2012 22:58:39 +0300
Message-ID: <CA+wR77qVRpH0J8tVWmb8dTvgA1Ud7cENUBxz3YHJUZE02r=70Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Questions regarding the Emulation envirnment
	setup
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Thanks Antonio your answers have been very helpful :-)

 but there are more questions

I run the script from the emulation wiki  page  (the one which is
supposed to start up all the qemus)

but when i run the second script (the one which is supposed to get
batman logs) it prints only

(UNKNOWN) [192.168.5.2] 2050 (?) : No route to host
(UNKNOWN) [192.168.6.2] 2050 (?) : No route to host
(UNKNOWN) [192.168.3.2] 2050 (?) : No route to host
(UNKNOWN) [192.168.4.2] 2050 (?) : No route to host
(UNKNOWN) [192.168.2.2] 2050 (?) : No route to host
(UNKNOWN) [192.168.8.2] 2050 (?) : No route to host
(UNKNOWN) [192.168.10.2] 2050 (?) : No route to host
(UNKNOWN) [192.168.7.2] 2050 (?) : Connection timed out

also

sudo screen -ls gives the following

There is a screen on:
	15179.pts-7.debian	(05/27/2012 09:38:53 PM)	(Attached)
1 Socket in /var/run/screen/S-root.

as I understand this is only one screen as oposed to 9

finally wireshark (version: 1.2.11) does not show any traffic on any
of the tap interfaces

obviously the virtual machines cann't communicate with each other so
the problem is maybe at the vde part?


for the sake of not wasting your time with  guessing  bellow is what I did
(the working folder is ~/openwrt)

1)checked out the open-wrt sources from the svn repo (svn co
svn://svn.openwrt.org/openwrt/trunk/)
which created a folder named trunk

2)edited the feeds.conf.default file  adding the src-svn batman
http://downloads.open-mesh.org/svn/openwrt-feed/ line

3)ran the following
mkdir -p './files/etc/
nano rc.local and pasted the script for the automatic network device
setup on boot
scripts/feeds update
scripts/feeds install kmod-batman-adv-devel

4)ran make menuconfig and added batman to the build and selected x86
target image

5)issued a succesful make

6)downloaded vde2-2.3.1 from sourceforge

7)downloaded the patches from the wiki page and applied them

8)compiled vde2 (./configure, make and sudo make install)

9)copy-pasted the appropriate script to start all the qemu instances and ch=
anged

VDESWITCH=3D~/src/vde2-2.2.3/src/vde_switch/vde_switch
IMAGE=3D~/src/openwrt2/kamikaze/bin/openwrt-x86-jffs2-128k.image
to
VDESWITCH=3D$(which vde_switch)
IMAGE=3Dtrunk/bin/x86/openwrt-x86-generic-combined-jffs2-128k.img

10)created colourfull.rc and pasted the appropriate entries

and
11)copy pasted the script to display output to a file called output.sh


Cheers,
Spyros

On Sun, May 27, 2012 at 7:04 PM, Antonio Quartulli <ordex@autistici.org> wr=
ote:
> Hi Spyros,
>
> On Sun, May 27, 2012 at 05:00:42PM +0300, NorthPole wrote:
>> Hello everyone, i'm trying to setup an emulation environment and i
>> have some questions:
>>
>> * although i downloaded the vde2-2.3.1 source and the appropriate
>> patches (vde2-2.3.1_colour.patch and
>> vde2-2.3.1-wirefilter-ethertype.patch ) the wirefilter patch could not
>> be applied giving the following output
>>
>> =A0$patch <vde2-2.3.1-wirefilter-ethertype.patch
>> patching file wirefilter.c
>> Hunk #1 FAILED at 59.
>> Hunk #2 FAILED at 524.
>> Hunk #3 FAILED at 1391.
>> Hunk #4 FAILED at 1402.
>> Hunk #5 FAILED at 1421.
>> Hunk #6 FAILED at 1475.
>> 6 out of 6 hunks FAILED -- saving rejects to file wirefilter.c.rej
>>
>> any tips on how I can find why it failed and how to apply the patch?
>>
>
>
> Have you tried "patch -1 <patchfile.patch" ?
>
>>
>> *I ran the script without the wirefilter patch and I got a blank
>> terminal,is this expected?
>>
>
> what script? Wirefilter is a "daemon" that run and gives the link some
> properties. By the way using it in your testbed without the colour patch =
doesn't
> make much sense.
>
>> * how can I get the dmesg(and generally any command) output
>> from the qemu instances?
>>
>
> you could directly enter the VM console and use it like you were on that =
"PC".
> Actually each VM should run into a screen instance. So you can use screen=
 to
> decide which console to attach to. "screen -ls" should give you the list =
of
> instances and "screen -r <pid>" will attach your terminal to one of the
> instances (man screen for further details).
>
>>
>> *provided i have built open-wrt with batman and have put the
>> appropriate script in wrt's =A0./files/etc/rc.local batman should start
>> as a daemon right?
>
> Daemon? You know that batman-adv is not a daemon :) If everything is prop=
erly
> configured (i.e. openwrt configures bat0 the proper way) then yes, batman=
-adv
> will be properly running :)
>
i should have written "daemon" i meant it should start along with the
os since its a module

>> given that, I should be seeing batman packets in the capture, right?
>>
>
> I think so. Sniffing on tapwrt0 should enable you to see the batman traff=
ic!
>
>
>> *wireshark should recognize that a given packet is an ogm packet or
>> there is another way to filter only the relevant ones?
>>
>
> If you use >=3Dwireshark-1.7.0 then you will be able to correctly parse b=
atman-adv
> traffic (COMPAT_VERSION 14, which is the last). And then you can apply wh=
atever
> filter you like :)
>
>>
>> Thank you for your time
>
> Thank you for asking!
>
> Cheers,
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara
