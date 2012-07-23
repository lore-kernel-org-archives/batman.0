Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 23 Jul 2012 14:52:48 +0200
References: <5008C14B.6040707@codigosur.org>
 <201207221320.14242.lindner_marek@yahoo.de> <500D1339.80702@codigosur.org>
In-Reply-To: <500D1339.80702@codigosur.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201207231452.48646.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv not selecting a gateway when using
	"client 1" through uci config
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Monday, July 23, 2012 11:02:49 Nicol=C3=A1s Ech=C3=A1niz wrote:
> >> Is this some known behavior or just something I overlooked?
> >
> >=20
> >
> > In fact you managed to uncover a regression that was overlooked for qui=
te
> > some  time. Guess gw selection class 1 is rarely used.  :-)
> >
> >=20
> >
> > Can you apply the attached patch and verify that it fixes the problem ?
> > Here  in my test setup it does.
>=20
> Marek patch applied (thanks Guido) and verified.
> gw_mode client 1 is now properly selecting a gateway when set in the
> config.

Thanks for testing the patch. I updated the OpenWrt package and will provid=
e a=20
patch that goes into the next release.

Cheers,
Marek
