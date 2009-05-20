MIME-Version: 1.0
In-Reply-To: <200905200930.52901.lindner_marek@yahoo.de>
References: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
	<200905192121.08028.sven.eckelmann@gmx.de>
	<4313f3060905191338n3ac9a795nd605da75ec1523aa@mail.gmail.com>
	<200905200930.52901.lindner_marek@yahoo.de>
Date: Wed, 20 May 2009 09:34:29 -0500
Message-ID: <4313f3060905200734x3d6385f7jeac3eb3a8255355@mail.gmail.com>
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

On Tue, May 19, 2009 at 8:30 PM, Marek Lindner <lindner_marek@yahoo.de> wro=
te:
> On Wednesday 20 May 2009 04:38:31 Nathan Wharton wrote:
>> >> Everything works fine otherwise. =A0Except one thing that just came t=
o
>> >> mind, I had to remove -DDEBUG_MALLOC -DMEMORY_USAGE because batman
>> >> wouldn't do anything without crashing because of magic number
>> >> problems. =A0Could this be because I am on Big Endian hardware?
>> >
>> > I am running it also on big endian hardware and it seems to work. Does=
 it
>> > happen right after the start or were extra interaction needed? What wa=
s
>> > the error output?
>>
>> It happens right after the start, and the error is debugRealloc -
>> invalid magic number in trailer.
>
> The DEBUG_MALLOC option enables additional functions within batman that a=
llow
> it to easily trace back malloc bugs. A simple core dump might help but
> sometimes it is hard to say where it is coming from. Could you post the e=
xact
> "invalid trailer number" line ?

Here is the output when I have DEBUG_MALLOC on from start to finish:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
root@SchaferRobotics_1_3:/# batmand -d 3 -r 2 -a 10.1.3.0/24 --disable-clie=
nt-na
t --hop-penalty 5 --purge-timeout 10000 ath0 eth0
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
Adding throw route to 127.0.0.0/8 via 0.0.0.0 (table 68 - lo)
Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 68 - eth1)
Adding throw route to 10.0.0.0/16 via 0.0.0.0 (table 68 - ath0)
debug level: 3
routing class: 2
Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 65 - unknown)
Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 66 - unknown)
Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 67 - unknown)
Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 68 - unknown)
Error - can't add throw route to 10.1.3.0/24 via 0.0.0.0 (table 68): File e=
xists
debugRealloc - invalid magic number in trailer: 78183456, malloc tag =3D 15
Deleting throw route to 127.0.0.0/8 via 0.0.0.0 (table 68 - lo)
Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 68 - eth1)
Deleting throw route to 10.0.0.0/16 via 0.0.0.0 (table 68 - ath0)
Interface deactivated: ath0
Interface deactivated: eth0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

> I'm a bit confused here:
> * Is batman crashing ?
> * Is the kernel crashing ?
> * Is batman crashing if you use the batgat module ?

This is only happening when using the batgat module.
The kernel is crashing.  If it happens to not reboot, I see that
batman is in a device wait state and can't be killed.

I see that some more patches were added recently.  I will try them and
see if anything changes.
