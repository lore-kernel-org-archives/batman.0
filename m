Return-Path: <antonio@meshcoding.com>
Message-ID: <52FB96D2.4080406@meshcoding.com>
Date: Wed, 12 Feb 2014 16:44:18 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-15-git-send-email-antonio@meshcoding.com>
 <20140212085812.GH30814@lunn.ch> <52FB68B2.80507@meshcoding.com>
In-Reply-To: <52FB68B2.80507@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FgGrGGnVwgDwVIsMjl488jGSWOoc2V9J5"
Subject: Re: [B.A.T.M.A.N.] [RFC 14/23] batman-adv: ELP - compute the metric
 based on the estimated throughput
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
To: b.a.t.m.a.n@lists.open-mesh.org, Andrew Lunn <andrew@lunn.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FgGrGGnVwgDwVIsMjl488jGSWOoc2V9J5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/02/14 13:27, Antonio Quartulli wrote:
> On 12/02/14 09:58, Andrew Lunn wrote:
>> On Tue, Feb 11, 2014 at 01:48:14PM +0100, Antonio Quartulli wrote:
>>> From: Antonio Quartulli <antonio@open-mesh.com>
>>>
>>> Implement a stub get_throughput() function which returns the
>>> estimated throughput towards a given neighbour.
>>> Its result is then used to compute the metric value.
>>>
>>> The metric is updated each time a new ELP packet is sent,
>>> this way it is possible to timely react to a metric
>>> variation which can imply (for example) a neighbour
>>> disconnection.
>>
>> It is very much a style issue, but i would probably split this into
>> two patches. Updating the metric at send time rather than receive
>> should have nothing to do with estimated bandwidth.
>=20
> Yes, to make it easier I will first move the reading at sending time an=
d
> then I'll introduce the throughput estimation.
>=20
>=20


Andrew,

I just rechecked the code and I realised that these "2 changes" are one
only because there is no "second change".

Before this patch ELP does not perform any metric estimation.

This patch adds the estimation mechanism and in particular adds it along
the ELP message sending path.


Maybe this was not clear? Maybe some previous patch gave you the
impression that a sort of metric estimation was already performed in the
receiving routine?


Cheers,

--=20
Antonio Quartulli


--FgGrGGnVwgDwVIsMjl488jGSWOoc2V9J5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS+5bWAAoJEEKTMo6mOh1Vg4gP/i504/zOwEoAuLhnkE1NXdNS
hevcVwcPYgZoLhX2RTpXAF4hBQz03dWgmphCKfWACra/QGtyPoCRiSvwvRrxLBEg
QyPz496SmIa7cFFvvAivFBvHGv28CjetLBqDS04XFznYBD7OpCdcTGdzyfXpNZWL
/Dd3k1mbRF9O4zhGgIuOtrfss4vaH02c8Cge9EUUXRk/G2D+7XOJ63BZQZv7hrpz
Ft/0iZaMdCDsI23zydSHpBrlz817bXYRsY5PvJ+UrhLyW3JlQL78cdiSNgcXYeZo
x2bP9ZYMDpluWKbvjYsWVtmgLedWlZxqEED5iPtg+Auf1KPfHWMYy5QhFlI3PIm/
qZmadTiPO0wM4upgDgzaLJFeRPotLhijXb9KjcyMt/XM2CkqAe2J7Kp+L22JuADX
23EVGON3oe0YdKNuwAZKYARzwm7Sp9rW8CMQDwUdhF32KYeVaTsLH7zbnr3UY8bV
8P8DXoy4qAHrdC6bIgKFrDRGdvlnLTADnvfag5SkLg0c02caXELKPkL6PIW19y4x
H8TiwCxZ3YfObvkSSJrwdt6rtU/ihyEsYlJjwWRPDKeAoGNYksVhf/hE1XVUUp+u
zQYNzFLBvOhwktTtkgLUd9txsiOKZ3oX3M4wgcTVgrUyaSWK6L4o55rKUuw8fckl
UhvTGAfz6zwT5L5LYSbS
=O7pB
-----END PGP SIGNATURE-----

--FgGrGGnVwgDwVIsMjl488jGSWOoc2V9J5--
