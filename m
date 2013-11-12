Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 12 Nov 2013 20:57:16 +0100
References: <2578313.zUW7Pc5dQb@flohlap>
 <201311081051.26384.sw@simonwunderlich.de> <2195225.ZahV9KD01s@flohlap>
In-Reply-To: <2195225.ZahV9KD01s@flohlap>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201311122057.16685.sw@simonwunderlich.de>
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
To: Clemens John <clemens-john@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

> Am Freitag, 8. November 2013, 10:51:26 schrieben Sie:
> > However, a2:f3:c1:5b:54:a6 is used as Ethernet source address for sendi=
ng
> > in both eth0.3 and wlan0-1 dumps. Is it possible that there is a mac
> > address conflict?
>=20
> Hi Simon,
>=20
> this seems to be the right hint. I checked this and we really had a mac
> address conflict on the interfaces wlan0-1 and eth0.3 we used for meshing.
> This was due to a fix for some mac adress problem in our firmware that
> seems to be outdated now.
>=20
> On my router the problem is fixed. We will check our other hardware also
> but I think we have a good chance that solving the mac adress conflicts
> will also solve this link quality problem. If not, I=B4ll ask again.

Would be nice to hear if the problem was resolved, also we can reference to=
=20
that later when somebody asks again for "my TQ dropped to half, why?" :)

Thanks,
    Simon
