Return-Path: <antonio@meshcoding.com>
Message-ID: <53665FBE.1090009@meshcoding.com>
Date: Sun, 04 May 2014 17:41:50 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1399216953-10143-1-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1399216953-10143-1-git-send-email-antonio@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="leg69W4KKVAOEoOqmKejPTQNvm5RJDrk1"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 maint] batman-adv: fix TT VLAN
 inconsistency on VLAN re-add
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--leg69W4KKVAOEoOqmKejPTQNvm5RJDrk1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Please wait before reviewing this patch. I am performing some more
debugging on it and I think I found something else that might be wrong.

Cheers,

On 04/05/14 17:22, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
>=20
> When a VLAN interface (on top of batX) is removed and
> re-added within a short timeframe TT does not have enough
> time to properly cleanup. This creates an internal TT state
> mismatch as the newly created softif_vlan will be
> initialized from scratch with a TT client count of zero
> (even if TT entries for this VLAN still exist). The
> resulting TT messages are bogus due to the counter / tt
> client listing mismatch, thus creating inconsistencies on
> every node in the network
>=20
> To fix this issue destroy_vlan() has to not free the VLAN
> object immediately but it has to be kept alive until all the
> TT entries for this VLAN have been removed. destroy_vlan()
> still removes the sysfs folder so that the user has the
> feeling that everything went fine.
>=20
> If the same VLAN is re-added before the old object is free'd,
> then the latter is resurrected and re-used.
>=20
> Implement such behaviour by increasing the reference counter
> of a softif_vlan object every time a new local TT entry for
> such VLAN is created and remove the object from the list
> only when all the TT entries have been destroyed.
>=20
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>



--=20
Antonio Quartulli


--leg69W4KKVAOEoOqmKejPTQNvm5RJDrk1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTZl/GAAoJEEKTMo6mOh1VuX0P/iD7sbDJzYeEd4MB9aJct0u0
3CO+0s12NTqVa8ATJid42owPozIy9oKiUoxi/fFiGVY8cUh/F5X3UEfEvvdvr8Wy
riPQ8Mf3K5orZxXYOpvJs3jouN7xEof4jjk3NaT6BzaekDxC4f+cdG5GTnjahVMa
xXas6qfl8QGJCFXUXZk6nMvwpK+gt+/ug/TzHA0GQgtxAz2nShjIw9HPOUX/eQ8r
Snpr5K+hr94BCnZYc/UT5kSRMge2HpcCzVmK5aL1grEm3Gdlb6yLrZCRrL1DGmJF
t9U7N90xg0NSXu3ueIuYq/mYMMQ+Af1e6evNynYl6RE5lj5V+tvaeCyfvwKGBWHS
PunyI4Hh9y/Ma14UCYMQ25Gfn+x5kVGb//p9qc5qTodzjFCwaV3CPFhPpcawmFoT
wVOT2MzgRGkUrJYfTUR/apckqIJ7G9NWaA/Dah43M7/zhG1sXK/hE6fzyz5tAC1z
Eq2axetT1corbz+F/cHFn5Z/YhRcJsZzMkmlr6JmdmJfzwsOBUXnlcMp3fJ9OXug
2uJpxk/JhLfYpInW2m+zj5e4+KoC8eKs/Nq3IXbsHzlNM8rIsAzKR0xYpCSakn9l
s/W32OOh4Q3TH6GY7wV2uGH9Ik047yM3GfzpFmMrUFG5VyX8FloKqkqljcBHp9q1
snOMsbhXD9XZyHFW61M7
=FC0T
-----END PGP SIGNATURE-----

--leg69W4KKVAOEoOqmKejPTQNvm5RJDrk1--
