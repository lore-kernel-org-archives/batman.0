Return-Path: <tonyputi@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFevQmP3bduvABV2EvDYXdWbbVsRjak=uqVfAfK3UVswWM5gSg@mail.gmail.com>
References: <CAFevQmM12dq09+FPtwedGAXnJxw8rsCwphLAa-qfmaQFifErNg@mail.gmail.com>
	<1402666.XijZNOoGgr@sven-laptop.home.narfation.org>
	<CAFevQmP3bduvABV2EvDYXdWbbVsRjak=uqVfAfK3UVswWM5gSg@mail.gmail.com>
From: Filippo Sallemi <tonyputi@gmail.com>
Date: Mon, 20 Feb 2012 11:36:24 +0100
Message-ID: <CAFevQmPFR2_uziBtir5L2zVGJsEr4OYPMGuHj_7-1X7z2woY2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Fwd: mesh: received packet with own address as
	source address
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

---------- Messaggio inoltrato ----------
Da: Filippo Sallemi <tonyputi@gmail.com>
Date: 20 febbraio 2012 10:50
Oggetto: Re: [B.A.T.M.A.N.] mesh: received packet with own address as
source address
A: Sven Eckelmann <sven@narfation.org>


Il 20 febbraio 2012 00:55, Sven Eckelmann <sven@narfation.org> ha scritto:
> On Monday 20 February 2012 00:45:01 Filippo Sallemi wrote:
>> Hi all,
>> after upgrade of batman package on my nodes I see a very decerase of
>> performance of my mesh network. When I connect to some node i see
>> every time this message:
>>
>> mesh: received packet with =C2=A0own address as source address
>
> What was the previous version and which version do you use now?
My previuous version was 2011.2.0 and now is 2012.0.0
=C2=A0Do you use
> bridge loop avoidance or bridge loop avoidance II?
no all nodes speak only via ath/wlan
What's your batman-adv
> configuration?
[for nodes in gw_mode server]
config 'mesh' 'mesh'
=C2=A0 =C2=A0 =C2=A0 =C2=A0option 'interfaces' 'msh0'
=C2=A0 =C2=A0 =C2=A0 =C2=A0option 'ap_isolation' '0'
=C2=A0 =C2=A0 =C2=A0 =C2=A0option 'gw_mode' 'server'
=C2=A0 =C2=A0 =C2=A0 =C2=A0option 'gw_bandwidth' '4096KBit/512KBit'
=C2=A0 =C2=A0 =C2=A0 =C2=A0option 'vis_mode' 'server'

[for nodes in gw_mode client]
config 'mesh' 'mesh'
=C2=A0 =C2=A0 =C2=A0 =C2=A0option 'interfaces' 'msh0'
=C2=A0 =C2=A0 =C2=A0 =C2=A0option 'ap_isolation' '0'
=C2=A0 =C2=A0 =C2=A0 =C2=A0option 'gw_mode' 'client'
=C2=A0 =C2=A0 =C2=A0 =C2=A0option 'vis_mode' 'off'

=C2=A0Did you only upgrade batman-adv or also other packages?
Only batman-adv was upgrade
>
> Kind regards,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Sven

Rgds

--
Filippo Sallemi


--=20
Filippo Sallemi
