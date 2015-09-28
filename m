Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 29 Sep 2015 01:24:39 +0200
Message-ID: <10386832.M3RZMRiWCT@prime>
In-Reply-To: <5609ACD4.3050701@gmail.com>
References: <5609712B.6020308@gmail.com> <1942201.vOz91KHqBg@prime>
 <5609ACD4.3050701@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13367645.jIbuAHADE0";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Suggestions to get extended jsondoc alfred output
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

--nextPart13367645.jIbuAHADE0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday 28 September 2015 23:10:44 Germano Massullo wrote:
> Il 28/09/2015 19:35, Simon Wunderlich ha scritto:
> >> # batadv-vis --format=jsondoc
> >> and I got [5]
> > 
> > This looks kind of incomplete - there are no neighbor information at all.
> 
> I would like to debug this thing. Virtual machines firewall have been
> deactivated. I don't understand why
> # alfred -r 65
> returns a correct output about the three nodes and instead the jsondoc
> output only mentions one node...

batadv-vis is also a daemon which must run in background to collect data from 
batman-adv and push it (periodically) into alfred. Maybe you are not running 
it but only used the client part to query?

Cheers,
     Simon
--nextPart13367645.jIbuAHADE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlYJzDcACgkQrzg/fFk7axbIBQCdH5C1YdasMNqKT29k0SBj4pEs
mPEAoOjEys0edSKdQMqjaCYwLsd2wDrJ
=nTT+
-----END PGP SIGNATURE-----

--nextPart13367645.jIbuAHADE0--

