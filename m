Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 11 Mar 2015 13:08:22 +0100
Message-ID: <2170540.kuiCrXiOC1@prime>
In-Reply-To: <1425768078-15380-1-git-send-email-sven@narfation.org>
References: <1425768078-15380-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3816288.MWVTJ90K30";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] alfred: Update version when adding
	data to dataset
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
Cc: Sven Eckelmann <sven@narfation.org>


--nextPart3816288.MWVTJ90K30
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Saturday 07 March 2015 23:41:17 Sven Eckelmann wrote:
> The dataset stores the source and the alfred_tlv of the send data next to
> the actual data buffer. The source and alfred_tlv::type was used to find an
> entry in the dataset hashtable when reading/updating the buffer. The
> alfred_tlv::length is always updated when the size of the associated buffer
> gets modified.
> 
> But the alfred_tlv::version is only written when receiving the first data
> for a dataset. But this initial (maybe outdated) version is always
> propagated when a client asks over the unix socket or the dataset is
> exchanged between alfred servers. This has to also be updated when new data
> is added to the dataset to avoid clients to interpret the data using the
> wrong data format version.
> 

Applied in revision 17d1102.

Thanks!
    Simon
--nextPart3816288.MWVTJ90K30
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlUAMDYACgkQrzg/fFk7axYf9wCgyebtMDEhWb1n5WhgJSCHJJ7y
MBQAoLZtsng/M/kcfPrdHR8tJLyMHmg1
=u0rn
-----END PGP SIGNATURE-----

--nextPart3816288.MWVTJ90K30--

