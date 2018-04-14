Return-Path: <a@unstable.cc>
References: <20180413181618.24144-1-sven@narfation.org>
 <78ec0422-9046-3db1-6a81-4c1c7d0c9968@unstable.cc>
 <1658833.3ZLkxubxK8@sven-edge>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <af29c3fe-d25e-51d2-7ca1-47738f25ab7a@unstable.cc>
Date: Sat, 14 Apr 2018 16:11:28 +0800
MIME-Version: 1.0
In-Reply-To: <1658833.3ZLkxubxK8@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tyRd6pWtka3IUFsNWRJdykft4yY2VP5r8"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Validate translated mac addresses
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Andre Kasper <Andre.Kasper@gmx.de>, linus.luessing@c0d3.blue

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tyRd6pWtka3IUFsNWRJdykft4yY2VP5r8
Content-Type: multipart/mixed; boundary="9Hanvker29eHvdwZGhuVpuU6yqtmKzrag";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Andre Kasper <Andre.Kasper@gmx.de>,
 linus.luessing@c0d3.blue
Message-ID: <af29c3fe-d25e-51d2-7ca1-47738f25ab7a@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Validate translated mac addresses
References: <20180413181618.24144-1-sven@narfation.org>
 <78ec0422-9046-3db1-6a81-4c1c7d0c9968@unstable.cc>
 <1658833.3ZLkxubxK8@sven-edge>
In-Reply-To: <1658833.3ZLkxubxK8@sven-edge>

--9Hanvker29eHvdwZGhuVpuU6yqtmKzrag
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 14/04/18 15:10, Sven Eckelmann wrote:
> On Samstag, 14. April 2018 04:34:42 CEST Antonio Quartulli wrote:
>>
>> On 14/04/18 02:16, Sven Eckelmann wrote:
> [...]
>> We already handle the case of multiple originators handling the same M=
AC
>> address, no? In that case I think we pick the "best" originator.
>=20
> Yes, but this doesn't make a lot of sense for multicast and zero mac=20
> addresses. The translate layer of batctl is usually used to ping/tracer=
oute to=20
> some originator. But multicast and zero mac addresses don't represent a=
=20
> "client" which can be used to identify some originator. So it doesn't s=
eem to=20
> make sense to allow them here.

Right.

>=20
> Or even without the ping/traceroute stuff, the concept of calling `batc=
tl=20
> translate` should give you an answer which you can understand. So it sh=
ould=20
> tell you that batman-adv is very likely to transmit a unicast packet wi=
th this=20
> destination address to this originator. But this cannot work for multic=
ast=20
> destination addresses because multiple answer should be given here - wh=
ich is=20
> out of scope for this command. Which reminds me that I should propose a=
 second=20
> patch which checks whether the input for translate_mac is "valid" befor=
e=20
> trying to translate it.
>=20
>> This case sounds more like a validity check because "a zero MAC should=

>> not be in the translation table", or am I wrong?
>=20
> Partially, yes. I personally don't care (at the moment) whether there i=
s a=20
> zero mac address in the translation table. The current translation tabl=
e code=20
> (batadv_tt_local_add) doesn't check whether there is a zero mac address=
=20
> (is_zero_ether_addr). But Linus had some ideas when zero mac addresses =
can be=20
> useful - maybe he tell us whether it makes sense/problems to have them =
in the=20
> translation table.

Yeah, I agree that zero "may appear" in the table and therefore we have
to "check" what we are getting back and whether it makes sense for us in
this context.


Actually my comment was not about changing your approach, but just
making it more explicit in the commit and in the error message.

An error message like like "returned invalid all-zero mac address" (or
"multicast address") might help to distinguish similar "ambiguities" in
the future. No?



Cheers,



>=20
> Kind regards,
> 	Sven
>=20

--=20
Antonio Quartulli


--9Hanvker29eHvdwZGhuVpuU6yqtmKzrag--

--tyRd6pWtka3IUFsNWRJdykft4yY2VP5r8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlrRt7AACgkQB6U8WA7y
zXTpAw//b4rcU9XolEms6BdyONSbSyD4WNZXiXe2vhGwUORvvGpB/CXTgVWewHCV
+WYhuoqZ2IRgQuLo+a2zkrMN1d4zgK5D/hc+m/yhExciP6WWffg3QqL5kSIMHXkd
LwnW9upg0KAbaLHhkfdtZoGdp8z8Hi8qpwisagOMy9x7BA0rOlUwlRX6HtruJpbg
nkTyIRm3I4fDlBxGEt/XOvzfx9b10MP2dhdzBB9tFadwssaRkVJHvG6wzDDgAoY6
xFU83QVl3Ins3KiaQR7qGLpRydzA5bc+CLhO89mV2TTF0YFFDbto6hoq0V5v1PMl
EtLCfhC4If2fpD8n43xRQK4q7zm0eydooInkguMrlbNg1gF3IFsBiZg06BUwAvTj
mUFIB+7B7LYDHVzT8UbuNx4Zh3OSYOUOCHhVDLfujpwfXGvqTkmTwaYEwbPLJD9b
wvOSjaZyXSXa08ydF10FuGzEjncNmevqZVTUjhRSXXvGHABxTOQtQaOw3ssGyeKD
9hxb0DbJhMYqe2fahlW7XlOmSsNgavndUfBeaZu2KqPzUCDSOx/3nAoVNfrHJI5+
s1vadN3oAEkXz3p4fwgOKG6whlcZ4vqfJj5vWhrV1mdIiyvX/3oofpQrYoZn/6Fk
q0+R6OkLlEF4l4k2Y1ZK6dCLhCtqPsKsfrEYXhrmAn74L75mBaY=
=evEE
-----END PGP SIGNATURE-----

--tyRd6pWtka3IUFsNWRJdykft4yY2VP5r8--
