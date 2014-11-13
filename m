Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 13 Nov 2014 11:29:16 +0100
Message-ID: <8586269.W9iEt8U751@prime>
In-Reply-To: <1415800470-10114-1-git-send-email-sven@open-mesh.com>
References: <1415800470-10114-1-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4973192.d3TT15ddEg";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] alfred: Add support for multiple
	interfaces per master
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
Cc: Sven Eckelmann <sven@open-mesh.com>


--nextPart4973192.d3TT15ddEg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Wednesday 12 November 2014 14:54:29 Sven Eckelmann wrote:
> It may required in some situations that all alfred master servers are
> potentially connected to the same backbone network but cannot see each other
> through the mesh. The data may still be exchanged and thus a master
> instance must listen for requests on the mesh and synchronize data over the
> backbone network.
> 
> The limitation that data can only be synchronized over one master hop and
> not more still holds true. Also alfred servers in slave mode are not
> allowed to operate on multiple interfaces. This is especially important
> when switching from master to slave mode because this can fail now when
> multiple interfaces are configured.
> 
> Signed-off-by: Sven Eckelmann <sven@open-mesh.com>

Series applied in a822b86 and eb8b960.

Thank you!!
    Simon
--nextPart4973192.d3TT15ddEg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlRkiAAACgkQrzg/fFk7axZwiwCgmerIu5foAVfHiJ+xoBDnW6zA
uncAoMxHt8xy78bVTI4UGIm5ue4pIL0k
=rCTi
-----END PGP SIGNATURE-----

--nextPart4973192.d3TT15ddEg--

