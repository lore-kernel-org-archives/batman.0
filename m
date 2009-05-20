MIME-Version: 1.0
In-Reply-To: <200905210010.54489.lindner_marek@yahoo.de>
References: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
	<200905200930.52901.lindner_marek@yahoo.de>
	<4313f3060905200734x3d6385f7jeac3eb3a8255355@mail.gmail.com>
	<200905210010.54489.lindner_marek@yahoo.de>
Date: Wed, 20 May 2009 12:01:43 -0500
Message-ID: <4313f3060905201001u5658c660p5a9be3d63dbff150@mail.gmail.com>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Wed, May 20, 2009 at 11:10 AM, Marek Lindner <lindner_marek@yahoo.de> wr=
ote:
> Ok, from your output plus the nvalid magic number we can say that it seem=
s
> somewhat related to your HNA settings. A few more questions:
> * In this case the batgat module is not involved and still it crashes ?!
> * Is your network up & running ? Does batman receive messages from neighb=
or
> nodes (you can track that via debug log 4) ?
> * Does batman also crash in a disconnected environment ?

In this case, it does the same thing whether or not batgat is installed.

Debug level 4 gives:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
WARNING: You are using the unstable batman branch. If you are
interested in *using* batman get the lat
est stable release !
Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 66 - unknown)
Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 66 - unknown)
Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 65 - unknown)
Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 65 - unknown)
Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 67 - unknown)
Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 67 - unknown)
Interface activated: ath0
Using interface ath0 with address 10.0.1.3 and broadcast address 10.0.255.2=
55
Interface activated: eth0
Using interface eth0 with address 10.255.1.3 and broadcast address
10.255.255.255
B.A.T.M.A.N. 0.3.2-beta rv1256 (compatibility version 5)
[        30] Adding throw route to 127.0.0.0/8 via 0.0.0.0 (table 68 - lo)
[        30] Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 68 - eth1=
)
[        30] Adding throw route to 10.0.0.0/16 via 0.0.0.0 (table 68 - ath0=
)
debug level: 4
routing class: 2
[        30] Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 65 - unkn=
own)
[        30] Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 66 - unkn=
own)
[        30] Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 67 - unkn=
own)
[        30] Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 68 - unkn=
own)
[        30] Error - can't add throw route to 10.1.3.0/24 via 0.0.0.0
(table 68): File exists
[        30] Error - can't add throw route to 10.1.3.0/24 via 0.0.0.0
(table 68): File exists
[        30] debugRealloc - invalid magic number in trailer: 78183456,
malloc tag =3D 15
[        30] debugRealloc - invalid magic number in trailer: 78183456,
malloc tag =3D 15
[        30] Deleting throw route to 127.0.0.0/8 via 0.0.0.0 (table 68 - lo=
)
[       100] Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 68 - et=
h1)
[       130] Deleting throw route to 10.0.0.0/16 via 0.0.0.0 (table 68 - at=
h0)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

It does this while not connected.

>> This is only happening when using the batgat module.
>> The kernel is crashing. =A0If it happens to not reboot, I see that
>> batman is in a device wait state and can't be killed.
>
> The log you just provided is not about a kernel crash - its "just" the ba=
tman
> daemon. Are we hunting 2 different bugs ?

If you consider 1 bug being the debug_malloc stuff not working, and
the other being batgat possibly crashing the kernel, then yes.
If I turn off debug malloc, then everything works fine, except using
batgat and going from gateway to routing class.
