Return-Path: <ylonen@gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 21 Jan 2010 20:02:51 +0100
From: =?iso-8859-1?Q?=22Juha_Yl=F6nen=22?= <ylonen@gmx.net>
Message-ID: <20100121190251.179780@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
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
To: b.a.t.m.a.n@lists.open-mesh.org



-------- Original-Nachricht --------
> Datum: Thu, 21 Jan 2010 18:57:52 +0100
> Von: Sven Eckelmann <sven.eckelmann@gmx.de>
> Yes, but doesn't explain why there is no batman-adv packet from ARM
> reaching=20
> the laptop and the other way around. batman-adv is a layer bellow and has=
=20
> nearly nothing to do with the stuff which runs over it (the only thing
> which=20
> accesses the layer over it should be the gateway stuff).
>=20
> @Juha, I found time and looked a little bit at the stuff which came from
> the=20
> ARM in the last log. Wireshark means that it is a Raw ethernet packet. And
> thinks that the stuff attached is a IPX packet.... but reading the raw
> data=20
> reveals that it should be the batman-packet.... with extra data between
> the=20
> ethernet header and the actual batman-adv packet. So the problem looks to
> me a=20
> little bit like hardware of the arm does something very stupid to our
> packets.
>=20
> I've attach a small picture to explain what I mean. The green part it the=
=20
> normal receiver and sender stuff for ethernet. The orange part is not=20
> explainable for me... Have we forgot some alignment stuff? Is your card
> adding=20
> some extra data? I am not sure what that could mean right now.
> The red thing is the ethernet type for batman-adv, pink the type of
> batman-adv=20
> packet, yellow the protocol version and light blue the flags for that
> packet.=20
> I don't know more color - so just marked the rest of the packet blue. The=
=20
> amount of bytes are correct and it looks fine to me.
>=20
> As anyone a good idea? Maybe a small capture of a normal ping test and a =

> rawsend test between the both could help to understand the problem better.
> And=20
> can you maybe tell us what kind of hardware is used inside the arm for the
> eth1 device?

Hi,

This looks interesting, I've had problems with the wlan driver before but i=
t has been quite stable for a while. Wlan chip in use is CSR UniFi 1050, wi=
th driver compiled from CSR supplied sources.=20

I'll try your rawsend and ping capturing during the weekend. Sorry for the =
bother in advance if this turns out to be due the crappy wlan driver (as sa=
id, it has been giving problems earlier, though I haven't seen any packet m=
angling before).

-Juha

--=20
Haiti-Nothilfe! Helfen Sie per SMS: Sende UIHAITI an die Nummer 81190.
Von 5 Euro je SMS (zzgl. SMS-Geb=FChr) gehen 4,83 Euro an UNICEF.
