Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 4 Nov 2013 11:28:20 +0100
References: <2578313.zUW7Pc5dQb@flohlap>
In-Reply-To: <2578313.zUW7Pc5dQb@flohlap>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201311041128.20618.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] Bad link quality if routers are connected by 2
	interfaces
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,
> Hi,
>=20
> in our Freifunk network we are experiencing some kind of strange behaviour
> if two routers can see each other by wire and wireless at the same time.
> Then the link quality in the originator table drops from normally >250 to
> somewhat around 130 or less on both interfaces.
>=20
> Because we have no idea why this happens but think this is kind of unwant=
ed
> behaviour I=B4m asking here if we did something wrong or if we missed some
> configuration in this case.

this is certainly not the expected behaviour. Are you building a bridge loo=
p=20
by any chance? Please explain your configuration (batctl if, brctl show, ..=
=2E)=20
and check if you have a high amount of broadcasts somehow.

Cheers,
    Simon
