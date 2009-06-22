Return-Path: <jacobmarble@gmail.com>
MIME-Version: 1.0
In-Reply-To: <200906222224.43917.sven.eckelmann@gmx.de>
References: <5161afcd0906191517l4083ef4dnb1642207d81816c1@mail.gmail.com>
	<200906200323.44115.sven.eckelmann@gmx.de>
	<5161afcd0906221257m589d5ac3leea3bcd22dd20182@mail.gmail.com>
	<200906222224.43917.sven.eckelmann@gmx.de>
Date: Mon, 22 Jun 2009 14:47:30 -0600
Message-ID: <5161afcd0906221347p4125aac4kb8efed0bc1cfd01@mail.gmail.com>
From: Jacob Marble <jacobmarble@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] HTTP transfers greater than 1000 bytes fail
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.net

On Mon, Jun 22, 2009 at 2:24 PM, Sven Eckelmann<sven.eckelmann@gmx.de> wrot=
e:
> On Monday 22 June 2009 21:57:07 Jacob Marble wrote:
> [...]
>> > You can also set the mtu on your wifi devices higher (and bat0 devices=
).
>> > So for example wifi device to 1524 and bat0 to 1500 (like the eth
>> > devices). Also check if you have bridge mtu patch from Simon[1] (inclu=
ded
>> > in linux 2.6.27) when you are bridging some of the devices. Also check
>> > that icmp "Destination Unreachable" - "Fragmentation required, and DF
>> > flag set" isn't filtered anywhere.
> [...]
>> The Linux workstations are attached via Ethernet, running Ubuntu.
>>
>> The MTU, by default, is 1500 on eth0, ath0, wifi0
>> The MTU, by default, is 1476 on bat0, br-lan
>>
>> Ping from Linux workstation to Linux workstation works as long as the
>> -s flag is 1448 or less. =C2=A01448 =3D 1476 - 28
>> The -M do doesn't seem to change anything.
>>
>> HTTP transfers still don't go through when they are larger than ~1400
>> bytes. =C2=A0I'll go play with the MTUs now.
> Ok, setting mtu of ath0's to 1524 and of bat0 to 1500 should help here. J=
ust
> for the sake of completeness: Is there bridging involved in the workstati=
ons
> or any icmp filtering on the workstations/nanostations?
>
> Regards,
> Sven
>

Yes.  However, I can't set the MTU any higher than 1476 on the bat0 interfa=
ce:

root@OpenWrt:~# ifconfig bat0 mtu 1500
ifconfig: SIOCSIFMTU: Invalid argument
root@OpenWrt:~# ifconfig bat0 mtu 1477
ifconfig: SIOCSIFMTU: Invalid argument
root@OpenWrt:~# ifconfig bat0 mtu 1476
root@OpenWrt:~#

The same thing goes for the br-lan interface, I assume because brctl
uses the lowest MTU of all bridged interfaces as its max MTU.
