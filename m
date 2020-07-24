Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Fri, 24 Jul 2020 12:02:50 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: Batman_V Originator Loop Issue
Message-ID: <20200724100249.GA2357@otheros>
References: <5716273.fDpRzsxG9E@prime>
 <20200708152649.1176.81859@diktynna.open-mesh.org>
 <20200709203344.GB2269@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200709203344.GB2269@otheros>
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: lavincent15@gmail.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Thu, Jul 09, 2020 at 10:33:44PM +0200, Linus L=C3=BCssing wrote:
> Hi Luke,
>=20
> On Wed, Jul 08, 2020 at 03:26:49PM -0000, lavincent15@gmail.com wrote:
> > Simon,
> >=20
> > When I enable DAT on all of my nodes, the network breaks down. With D=
AT disabled on all the nodes, the network works fine.
> >=20
> > As I develop my project, I would like to take advantage of the mesh w=
ide ARP caching feature DAT. Is there any way I can fix things to where D=
AT will work on my network?
> >=20
> > Thanks,
> > Luke
>=20
> Would it be possible for you to try an older version of
> batman-adv, like v2019.0? There were a few new feature additions
> for DAT after that one.
>=20
> Btw. did you also try disabling aggregation with your batman-adv
> 2020.1 version? That didn't make a difference, right?
>=20
> (disabling aggregation for BATMAN_V in v2019.0 won't make a difference
> as it wasn't implemented there yet, so if you could try that with
> 2020.1 would be great)
>=20
> Regards, Linus

Hi Luke,

Any news, especially regarding aggregation?

Some likely bug regarding the aggregation was found, a
description + potential patch can be found here:

https://www.open-mesh.org/issues/413

Would be great if you could check if this is related to your issue
or not.

Regards, Linus
