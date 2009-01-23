Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Jan 2009 17:39:31 +0800
Message-ID: <278AF6CA06F13D4C9E9F69C7B9AB3B8303504624@MBX21.stu.nus.edu.sg>
In-Reply-To: <200901211621.21753.sven.eckelmann@gmx.de>
References: <278AF6CA06F13D4C9E9F69C7B9AB3B8303504611@MBX21.stu.nus.edu.sg>
	<200901211436.08998.sven.eckelmann@gmx.de>
	<20090121143814.GA13404@pandem0nium>
	<200901211621.21753.sven.eckelmann@gmx.de>
From: "Kartik Muralidharan" <kartik_m@nus.edu.sg>
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
To: b.a.t.m.a.n@open-mesh.net

Thanks Sven/Simon.

I was able to compile and checking 'file batmand' gave me the output
mentioned below.

But running ./batmand ath0 gives me an error.=20

What configuration do I need to do on the wireless interface on the
device?

Thanks
Kartik

-----Original Message-----
From: Sven Eckelmann [mailto:sven.eckelmann@gmx.de]=20
Sent: Wednesday, January 21, 2009 11:21 PM
To: b.a.t.m.a.n@open-mesh.net
Cc: Simon Wunderlich; Kartik Muralidharan
Subject: Re: [B.A.T.M.A.N.] Install Batman

Hi
On Wednesday 21 January 2009 15:38:14 Simon Wunderlich wrote:
> another option is to compile/linu batmand with the -static flag on
your
> x86 (i386) desktop
Thx, forgot that one. You should be able to link it statically by using
the=20
current version from trunk and running
 LDFLAGS=3D"-s -static" /usr/bin/make

You can check it with `file batmand`. It should print something like
 batmand: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV),
statically=20
linked, for GNU/Linux 2.6.8, stripped
=20
best regards,
	Sven
