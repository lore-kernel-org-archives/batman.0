Return-Path: <plettpc@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4EDE971E.4010606@generalpacket.com>
References: <91576D2A759C423D9F749BF369100C1B@FlavioPC>
	<4EDE971E.4010606@generalpacket.com>
Date: Wed, 7 Dec 2011 07:06:46 +0200
Message-ID: <CAKeC-QEUju5ReYuzKOEzVByAttsy8kQRzZKM_tkN1mb0J3o5ig@mail.gmail.com>
From: Wayne Abroue <plettpc@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Rede Mesh Batman-ADV in brazil
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

On Wed, Dec 7, 2011 at 12:28 AM, Tom Cannon <tcannon@generalpacket.com> wro=
te:
> This is just a guess, but perhaps the bridge is not set to 'auto' and wil=
l
> not come up without the lan interface up.
>
> /etc/config/network
>
> config 'interface' 'bridge'
> =A0 option 'ifname' 'eth wlan bat' =A0# replace with your interface names
> =A0 option 'type' 'bridge'
> =A0 option 'auto' '1'
>
> The option 'auto' ensures the bridge comes up with or without the lan por=
t
> active.
> This stumped me once.......
>
>
> On 12/6/2011 1:00 PM, Flavio Leonel "suporte tecnico" wrote:
>>
>>
>>
>> --------------------------------------------------
>> From: "Flavio Leonel "suporte tecnico"" <suporte@tec-wi.com.br>
>> Sent: Tuesday, December 06, 2011 6:49 AM
>> To: "Sven Eckelmann" <sven@narfation.org>
>> Subject: Re: [B.A.T.M.A.N.] Fw: Rede Mesh BatmanADV no brazil
>>
>>> well what is happening here is the following problem.
>>>
>>> jah have some nodes with OpenWRT and Ubiquiti with batman-adv instaldos
>>> as I
>>> said in another e-mail and could see the pictures.
>>>
>>> settings:
>>> radio interfaces:
>>> Physical: 2 a LAN and a WLAN.
>>> built-in OpenWRT:
>>> mode =3D wlan mesh
>>> =3D wifi wlan
>>> connected to the router lan =3D
>>>
>>> All part of a bridge
>>> br-lan
>>> where this batman-adv active
>>>
>>> what happens? ..
>>> when I disconnect any machine "computer" or router
>>> connected to the LAN port of the device or restart.
>>>
>>> the radio will not let me drop, access ... I no more communication.
>>> I have to restart with the same device (computer or router) connected t=
o
>>> reestablish connection.
>>>
>>> already tested it with bridge mode with no firewall
>>> and now I'm experimenting with a way forward iptable
>>>
>>> but without any success not find anything about the forum and do not
>>> understand where this error.
>>>
>>> I hope you can help me, I tried to write my best English
>>> grateful ...
>>>

Secondly WLAN does not need to be part of the BR as BAT which is
essentially wlan's VI if set to wlan,

 option 'ifname' 'ethA ethB batX' =A0# replace with your interface names

Wayne A
