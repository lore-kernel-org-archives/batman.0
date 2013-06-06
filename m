Return-Path: <ordex@autistici.org>
Date: Thu, 6 Jun 2013 21:18:23 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130606191823.GJ1789@ritirata.org>
References: <20130603160813.GC1226@ritirata.org> <51AD0277.1060907@inti.gob.ar>
 <20130604051326.GJ1226@ritirata.org>
 <20130604053841.GK1226@ritirata.org> <51AF567A.7030404@inti.gob.ar>
 <51AF58F4.8080501@inti.gob.ar> <20130606055102.GH1789@ritirata.org>
 <51B0D294.4070809@inti.gob.ar> <20130606182954.GI1789@ritirata.org>
 <51B0DD43.6090500@inti.gob.ar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OX7PPUk8qMPP4++R"
Content-Disposition: inline
In-Reply-To: <51B0DD43.6090500@inti.gob.ar>
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
To: Gabriel =?utf-8?B?VG9sw7Nu?= <gtolon@inti.gob.ar>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--OX7PPUk8qMPP4++R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2013 at 04:04:35PM -0300, Gabriel Tol=C3=B3n wrote:
> El 06/06/13 15:29, Antonio Quartulli escribi=C3=B3:
> > On Thu, Jun 06, 2013 at 03:19:00PM -0300, Gabriel Tol=C3=B3n wrote:
> >> Hi Antonio,
> >>
> >>
> >> El 06/06/13 02:51, Antonio Quartulli escribi=C3=B3:
> >>> Hello Gabriel,
> >>>
> >>> On Wed, Jun 05, 2013 at 12:27:48PM -0300, Gabriel Tol=C3=B3n wrote:
> >>>>
> >>>> Sorry, I sent the mail incomplete,
> >>>>
> >>>> So these are the routes:
> >>>>
> >>>> Equipo1:
> >>>>
> >>>> root@Equipo 1:~# batctl o
> >>>> [B.A.T.M.A.N. adv 5ffa8f2, MainIF/MAC: wlan0-1/66:70:02:4e:d9:42 (ba=
t0)]
> >>>>      Originator      last-seen (#/255)           Nexthop [outgoingIF=
]:
> >>>> Potential nexthops ...
> >>>>              E3-5GHz    0.680s   (251)           E3-5GHz [   wlan1-1=
]:
> >>>>           E3-5GHz (251)
> >>>>              E3-2GHz    0.430s   (255)           E3-5GHz [   wlan1-1=
]:
> >>>>           E3-5GHz (255)           E3-2GHz (252)
> >>>>
> >>>>
> >>>> Equipo3:
> >>>>
> >>>> root@Equipo 3:~# batctl o
> >>>> [B.A.T.M.A.N. adv 5ffa8f2, MainIF/MAC: wlan0-1/66:70:02:4e:d9:d6 (ba=
t0)]
> >>>>      Originator      last-seen (#/255)           Nexthop [outgoingIF=
]:
> >>>> Potential nexthops ...
> >>>>              E1-2GHz    0.310s   (255)           E1-5GHz [   wlan1-1=
]:
> >>>>           E1-5GHz (255)           E1-2GHz (255)
> >>>>              E1-5GHz    0.550s   (255)           E1-5GHz [   wlan1-1=
]:
> >>>>           E1-5GHz (255)
> >>>>
> >>>
> >>> routing tables look good. I am wondering where the problem can be..
> >>> Can you try to do a "batctl td wlan0-1" while pinging? this may help =
to
> >>> understand where the process is blocking.
> >>> It would be helpful if you could do that on both the nodes while ping=
ing in only
> >>> one direction This way we see who receives what.
> >>
> >> I did it, but the text files for the logs of the nodes with "batctl td"
> >> have a size of about 250 kB each one, with just 1 or 2 seconds logging.
> >> Is that too much for sending them to the list?
> >
> > maybe  you can upload them somewhere and then send the link here?
> >
>=20
> Yes, should be here:
>=20
> http://pastebin.com/GNSC2Pmn
>=20
> http://pastebin.com/m3xtjchX
>=20
>=20
> the batctl ping was from E1 to E3.

Hello Gabriel,
there is a lot of noise because you are also generating traffic on the netw=
ork.
However I can see the ICMP Echo Request and then an Echo Reply, therefore t=
he
two nodes seem to be exchanging ICMP packets correctly.

I'm checking again to try to understand what went wrong.

Meanwhile, can you please report the output of
"batctl l"
during a bw test after having set the bw_meter log level by running
"batctl ll bwm" ?

To get the exact log of one test, you can first run batctl l (this will pri=
nt
all the past log), then you run the test and then you run batctl l again to
obtain the interesting log. Please upload it on pastebin too.

Thanks a lot!

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--OX7PPUk8qMPP4++R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRsOB/AAoJEADl0hg6qKeOIMQP/igveG+eKfvi60DKAxbKM4Gy
kcAZNr3FrP0zQqhkYVk4ogPrts250E2nPpMrEG1eUJCA1hIpPhZrzZtR/4XvVuBz
VpJFUF/XTrF9emElAYG5DjFSe5jz///V1h1Wy05Pj/l9LlWkxwWNjTKc1a/F/eq2
bPGC42IdfwVa8X29toNVm9LgaStmgY4SokhwpmlVB3ARYjDsRv5FTCCviU9vsFIJ
XtsuepGua3m3B1DTbkbyJ7ezZluZ0hLx3aZEPzyiDn/3oJt+wJmuHQw3nhvz3L4t
b2APnFcXMcUG0d5WWI9sxVsbo7zMU+x45f685zLg85yhKG6eKQnMAxvoXIespfCW
BzCux7GOFL9kEGTuY8ylIJQgXNiLzmNMWO5Wup+PaBvynfHN+4dYxoc3WqRmNSJ4
NTcvlTmhvHpxnqJwWxoea7wA9z5InV1Lw2aIlAhjf8K8alxjzUlXJ0sWezWGNEiS
mSiHt3c2w2hEVpZSkm5SpbH43HfKCHd3re4KadpMP83ObIYMbG2u+vpbUg0go/gn
+ixirVuqK7IW6txJNwzXep4egYjZk3XyHWu8C3k8CkWqHBon0CbdxT+EFrEayuM6
sLYS9UhqCgjw66+tWVRsOuyiRCKticpnIzV4/lHw42HXB757zoCHCVa2O1aX79TL
y9Q4hMSZvY7xP+Qr37Cp
=36QQ
-----END PGP SIGNATURE-----

--OX7PPUk8qMPP4++R--
