Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 06 Oct 2014 16:39:15 +0200
Message-ID: <1461254.rz0spk34lf@prime>
In-Reply-To: <54327CCB.20406@rund.freifunk.net>
References: <53FDD9D1.9080303@rund.freifunk.net>
 <54327CCB.20406@rund.freifunk.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10545294.mPgaGzErDQ";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] new alfred packet type *3* for solar tracer
	charging units
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart10545294.mPgaGzErDQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-15"

On Monday 06 October 2014 13:28:11 Ufo wrote:
> Am 27.08.14 15:14, schrieb Ufo:
> > best way for distributing the detailed data (about local sun impact..)
> > was alfred. we used nr. 160 but now simon choosed nr. 3 for that.
> 
> all the different values from solar units are now defined on our test
> systems. and meanwhile EP Solar China gave us some additional hints..
> 
> https://twitter.com/rundfreifunk/status/519083918436630528
> https://gitorious.org/tracertools/tracertools/source/4a6eb477a850e102f37b6f6
> 690b0797ec664f36d:tracerstat.c#L26
> 
> so the next step should be to include these into alfred?
We basically have two options here:

 * integrat the tracetools into the alfred repository, similar to vis and 
gpsd. Please note that the quality should also be similar and you or your 
colleagues should be able to maintain that code
 * keep the package external (e.g. on gitorious), then since we have an 
external software package now we should start using a number assignment table 
in wiki to show which software uses which packet type. We could then link from 
there your software

Any preferences? :)

Cheers,
     Simon
--nextPart10545294.mPgaGzErDQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlQyqZsACgkQrzg/fFk7axb7IACfYqQo+O0f8FUq6XM5fG1+IkT5
P6UAoNToa6VDhaspeW9N9K13tn3fYLa+
=jX5u
-----END PGP SIGNATURE-----

--nextPart10545294.mPgaGzErDQ--

