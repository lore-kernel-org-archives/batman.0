Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 02 Aug 2016 09:44:25 +0200
Message-ID: <2387161.uZshiIbDPD@bentobox>
In-Reply-To: <20160801205716.GB9200@otheros>
References: <1469137112-24094-1-git-send-email-linus.luessing@c0d3.blue>
 <6419172.04lP9a1mmf@sven-edge> <20160801205716.GB9200@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1660009.Ay1Rlt4MzM";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Use own timer for
	multicast TT and TVLV updates
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

--nextPart1660009.Ay1Rlt4MzM
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Montag, 1. August 2016 22:57:16 CEST Linus L=FCssing wrote:
> On Fri, Jul 22, 2016 at 12:19:54AM +0200, Sven Eckelmann wrote:
> > On Donnerstag, 21. Juli 2016 23:59:30 CEST Sven Eckelmann wrote:
> > > On Donnerstag, 21. Juli 2016 23:38:32 CEST Linus L=FCssing wrote:
> > > > -       struct hlist_head mla_list;
> > > > +       struct hlist_head mla_list; /* protected by mcast.work */
> > >=20
> > > Protected by a workqueue item? How?
> >=20
> > Looks like you wanted to say here that it is only modified inside the w=
orker=20
> > queue (via the mcast.work delayed workqueue item) - unless it is not do=
ne this=20
> > way like in batadv_mcast_free after cancel_delayed_work_sync.
>=20
> Exactly :). I tried to "summarize" that a little to make it fit as an
> inline comment ;). (although there are some further kerneldoc remarks on
> the functions using it)
>=20
> Is it ok now or do you think I should add something like your
> explanation somewhere else?

I personally don't like the statement "protected by mcast.work". Maybe you =
can
add something like "see ...." to reference the functions/kernel-doc describ=
ing
why it "protects" it.

Kind regards,
	Sven
--nextPart1660009.Ay1Rlt4MzM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXoE9ZAAoJEF2HCgfBJntGctEP/1e+t03ATxgNUSjDEzk3loML
wJQI1kB4EkKMF5pXwIFswE5QX5lwZ3yno4n4DkfFEwID7uzeKo7Ag62BDrmjD2w6
Ns0fKEZjIYWrpstsFTgAv7Q7GCNVB0xFFWMpLnevwufnF55GVsLXdn56PN0lJhtN
ChgukSfKSErJFmc3z9W73IYWG8NI/qsp0ZjDZb4ra7V7mYfGKaWVkhbolfWP0hUk
9GuacPDlkRXRZHKJDhxGpuJU2zTYaCX6FMiQTlQxkBV9qYxlnfFMZOfaTNOj3bt9
JHOJtvH1pPtkTfoQBBFSfEF06Uk2H68pqMOQ7nvfQOVzy53r8uXkeFCV7wm6+auZ
hGoyZmC1i7PumSgWfauLvo+sO/PeV58Be5k1sRtdmtXZIAmNvQWcAWL+kv5AUFD9
YraN6Un6mwjDZh/q9FQ7fPztf9L+IaXKTUC97M32nv+a2wNX4Dn4Ve1N9+vzz+SM
TPSXHh8m5IRSJdGohEMGe8E0C1IHtfiGo3DYF9xPiyhwo4FlWoJBm+yyQsxmHSSh
936IvFz22lHuslHEpm8LrLp1lG20wwQLAmDY92aMDY2bbXNaLnoNSj0GrpcJgRvV
gsOHdv4AW7dHgGpezDBQnYxezwaTlWaUS3q61tCwTWckifvtejgw5SkMhHV+T1uC
+WV+G+9tQMpwxAMBengK
=cpy4
-----END PGP SIGNATURE-----

--nextPart1660009.Ay1Rlt4MzM--

