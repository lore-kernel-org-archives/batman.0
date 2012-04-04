Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 4 Apr 2012 10:08:06 +0200
References: <1333370896-11295-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1333370896-11295-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201204041008.06362.lindner_marek@yahoo.de>
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

On Monday, April 02, 2012 14:48:14 Martin Hundeb=C3=B8ll wrote:
> Before sending an RFC on my work with network coding/catwoman, I would li=
ke
> some feedback on this stats-feature I build to measure the behaviour of
> catwoman.
>=20
> It is basically a set of counters that are incremented on various places =
in
> the code as a more detailed alternative to the interface statistics.
>=20
> Currently, my catwoman branch uses these counters (e.g. to tell how many
> packets are coded together), but other counters can easily be added. E.g.
> counters relevant to the BLA, DAT, OGM/ELP code.
>=20
> If this feature is unneeded/unwanted, I will remove the dependency in
> catwoman.

Could you explain in a few words how catwoman depends on the stats counter ?

Regards,
Marek
