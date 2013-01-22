Return-Path: <ff@stephan.homeunix.net>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1085)
From: =?iso-8859-1?Q?Jan_L=FChr?= <ff@stephan.homeunix.net>
In-Reply-To: <CAD_CWO1hPN=7RVQA+W25oM5nCxxYxV1yefXAYboTvK5_H+hxJg@mail.gmail.com>
Date: Tue, 22 Jan 2013 14:27:41 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <DF3313C4-3A11-43A1-9CB8-8D27A2D226A1@stephan.homeunix.net>
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

Hello,

Am 22.01.2013 um 13:54 schrieb Steve Song:

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

using different channels is always a good idea when it comes to crowded =
places.
Another option in to use 5 Ghz for mesh and 2.4 Ghz for clients.

Another options is to use less nodes - one node per appartment might be =
too much.

Turning down the transmit power can help, but might have the opposite =
effect.
(Interference- vs. transmission range)

Another - imho the most important rule - is to limit hops
Each hop limits the total throughput: if using same wireless channels =
one hop cannot forward data while receiving. It has to wait.
=20
To summarize:
-> Minimize the (expected) hop count.
-> Use as many channels as possible (incl. 5 Ghz)
-> Use as few nodes per channel as needed to provide coverage

Keep smiling
yanosz


