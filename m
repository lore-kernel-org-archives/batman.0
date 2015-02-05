Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 05 Feb 2015 13:29:23 +0100
Message-ID: <1928822.H2LaTFtYz1@prime>
In-Reply-To: <matu4b$lak$1@ger.gmane.org>
References: <matu4b$lak$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15305632.BN0QPXDVun";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] running alfred as unprivileged user
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
Cc: MK <mailing.m1@kkk-web.de>


--nextPart15305632.BN0QPXDVun
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Hi Martin,

On Wednesday 04 February 2015 21:06:33 MK wrote:
> Hi list!
> 
> Alfred daemon runs as user root in our current setup on the gateway.
> 
> Regarding the faulty buffer size checks and improper use of strcpy in recent
> history of this software this seems to be a very bad idea.

that's a good point.
> 
> What are the requirements for the user running alfred? Which elevated
> privileges does alfred really need? Is it possible to drop the privileges
> after setting up the interface bindings?

What spontaneously comes to my mind would be:

 * network socket to send/receive UDP packets
 * unix socket to talk to clients (but that may be changed by using a different 
path)
 * access to debugfs to get batman information

Patches are very welcome to implement dropping privileges.

Thanks,
    Simon
--nextPart15305632.BN0QPXDVun
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlTTYiYACgkQrzg/fFk7axb7lgCeM6nxLZCI1yf2WBm+Ui5DjM07
xhYAoIue4zckIOHiLMQ1NV0/my2wNmob
=qEA6
-----END PGP SIGNATURE-----

--nextPart15305632.BN0QPXDVun--

