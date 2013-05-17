Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 17 May 2013 12:24:41 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130517102441.GA1574@pandem0nium>
References: <1368293014-30742-1-git-send-email-linus.luessing@web.de>
 <20130516115129.GA27948@pandem0nium>
 <20130516174200.GA22374@Linus-Debian>
 <20130516183132.GA29196@pandem0nium>
 <20130517013855.GF22374@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20130517013855.GF22374@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] Basic Multicast Optimizations
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


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

On Fri, May 17, 2013 at 03:38:56AM +0200, Linus L=C3=BCssing wrote:
> >=20
> > For the non-link-local IPv4 multicast addresses, could we use the
> > current mechanism (drop/unicast/broadcast) by getting the assigned
> > multicast addresses? (of course, assuming we have no bridge)
>=20
> We could - after implementing MRD. The thing is we might have one
> or more IPv4 multicast routers in our network. If we are having
> two multicast listeners on our link, then everything will be fine,
> we will broadcast, multicast routers receive the multicast
> packets, too and the multicast data gets routed further. However
> with no MRD and if there is just one or no multicast listener
> then we'd do the unicast/drop and the multicast router on the link
> and any listener more than one hop away would not receive that data
> anymore.
>=20
OK, I see. Well, then we should save that for later ...

> > > For MRD I was thinking about taking a short-cut for now as
> > > implementing would need a few more lines of code. Instead I think
> > > I go for detecting whether a querier is on the link both in
> > > batman-adv and the bridge code for IPv4 or IPv6 and if not disabling
> > > optimizations accordingly and issuing a warning. That way
> > > non-link-local IPv6 multicast traffic could be optimized already
> > > for instance if running an mrd6 instance in userspace which
> > > already performs both MLD querying and MRD.
> > >=20
>=20
> Sorry, I ment: "For MLD querying I was...". mrd6 does perform MRD,
> so sending things like multicast router advertisements. But
> bridges or batman-adv would still need to parse these
> advertisements and should send multicast router solicitations
> (e.g. when an interface comes up) to be able to quickly determine
> which bridge ports or nodes have multicast routers and want the
> non-link-local multicast traffic.
>=20

OK

> >=20
> > Hmm, sorry I still get a little confused in that MRD/MLD/IGMP terminolo=
gy.
> > So as I understand there might be a userspace component which does the =
MLD/MRD
> > instead of the kernel?
>=20
> Yes, the layer 3 multicast routing table is in the kernel, but it
> is configured from userspace from daemons like mrd6. And mrd6 also
> does some non-performance critical protocol stuff like the MLD
> Querier protocol and the MRD multicast router advertisements like
> I said above.
>=20

OK

> > Also, is it required to get implement MRD/MLD specifically
> > in batman-adv or bridges, or would it be possible to use a "general" ap=
proach
> > which could be used for any interface to emit/exchange these kind of me=
ssages?
>=20
> The MLD querier is something which only makes sense to me in case
> of multicast snooping bridges and I don't see any benefit in having
> it anywhere else. If there are just the plain interfaces with no
> multicast router then you don't need an MLD querier (and in fact
> no MLD reports from the listeners either). If there's just
> batman-adv with no bridges, then you don't need it either.
> Although...
>=20
> There is one use-case where a more general approach might be of
> interest: Wireless interfaces - it might be of interest for the
> mac80211 to know whether there is a listener (or router) behind
> the link provided by your wlan0 device. The wifi driver could then
> decide to refrain from broadcasting a multicast packet or to use
> the (minimum) bitrate of just the(se) listener(s) (/router(s)).

Actually that might be interesting for both batman-adv and "regular"
WiFi setups. I think some commercial vendors already do exactly that
to optimize Multicast. My setup at home is a good example how this
could benefit:=20
 * I have 6 APs having mesh and ap bridged
 * Right now, when I multicast stream from my LAN, first batman-adv
   floods all the broadcast through the mesh, then every AP sends the
   broadcast again - all on the lowest rate (at least on the AP).
 --> so if we listen to music using multicast only in the kitchen,=20
   the WiFi becomes really slow. :D

With the multicast optimization in batman-adv, we could solve the
broadcast storm in the batman-adv network (only send to the APs where
listener registered). Then still the AP would broadcast these packets
on the lowest rate (1 MBit/s). Not all APs at least, but still the
one where the client is connected. If mac80211 could detect that
and send it via unicast, we could use even HT rates (e.g. 300 Mbit/s)
here. I could enjoy wireless multicast HD video streams - yay. ;)

Probably not the most typical example/use case, but still we can see
how this scenario would benefit from the optimization.

> Or maybe a drop/unicast/flood on an eth0 itself might be nice, too,
> especially if there is a large switch/hub connected to it.
>=20
> Although that'd probably be awesome to have, I think it's easier
> to just have the MLD querier in the bridge code for now (especilly
> as there already is some MLD querier code in the bridge - though
> it is so incomplete that it got disabled in April 2012 because of
> causing issues).

Actually I'm not sure about the technical implementation of such
a general approach. Maybe it would be possible to query the bridge
=66rom the various components as well.

>=20
> Hm, for the MRD RA parsing and MRD RS I thought about implementing
> that both in the bridge and batman-adv code (it's about 300
> lines of C++ code in mrd6). Not sure how easy it'd be to implement
> a more general approach on top of a Linux netdev for instance.
> Would need to check that.
>=20
> >=20
> > Sorry if I ask stupid questions. :)
> >=20
> > Maybe some example or architecture overview (could be put on the wiki p=
age) would
> > help?
>=20
> I guess you mean some visualizaton with things like simple
> devices, bridge, batman-adv, maybe various kinds of multicast
> types (e.g. scope =3D=3D link-local vs. scope > link-local, IPv6 transient
> vs. IPv6 well-known) and the according RFCs? Hm, not quite sure
> how that could look like would need to think about it - or maybe
> you have some idea about how you think that could/should look
> like?
>=20

Hmm, not sure either. Maybe we choose the typical examples (bat0 only,
bat0 + ap + bridge), and show which component sends what. Like having
"blocks" for batman, bridge, userspace mrd, etc, and show which component
sends/querys who for which information.

I know that's pretty vague, but maybe there is a way to bring light in
that for others which are not so experienced in that (me included).

Multicast types (IPv4, IPv6) and their mac-address and RFC recommendations
should probably better go in an extra section. We could make a table of
what types exist, how we handle them (optimize, just broadcast) and why
(RFC, design decisions).

> > OK. We could also increase the version number of the TVLV and interpret
> > both versions in newer multicast implementations, but if we already know
> > that we can define this information in the current implementation.
>=20
> But a newer TVLV version would break compatibility for older
> batman-adv versions, they wouldn't recognize the newer TVLV
> version. Or a node would need to add TVLVs for both versions to
> its OGM. But that'd be some more overhead compared to just adding
> another flag.
>=20

Yeah you are right. Maybe just add the flag. :D

> >=20
> > > >=20
> > > > Would you consider Antonios comments and update your patchset? I wo=
uld like to
> > > > test it in the next days ...
> > >=20
> > > Yes, I will. I had written some comments for the comments on IRC,
> > > but I guess it'll be better to write them here on the list again.
> > >=20
> >=20
> > Mailing list would be better, yes. Thanks. :)
>=20
> Done :).
>=20

Thanks!

> >=20
> > > >=20
> > > > Thanks,
> > > > 	Simon
> > >=20
> > > Another thing I was thinking about conceptually yesterday was
> > > whether we should use more refined flags instead of just
> > > MULTICAST_LISTENER_ANNOUNCEMENTS for everything (non-link-local
> > > IPv4, all IPv6 except the all-nodes address).
> > >=20
> > > That way we could for instance already add some cases for when to
> > > use the multicast optimizations when having a bridge, for
> > > instance:
> > >=20
> > > When batman-adv detects that there is an MLD querier and if all
> > > nodes have a MULTICAST_LISTENER_ANNOUNCEMENTS or
> > > MLA_IPV6_TRANSIENT_LINK_LOCAL flag it could  already
> > > optimize link-local, transient IPv6 multicast traffic
> > > without needing to modify anything in the bridge code except the
> > > addition of the export which was already posted as an RFC on the
> > > bridge mailing list.
> > >=20
> > > Hm, again will need to think about that. Whether the extra
> > > conceptual complexity is okay because of being able to add some
> > > more use-cases with less code in small chunks already.
> >=20
> > Hmm, again I'm not completely sure to follow, but the idea here is
> > to enable functionality when having a userspace MLD instead of
> > the (planned) bridge MLD stuff?
>=20
> Yes, that would be the idea.
>=20
> >=20
> > If we need the bridge MLD stuff anyway (to have the full feature set
> > etc), I'd rather not do more intermediate steps which might be
> > obsolete later. However, if the userspace MLD thing is equivalent
> > feature-wise than this might be interesting to do.
>=20
> Hm, don't know. I was thinking that most setups I know of involve
> bridges on top of bat0 and to be able to make use of any multicast
> optimizations in batman-adv in case of such bridging we need an
> MLD querier on the link. Implementing a proper MLD querier might
> need several iterations over the bridge / netdev mailing lists and
> might therefore need quite some time. During that time those
> setups won't be able to make any use of these optimizations.
>=20
> Unless taking the suggested short-cut which shouldn't be that
> difficult to implement, I think, then these bat0+bridge setups
> could already enjoy some multicast optimizations and such mesh
> networks might already be able to play with multicast streams as I
> think updating and merging the tracker packet patches will be done
> some time before getting MLD querier bridge code upstream.
> (but maybe I'm estimating all this wrong, dunno)

Actually I did not hear much screaming to have multicast support so far,
so I don't think we "need" an intermediate solution. If you want to it
anyway or need it for something, go ahead, but I'd prefer aiming for
the final implementation from the start without taking detours. :)

Thanks,
	Simon

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlGWBWkACgkQrzg/fFk7axaXLACfViN4QQXkv/ZKTKb+9DGkKFCZ
e1MAn1dkAV4w3blJCkjHS6iZymgVZ7o7
=sclG
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
