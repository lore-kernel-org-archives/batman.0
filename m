Return-Path: <jacobmarble@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5161afcd0906221348m7895318bwc87cf9d2369ca70@mail.gmail.com>
References: <5161afcd0906191517l4083ef4dnb1642207d81816c1@mail.gmail.com>
	<5161afcd0906221257m589d5ac3leea3bcd22dd20182@mail.gmail.com>
	<5635aa0d0906221331nad876c8x6fec3fde12332c41@mail.gmail.com>
	<200906222246.11849.sven.eckelmann@gmx.de>
	<5161afcd0906221348m7895318bwc87cf9d2369ca70@mail.gmail.com>
Date: Mon, 22 Jun 2009 14:52:54 -0600
Message-ID: <5161afcd0906221352w2c5be360k23355ff4d91d8e26@mail.gmail.com>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Mon, Jun 22, 2009 at 2:48 PM, Jacob Marble<jacobmarble@gmail.com> wrote:
> On Mon, Jun 22, 2009 at 2:46 PM, Sven Eckelmann<sven.eckelmann@gmx.de> wr=
ote:
>> On Monday 22 June 2009 22:31:57 Outback Dingo wrote:
>>> when you say dont go thru, what exactly are they not passing through, w=
hich
>>> interface or meaning thru the DSL / internet link, we need to try to
>>> detmine also the bottleneck of the issue, so what interface is data not
>>> passing through, and icmp tests wount decipher much in regards to MTU..=
..
>>> tcpdump however might tell us where the traffic is getting stopped at
>> I would guess that the data gets stopped at the bat0 interface. Lets say=
 that
>> the workstation sends a big sized ethernet frame (aka 1500 bytes) with i=
p
>> data. Then it comes to the workstation over the eth0 interface which acc=
epts
>> frames till the size of 1500 bytes (everything happy until now). The bri=
dge
>> now sends it to the bat0 interface.... and oh noes, this fails because t=
he
>> bat0 only accepts ethernet frames of the size of 1476 bytes (see the mtu=
 of
>> the ath0 - 24 bytes for bat-adv stuff). The bridge should now send infor=
mation
>> (icmp packet) back the path that it cannot send the ethernet frame throu=
gh
>> this chokepoint[1]. This doesn't seem to happen here or isn't recognized=
 by
>> the client.
>>
>> Regards,
>> Sven
>>
>> [1] ftp://ftp.rfc-editor.org/in-notes/rfc1191.txt
>>
>
> OK, what if I set the MTU of ath0 higher? =C2=A0Lemme see.
>

And now I see that that's what you were saying before.  And it works.
I'm downloading a 600 MB file via HTTP just fine now.
