Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 19 Mar 2015 18:21:21 +0100
Message-ID: <2763768.JyN6RsZky9@prime>
In-Reply-To: <1426579875-28365-1-git-send-email-anatoliy.lapitskiy@gmail.com>
References: <1426579875-28365-1-git-send-email-anatoliy.lapitskiy@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4237813.86upcqzjBD";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5] alfred: Add "--update-command"
	parameter
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


--nextPart4237813.86upcqzjBD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday 17 March 2015 10:11:15 Anatoliy Lapitskiy wrote:
> The "--update-command" parameter is created for adding a hook to run when
> new information is received.
> 
> At the moment "alfred-facters" are run by cron once per every 5 minutes.
> For some tasks (like sharing dhcp leases) it can be too slow.
> 
> Signed-off-by: Anatoliy Lapitskiy <anatoliy.lapitskiy@gmail.com>

Applied in revision 4ae4c74.

Thanks a lot for your contribution and the fast reworks, and thanks to Sven 
for the review!!
    Simon
--nextPart4237813.86upcqzjBD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlULBZEACgkQrzg/fFk7axaD9ACfVGg0hIgEPfa/VAJl8cO3UJ7T
fysAmwVcjkJLTWg+p3fuNrs/cd0NKwfH
=QHRI
-----END PGP SIGNATURE-----

--nextPart4237813.86upcqzjBD--

