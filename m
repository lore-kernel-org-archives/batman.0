Return-Path: <a@unstable.cc>
Date: Sun, 17 Apr 2016 17:37:31 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160417093731.GC27815@prodigo.lan>
References: <1460597825-22660-1-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Content-Disposition: inline
In-Reply-To: <1460597825-22660-1-git-send-email-a@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: B.A.T.M.A.N V - make sure
 iface is reactivated upon NETDEV_UP event
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

it looks like this patch was not interpreted the right way, probably becaus=
e of
a lack of communication between me and other maintainers or probably because
too much laziness here and there...

Explanation follows below.

On Thu, Apr 14, 2016 at 09:37:05AM +0800, Antonio Quartulli wrote:
> At the moment there is no explicit reactivation of an hard-interface
> upon NETDEV_UP event. In case of B.A.T.M.A.N. IV the interface is
> reactivated as soon as the next OGM is scheduled for sending, but this
> mechanism does not work with B.A.T.M.A.N. V. The latter does not rely
> on the same scheduling mechanism as its predecessor and for this reason
> the hard-interface remains deactivated forever after being brought down
> once.
>=20
> This patch fixes the reactivation mechanism by adding a new routing API
> which explicitly allows each algorithm to perform any needed operation
> upon interface re-activation.
>=20

Right now we have a piece of infrastructure used by B.A.T.M.A.N IV that
consists in calling batadv_send_outstanding_bat_ogm_packet() periodically,
thus generating the following flow:

-> batadv_send_outstanding_bat_ogm_packet()
	-> bat_algo_ops->bat_ogm_emit()
	-> batadv_schedule_bat_ogm()
		bat_algo_ops->bat_ogm_schedule()

by scrolling over the mentioned functions I'd argue that such flow is rather
tight to the B.A.T.M.A.N. IV algorithm and, although there has been a lot of
effort in making such routines generic (that's why we have API calls in the
middle), such infrastructure is very difficult to be used within B.A.T.M.A.=
N. V.


On top of that, the logic implemented within this piece of infrastructure
aims to achieve two goals:
1) schedule OGM sending
2) send out aggregated OGMs


The consequence of this was that B.A.T.M.A.N. V has its own implementation =
for
sending OGMs and lacks support for OGMs aggregation (and queue limitation).


This said, the bug that this patch is trying to fix came up exactly from the
new implementation of point 1) in B.A.T.M.A.N. V.

One could argue that in order to fix this misbehaviour it would be better to
stick to using the already implemented infrastructure, but unfortunately, as
I explained above, this is not possible and therefore this patch can't go
in that direction.


This patch, instead, tries to make the first step towards changing the
infrastructure in a way where B.A.T.M.A.N. IV will adapt to its successor
and not viceversa.


The idea is to have a new API call to be invoked everytime a hard interface=
 is
brought up so that each algorithm can take its own decision about what to do
next.

At this point, the potential next steps that I see are:

1) convert batadv_send_outstanding_bat_ogm_packet() and invoked routines to
B.A.T.M.A.N. IV private code (remove bat_algo_ops->ogm_schedule/ogm_emit())

2) have B.A.T.M.A.N. IV use the new iface_activate() API introduced by this
patch (if needed)

3) make the aggregation code generic so that other protocols can enjoy the =
same
benefit without having to re-use exactly the same logic

4) implement aggregation in B.A.T.M.A.N. V with queue limitation

I tried to include point 1) in this patch so that it could look more "sane"=
 from
an architectural point of view, but given that this change is a fix (and th=
us
targets the net tree) I decided to squeeze it and include only what was nec=
essary
to fix the "interface-enabling" issue.


I hope this helps understanding the ratio behind this patch :)

Cheers,


--=20
Antonio Quartulli

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXE1lbAAoJEJ4aZjxxc6bKt9AQALOKdIQcx7FaMQWJQWHkfKVr
A2us6m+VPnDAuvFKRJuvT3T1mHFkIq3+Cg5TRlzOSWxphfUgBqUVP/gueUc23Nac
PFnn2JSsStLC5bdfawqFezRJgWj/61iFzZK2FlVYtevtJEoW5emq2ndgZ58VHTO2
o47/CztJrnl0JDcgoa9ZejZ4J/s3VVbCB5t4+2slcFVi01If7MsKcIX7/bo4rcYc
x8IIJAeazqDgylswbBQdT4C9bZ67uxs3UDkc7jqR079KR6zjRX8VD8IJIrSyN//u
dQ0o/Sp8uAt3mzTfszITGe0cTgIY94tUT+89UH7YR2CJIogRdJwCRcv1D0Kz9d6m
znCQCrL4Mip0xrDzpAPNrBp/6dykiUr2Q+8LEWFPDaEJE+qRiL+P8IWar/1Yz6qU
JIbXqo1I+C0L5i2b6sLpX9W3idXO3Z3SNjBM6dLMoCV5ZszeQzdR3zsGRvr7zzQ1
ZZUsX3JzeoifCma2q5nk0Y/0BGQQf13tk0GpZOM3ACyip4iDdR6JXsrTMnzE1X6P
VmUZUlxMzn2aeiQoXvj3yigHo7nCx5iLzqmYTfYdw4SPpuKaXMeZQyyVdr9ER30L
zNR1A/ijvJ9AA/43611wlxFjGBrexREnRZC8hw4YBP9s4AQdkZzN//A7N4L8N+BZ
iK99+7kyDVAVlR/LsnwV
=fjKh
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
