From: "Ian Salmon" <iansalmon@gmail.com>
References: <278AF6CA06F13D4C9E9F69C7B9AB3B8303504611@MBX21.stu.nus.edu.sg>
	<200901211436.08998.sven.eckelmann@gmx.de>
Date: Wed, 21 Jan 2009 18:18:42 -0000
Message-ID: <8204F319F60F43E9A4FB5D86465300E9@Off1>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <200901211436.08998.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Install Batman
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
To: 'The list for a Better Approach To Mobile Ad-hoc Networking' <b.a.t.m.a.n@open-mesh.net>

Hi,

Is what Philip is compiling batman/robin on the x86 of any interest
currently currently known as "Robix" This is fully documented I believe
http://robin.forumup.it/viewforum.php?f=12&mforum=robin 

Regards,

Ian

-----Original Message-----
From: b.a.t.m.a.n-bounces@open-mesh.net
[mailto:b.a.t.m.a.n-bounces@open-mesh.net] On Behalf Of Sven Eckelmann
Sent: 21 January 2009 13:36
To: b.a.t.m.a.n@open-mesh.net
Subject: Re: [B.A.T.M.A.N.] Install Batman

Hi,
On Wednesday 21 January 2009 13:54:44 Kartik Muralidharan wrote:
> I have a couple of embedded
> devices (x86) running the latest version of OpenWRT. I would like to know
> if I could compile and run batman on these nodes and if so how.
There is a howto written by Wesley at
 http://downloads.open-mesh.net/batman/misc/batmand_howto.pdf

This should describe the process of building and the first steps quite good.

You can compile the batmand binary by using a gcc with i386 as target 
plattform. This should be the case for every standard gcc on non-amd64 i368 
distributions. Afterwards you can copy it to your embedded device and use
it.
I am not up to date with the current development in trunk of openwrt but I 
think they don't provide packages for gcc yet. So it will not be possible 
(unless you installed gcc by hand) to compile it on your device running 
openwrt.
This is the really quick and dirty method but you can also create ipkgs with

the standard openwrt build environment with the build scripts from 
https://svn.openwrt.org/openwrt/packages/net/batman/

I would recommend that you use a current snapshot of the batman sources from

trunk because they contain a bunch of fixes since the last release (0.3).
You 
can obtain them by running
 svn export http://downloads.open-mesh.net/svn/batman/trunk/batman/

Best regards,
	Sven

