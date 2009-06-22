Return-Path: <jacobmarble@gmail.com>
MIME-Version: 1.0
In-Reply-To: <200906222251.08240.sven.eckelmann@gmx.de>
References: <5161afcd0906191517l4083ef4dnb1642207d81816c1@mail.gmail.com>
	<200906222246.11849.sven.eckelmann@gmx.de>
	<5161afcd0906221348m7895318bwc87cf9d2369ca70@mail.gmail.com>
	<200906222251.08240.sven.eckelmann@gmx.de>
Date: Mon, 22 Jun 2009 15:37:30 -0600
Message-ID: <5161afcd0906221437y427f083cnafed5b7ec130955e@mail.gmail.com>
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

On Mon, Jun 22, 2009 at 2:51 PM, Sven Eckelmann<sven.eckelmann@gmx.de> wrot=
e:
> On Monday 22 June 2009 22:48:21 Jacob Marble wrote:
>> OK, what if I set the MTU of ath0 higher? =C2=A0Lemme see.
> You must also set the mtu of the bat0 higher (to 1500 to be more exact) w=
hen
> you set the ath0 mtu to 1524 - it will not be increased automatically.
>
Right, and OpenWrt's uci is being quite problematic about this.  I
setup the interfaces' MTU with uci and the MTU for bat0 only "sticks"
if I reboot the unit; "/etc/init.d/network restart" leaves bat0 at
1476.  *poor me*
