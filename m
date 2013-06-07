Return-Path: <ordex@autistici.org>
Date: Fri, 7 Jun 2013 16:40:19 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130607144019.GM1789@ritirata.org>
References: <51AF567A.7030404@inti.gob.ar> <51AF58F4.8080501@inti.gob.ar>
 <20130606055102.GH1789@ritirata.org> <51B0D294.4070809@inti.gob.ar>
 <20130606182954.GI1789@ritirata.org> <51B0DD43.6090500@inti.gob.ar>
 <20130606191823.GJ1789@ritirata.org> <51B1E4D6.5000900@inti.gob.ar>
 <20130607135713.GL1789@ritirata.org> <51B1F062.3060101@inti.gob.ar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5fECsWged6836Ycf"
Content-Disposition: inline
In-Reply-To: <51B1F062.3060101@inti.gob.ar>
Subject: Re: [B.A.T.M.A.N.] batctl bw performance
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


--5fECsWged6836Ycf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2013 at 11:38:26AM -0300, Gabriel Tol=C3=B3n wrote:
> Hi,
>=20
>=20
> El 07/06/13 10:57, Antonio Quartulli escribi=C3=B3:
> > Hi Gabriel,
> >
> > thank you for your logs
> >
> > On Fri, Jun 07, 2013 at 10:49:10AM -0300, Gabriel Tol=C3=B3n wrote:
> >>>
> >>> Hello Gabriel,
> >>> there is a lot of noise because you are also generating traffic on th=
e network.
> >>> However I can see the ICMP Echo Request and then an Echo Reply, there=
fore the
> >>> two nodes seem to be exchanging ICMP packets correctly.
> >>>
> >>> I'm checking again to try to understand what went wrong.
> >>>
> >>> Meanwhile, can you please report the output of
> >>> "batctl l"
> >>> during a bw test after having set the bw_meter log level by running
> >>> "batctl ll bwm" ?
> >>>
> >>> To get the exact log of one test, you can first run batctl l (this wi=
ll print
> >>> all the past log), then you run the test and then you run batctl l ag=
ain to
> >>> obtain the interesting log. Please upload it on pastebin too.
> >>>
> >>> Thanks a lot!
> >>>
> >>
> >> Sure, here they are:
> >>
> >> http://pastebin.com/fLu9hsyt
> >>
> >
> >
> >  From this log I can see that the protocol is entering Fast Retransmit =
many times
> > and this happens due to reordering or small losses (the latter option i=
s more
> > realistic on a single hop network - but is it really one hop? I never a=
sked).
>=20
> Yes, it's one hop. Just two routers at a distance of 2 meters. They have=
=20
> two radios, but in the last tests I've unloaded one of them (the 5 Ghz=20
> one) to make it simpler, so they see each other just by one radio interfa=
ce.
>=20
> >
> > The other strange thing I see is the final SRTT value which is 260ms an=
d looks
> > pretty high. Is there anything else going on the network (other traffic=
 or..)?
>=20
> Mmm, I don't know what's that SRTT, but no, there shouldn't be anything=
=20
> else in the air, at least not from me. But If there were interference or=
=20
> something like that, normal iperf would be slower I guess.
>=20
> Besides, now I've tested connecting my PC via Ethernet to log avoiding=20
> interference from myself, also unloading the 2GHz, and loading the 5GHz=
=20
> in the routers (the 5GHz band should be cleaner), and the batctl bw=20
> keeps with slower values than iperf, 5Mbps this time.
>=20
> If you want I could sniff the air with wireshark or something.
>=20
> Maybe other possibility could be testing the bw meter connecting the=20
> routers by etnernet and not wirelessly?

Yes, you can try ethernet too. it works the same way.

>=20
> Just for curiosity, you have already tested this on other scenarios and=
=20
> worked OK?

yeah, I tested it using my routers (OM2Ps) and it worked good.

You can try to sniff one or two seconds of traffic with "batctl td"
on the nodes. This will give us what is exactly going in the air.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--5fECsWged6836Ycf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRsfDTAAoJEADl0hg6qKeO/54QAIFrVng+Qy4xCrQPjBxuWWFm
h/UaPNfZMlkglk/u3EjUIEbGrJXn3PjfsZx0bQeQxMwcg1ErgpmYQW0lgU1VCi0w
qWc3YyKAdOzXtGTrC14o9fiB28k3pMrPOn/TH+MkHodF4hQITYxe7XRlEIuM1cEu
66cBGir5ZRe2aSe5z+UB572htZ+zEsxOFzhxkMnHNGVlSaCPLTIges2HIJlHC8e8
Vc4AhL5R+XvRrd5emoSIncCtwyPLZT6AxjOqtTzQYrhHbvf8tdXZUvhHkYNuxtCW
3xIrHv/uCpOlG0DRnKQzqp0RywPDy2dU1kq5cQfiZLFwksjBow+JN0ov0PbO38nK
O9WiBZVsChmr0qbICfgymIo91oiNawdeQxCfKlyN+C/pIZKLgTUG+b5CeRI+Hb2Q
a3M0q/3E+4VF28R7gXxIyv8WCMG43lPk/Xy/5wIwXPZ6wbScojMgJFbWUjpKPIYH
sTMR0MbeQxJy/9LSBzbgnBj1e7Xv6Qn74DIRcbTOYuWAxMpjTfmSPSYfSBGbb6fO
ZAbGJh1F/mIvLo3mOYIguP1HrsAAF9JD2RtWqEFmVU8TOqxNOKMpEXJQOnxdmFMh
lunlElNztFlMdS5ctNMBf8FjJzyDMm+KeRrjW2MCugtUf1TEItaa1J5SCTPu6WL5
w1XgzhsiywvvaUPx+RJ3
=2TD3
-----END PGP SIGNATURE-----

--5fECsWged6836Ycf--
