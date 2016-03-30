Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 30 Mar 2016 13:58:31 +0200
Message-ID: <34764958.y3lWsCmXTL@prime>
In-Reply-To: <20160329083717.GA32035@r2d2.s.lihas.de>
References: <56F5AF2F.6060904@t-online.de> <20160328235247.GA4528@otheros>
 <20160329083717.GA32035@r2d2.s.lihas.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3685470.C4Lcf5ogCd";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
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

--nextPart3685470.C4Lcf5ogCd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Adrian,

On Tuesday 29 March 2016 10:37:17 Adrian Reyer wrote:
> Hi,
>=20
> On Tue, Mar 29, 2016 at 01:52:47AM +0200, Linus L=C3=BCssing wrote:
> > At least this approach would cover everything we care about for
> > current Freifunk setups for now and many more. Without the user
> > being able to misconfigure something that easily. (usually a user
> > would not set a TRANSITIVE flag on the interface, but e.g. drivers
> > and applications creating the interface would)
>=20
> The interface doesn't have the information needed, so the (assumed) h=
uge
> effort of bringing in a new flag for all types of network interfaces =
is
> somewhat useless.
> In my eyes we have two types to consider here:
> 1. lossy links, this is what can be 'fixed' be repeatedly sending a
> broadcast out
> 2. different listeners, e.g. due to wifi range. If we have the same
> listeners for everyone on an interface we don't need a re-broadcast a=
t
> all.
> There are many different possibilities to generate the different
> combinations of 1 and 2 with common hardware.
> - wifi AP-mode: lossy, same listener
> - wifi adhoc mode: lossy, different listeners
> - ethernet cable on a switch with the listeners on: non-lossy, same
>   listeners
> - ethernet cable towards a wifi-bridge in adhoc mode
> - ethernet cable towards a wifi-bridge in ap mode
> - various types of vpn with and without meshing
> - SoC with wifi attached via vlan in adhoc, station or ap mode
> - network technologies stacked on others, e.g. tagged vlan a into
>   openvSwitch and the lossy wifi link is the untagged vlan a, while
>   tagged vlan b is plugged into a solid vpn.
> - add bridges to the game, old style or ovs
> - add other stuff like ppp, slip, atm, ...

I don't think we have to pull out every possible case here. People will=
 always=20
be creative in designing their networks, even if their would be some ea=
sier or=20
better approaches[tm]. Not supporting everything is not a flaw in my op=
inion,=20
at least as long as we support sound alternatives.

For example, I don't see why we would need to support not-forwarding/no=
t-full=20
mesh VPNs. We could just require every mesh participant to run batman-a=
dv, and=20
not supporting setups where, for example, the "master" node doesn't spe=
ak=20
batman-adv, since that could be easily enabled. If there are multiple=20=

independent VPN links, those could be done in seperate interfaces. Is t=
hat=20
assumption correct? (Maybe Freifunk people could tell a little bit more=
).

So far, I see the following scenarios:

Broadcast needed:
 * WiFi Ad-Hoc
 * WiFi AP
 * Ethernet to WiFi Ad-Hoc bridges (is that even used?)

Broadcast not needed
 * WiFi Point to Point links
 * Ethernet
 * VPNs (at least common setups)

As a very easy rule of thumb, we could say that rebroadcasts on the sam=
e=20
interface should always be enabled on WiFi and disabled on everything e=
lse.=20
Even if we still agree to introduce a flag to change that, that could s=
till be=20
a sound default. Would you agree?

> I advocate an admin-settable flag for batman, defaulting to the curre=
nt
> behaviour. Nothing breaks that way, only batman needs to be adjusted =
and
> the patch already exists and is tested. Admins can set the flag if th=
ey
> think they have use for it and they do it knowingly. If they do it 'b=
y
> accident' it is as little batmans fault as if they earased their disk=

> with some dd-command. Default is sane, just more traffic than necessa=
ry
> in some common szenarios.

We try to minimize flags and settings in general as a design goal. Othe=
r=20
implementations we looked at have too many "tunable" parameters, people=
=20
writing in forums/mailing lists how and why these settings should be se=
t=20
without really understanding it ... This is why we try to not expose=20=

everything, even if we would leave a little bit of room for improvement=
.

I'm not against the flags, but its good to have a discussion to find ou=
t what=20
is really needed ...

Cheers,
     Simon
--nextPart3685470.C4Lcf5ogCd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW+79nAAoJEKEr45hCkp6h0UoQAIP5cIoHp38kkQ2gGLupSeIl
8sUTMuSTa7lLpy4OjQhrf5/+KlrWIOn5/3SuDkoj0mVP6vt1bQorllOhdpWBXKxS
OdreGaveqfiMlnqC8vAur5DwypocApEvBsqQhXkAIWJ8zT2KYRXWj/8E599S+ZgD
9s5J2FRClQ9DOpjND5Y2tymy6karvyEZ4Hnmxcqt4ryZ/SLEZ9hz7aYhpgwJWYqN
A4M5JKl64WtoTmkQHxhc+L0DFU9HDGuz4+ypkBnp36KxEMMCpWWtLDssKaCPGy4r
CShjE+RFGYv8HLBDtvcBMVJIQntLytFdj98ie/0ikTV0t9DdqjAfGRIcX9GaM9nG
YyCUd3e9rQtIoC7HyNB+8lriV9jyb3MEqyos3W8+IML677OkkK0zoWxsOOUFBj7T
2UPo+bXuOV2kDgGEZ/8iDxWCbE6nkOYlIK0cuzB3cnOAnO9JDS0BkkKTa/n7DNw3
lz4GhEe0joRBrRY5gvEif6YF0XBIa0aGTiiAJQw74KjEgBg4zvOn/pHMSa80GAGu
5oB3dyL69D15UtzP0WzTYrpBN26m1ZQErW7zZoS7xAWSLOtD7/d2cmqtEALBVe8s
pAb54r39XPWTjaXAZajS5TTWK8CTtdYoS8sym9DJFFfw56hX5kaFN2rl6M3O2F5c
sSn4ph4oppkz3HMLbQ2j
=anaw
-----END PGP SIGNATURE-----

--nextPart3685470.C4Lcf5ogCd--

