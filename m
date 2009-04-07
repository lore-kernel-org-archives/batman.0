MIME-Version: 1.0
In-Reply-To: <238a15490904071523v2a1e193bwcf624fe33108efb4@mail.gmail.com>
References: <238a15490904071518w6f11536nb8ec30fb43fc870b@mail.gmail.com>
	<238a15490904071523v2a1e193bwcf624fe33108efb4@mail.gmail.com>
Date: Tue, 7 Apr 2009 17:25:08 -0500
Message-ID: <238a15490904071525u142520f1vdfa5e45b3fb867d8@mail.gmail.com>
From: Gargi Purohit <gaargie@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Trouble with SSH in L2 batman network
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

Sorry was not clear in the configuration

=3D =3D AP to AP wireless link
^ ^ AP to client wireless link
Server1 and RB1 on wired n/w

 =A0My configuration is like this:

 -Server 1 --|
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|-----(RB1) =3D =A0 =3D =A0 (RB2)
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0^ =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 ^
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0^ =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 ^
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0^ =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 ^
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0C1 =A0 =A0 =A0 =A0 =A0 =A0 =A0C=
2


> On Tue, Apr 7, 2009 at 5:18 PM, Gargi Purohit <gaargie@gmail.com> wrote:
>> Hi
>>
>> I have configured a Layer 2 mesh (Using batman kernel module) on
>> Routerboard 433. =A0These are boards equipped with 2 interfaces. =A0I ha=
ve
>> configured/created a virtual interface on every physical interface.
>> So for E.g. my routerboard 1 (RB1) has ath0 (Phy interface - Adhoc
>> mode), ath1 (Virtual interface - Master mode), ath2 (Phy interface -
>> Adhoc mode) and ath3 (Virtual interface in Master mode).
>>
>> My set up has 2 routerboards - one is wired and the other is wireless.
>> Thus RB1 has (ath0, ath1, ath2, ath3 and eth0)
>> RB2 has (ath0, ath1, ath2, ath3)
>>
>> The proc is as follows on both RB1 and RB2
>>
>> root@open-mesh:~# cat /proc/net/batman-adv/interfaces
>> ath0 ath2
>>
>> I have created a bridge between all interfaces.
>> The bridge config on RB1 is:
>>
>> root@open-mesh:~# brctl show
>> bridge name =A0 =A0 bridge id =A0 =A0 =A0 =A0 =A0 =A0 =A0 STP enabled =
=A0 =A0 interfaces
>> br0 =A0 =A0 =A0 =A0 =A0 =A0 8000.000c422fbfe4 =A0 =A0 =A0 no =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0eth0
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ath=
1
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ath=
3
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bat=
0
>>
>>
>> The bridge config on RB2 is:
>> root@open-mesh:~# brctl show
>> bridge name =A0 =A0 bridge id =A0 =A0 =A0 =A0 =A0 =A0 =A0 STP enabled =
=A0 =A0 interfaces
>> br0 =A0 =A0 =A0 =A0 =A0 =A0 8000.00ff8fffdcc7 =A0 =A0 =A0 no =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bat0
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ath=
1
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ath=
3
>>
>>
>> I can connect clients to each of these RB and they can get Internet acce=
ss.
>>
>> My configuration is like this:
>>
>> -------------------Server 1 -------------|
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 |-------------Wired AP
>> (RB1) =A0 =3D =A0 =3D =A0 =3D =A0 =3D =A0 =3D =A0 =3D =A0 =3D Wireless A=
P (RB2)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 |
>> ^ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 |
>> ^ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 |
>> ^ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 |
>> C1 (Client of RB1) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0C2 (Client of
>> RB2)
>>
>>
>> The APs RB1 and RB2 are connected to each other over 2 mesh wireless
>> links on different channels (ath0 and ath2)
>>
>> I am trying to ssh to Server 1 from all these nodes. =A0I can ssh to
>> Server 1 from anyone but RB2 (RB1, C1, C2 can ssh Server 1 but RB2
>> cannot).
>>
>> Likewise I can ssh all nodes from each other. =A0E.g from anywhere on
>> LAN I can ssh to each of these nodes. =A0But RB2 can be sshed only from
>> nodes directly connected (eg. RB1 and C2).
>>
>> Note however i can ping Server 1 from RB2.
>>
>> Am not sure where I am going wrong?
>>
>> Regards
>>
>> Gargi
>>
>
