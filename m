Return-Path: <post@tiwoc.de>
Message-ID: <4DF9CAE3.8020709@tiwoc.de>
Date: Thu, 16 Jun 2011 11:20:35 +0200
From: Daniel Seither <post@tiwoc.de>
MIME-Version: 1.0
References: <BANLkTi=HCdWDjTQER8uOP48RW-XsZ6ehaQ@mail.gmail.com>
In-Reply-To: <BANLkTi=HCdWDjTQER8uOP48RW-XsZ6ehaQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] tangentially driver related question on
 broadcasts with batman-adv
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
To: David Beberman <dbeberman@gmail.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi!

Am 16.06.2011 00:04, schrieb David Beberman:
> The second way I'm using it is to take advantage of broadcasting
> as a simply floodfill algorithm.  All of my nodes transmit to all other n=
odes
> on a periodic basis.  This is an IPv6 local multicast.  I believe this
> translates to 802.11 MAC FF:FF:FF:FF:FF:FF broadcast address, and
> everything works.
>=20
> What I noticed with a network sniffer is that all of the broadcasts were =
sent
> with 1 Mbps data rate.

This is the behavior specified in IEEE 802.11 [1], =A79.6 (Multirate suppor=
t):
"All frames with multicast and broadcast in the Address 1 field that
have a UP of zero shall be transmitted at one of the rates included in
the BSSBasicRateSet parameter, regardless of their type or subtype."

The basic rate set seems to often consists only of small rates such as 1
or 2 MBit/s in 11g networks. However, I couldn't find out how to get the
basic rates supported by my wifi card or configured in the wireless
stack. Does anyone know how to do this?

- Daniel

[1] http://standards.ieee.org/getieee802/download/802.11-2007.pdf
