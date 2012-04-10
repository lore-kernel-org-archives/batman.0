Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 10 Apr 2012 14:08:39 +0300
References: <1333370896-11295-1-git-send-email-martin@hundeboll.net>
	<201204041008.06362.lindner_marek@yahoo.de>
	<4F840CC6.8000404@hundeboll.net>
In-Reply-To: <4F840CC6.8000404@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201204101408.39431.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 0/2] Create counters for measuring behaviour
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

On Tuesday, April 10, 2012 13:34:46 Martin Hundeb=C3=B8ll wrote:
> >> Currently, my catwoman branch uses these counters (e.g. to tell how ma=
ny
> >> packets are coded together), but other counters can easily be added.
> >> E.g. counters relevant to the BLA, DAT, OGM/ELP code.
> >>=20
> >> If this feature is unneeded/unwanted, I will remove the dependency in
> >> catwoman.
> >=20
> > Could you explain in a few words how catwoman depends on the stats
> > counter ?
>=20
> Sure, it's merely because I use the bat_stats-functions in the catwoman
> branch. Nothing more than that.

If the traffic counter code provides empty functions to be called when it i=
s=20
not compiled into the module it should all work ?

Regards,
Marek
