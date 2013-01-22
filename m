Return-Path: <aaron@lo-res.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
From: "L. Aaron Kaplan" <aaron@lo-res.org>
In-Reply-To: <CAD_CWO1hPN=7RVQA+W25oM5nCxxYxV1yefXAYboTvK5_H+hxJg@mail.gmail.com>
Date: Tue, 22 Jan 2013 16:37:00 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <CAC0629B-4343-48A8-9321-87A5B2A5B832@lo-res.org>
References: <CAD_CWO3cQMtPns+xzc2hs4sUCmZM1ux4-335rhicUn05Upvu-g@mail.gmail.com>
 <CAD_CWO1hPN=7RVQA+W25oM5nCxxYxV1yefXAYboTvK5_H+hxJg@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Advice for dense meshes
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
To: steve@villagetelco.org, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


On Jan 22, 2013, at 1:54 PM, Steve Song <steve@villagetelco.org> wrote:

> Hi all,
>=20
> A colleague of mine is building a batman-adv mesh network in an
> apartment building with essentially one node per apartment.   Not
> surprisingly, results in a very dense mesh with each node having a
> large number of neighbours.  Here is a typical batctl o output
> http://pastebin.com/aAR43hj7  This results in some fairly slow
> connections.
>=20
> I am seeking some general advice on how to optimise batman-adv in the
> context of a dense mesh.  Options that we have considered include
> turning the radio transmit power down on all of the devices and/or
> alternating channels on different floors (e.g.  1,6,11,1,6,11,etc).
> However, it is not clear to us what is the best strategy in this
> context.  Grateful for any tips or suggestions you may have.
>=20
> Thanks in advance.... Steve Song
>=20

Hi Steve,

The following is my experience.

Optimise layer 1 by:
*) proper channel assignments
*) reduce txpower
*) dont's send when you don't have to send
*) use spacial separation of frequencies and directionality if possible =
(ok, this is more of a general advice, won't matter so much in =
apartments)
*) most importantly: use 802.11n!


