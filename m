Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH] batman-adv: Use wifi rx/tx as fallback throughput
Date: Mon, 10 Jun 2019 11:31:48 +0800
Message-ID: <4907494.lMUJSmCnaO@rousseau>
In-Reply-To: <accc8852-ded3-188b-b72e-313d1b462d18@measite.de>
References: <20190609101922.2366-1-treffer@measite.de>
 <3224708.U1DPrJmi8S@rousseau>
 <accc8852-ded3-188b-b72e-313d1b462d18@measite.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4743461.LzJaxbTVtE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart4743461.LzJaxbTVtE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, 9 June 2019 20:45:06 HKT Ren=E9 Treffer wrote:
> I am testing this on devices with ath9k (2.4GHz) and ath10k (5GHz), so I
> was looking at the estimates I get from ath9k. Here is a dump from my
>=20
> home network on 2.4GHz/ath9k and what rx/3 would give us:
> > signal  tx     rx     expect  tx/3    min(tx/3,(rx+tx)/2/3)
> > -77     13.0   43.3   6.682   4.333
> > -57     130.0  117.0  44.677  43.333  41.166
> > -53     117.0  130.0  42.388  39.0
> > -82     43.3   6.5    13.366  14.433  8.3      (!!!)
> > -63     52.0   86.7   26.733  17.333
> > -58     130.0  173.3  29.21   43.333            !!!
> > -82     6.5    43.3   2.197   2.166
> > -48     104.0  65.0   40.191  34.666  28.166
> > -69     57.8   13.0   20.49   19.266  11.8
> > -58     86.7   52.0   33.507  28.9    23.116
> > -58     52.0   1.0    37.994  17.333  8.833
> > -56     115.6  144.4  29.21   38.533            !!!


To confirm my understanding: What this table shows are raw tx/rx link estim=
ated=20
values ? None of these numbers compares to Minstrel HT expected throughput =
or=20
actual throughput ?


> Cases where the rx/tx estimate would be higher are marked with !!!.

I also don't quite understand what the '!!!' thing is trying to indicate. W=
hat=20
is being compared ? But it may be due to my misunderstandings above.=20

In my small test setup with one ath10k device meshing with ath9k over 2.4GH=
z,=20
your tx / 3 formula seems to be quite accurate (had removed the rx part).=20

# batctl o (your magic formula)
* ac:86:74:00:38:06    0.930s (       45.7)  ac:86:74:00:38:06 [    mesh24]

# batctl tp ac:86:74:00:38:06 (actual throughput)
Test duration 10440ms.
Sent 58393512 Bytes.
Throughput: 5.33 MB/s (44.75 Mbps)

What would be interesting is how the numbers produced by 'tx / 3' compare t=
o=20
either the actual throughput (can easily be tested with the throughput mete=
r)=20
or Minstrel expected throughput.=20


> Why bother and look at rx at all? Asymmetric routing should already
> work. I was bit concerned about highly asymmetric links, especially
> those where the path back might not work. It might not be worth it though.

Generally, the return path might be entirely different. Batman-adv does not=
=20
enforce or even endorse symetric paths. If there is better path for the ret=
urn=20
route, batman-adv will choose the better path based on tx from the sender a=
nd=20
if only one return path exists, we don't care anyway ..

Cheers,
Marek

--nextPart4743461.LzJaxbTVtE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAlz9zyQACgkQU1VOj+62
HMARWAf/Vu6xQeXiQVmH3c4NMilFan+ZoBEpsChJlH4wz/rh8M7BtuGn05Stj8tr
i9hEZXZ+vUpZbds13yIgNImWuaovif1705yDpIdqhyE/wVDiED6c5xF5qgYjdRQV
zAwLXnbrGTbXmZ3WpOgPIC9Pc5vWNVj+rT3cZhAmFnXWzskuE3K2hdKEmCY0w7G/
MfyhXtTT6EnUl5ILaSFi15O+SO9qr9kSsZPElvtWbixMNowHvspQnGCMegHpoAEc
l5r1Z9GSij40YdjsXtSj5cEkFZP2gO0qNloQgiDJ/wexKT08MbC3hi1zXZ2Fj36X
MS+5U2cXFdu8MVscy1RGrmL2XZ1xdw==
=mmhe
-----END PGP SIGNATURE-----

--nextPart4743461.LzJaxbTVtE--



