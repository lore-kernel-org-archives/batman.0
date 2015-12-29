Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 29 Dec 2015 20:27:46 +0800
Message-ID: <3337804.lPbGQ9XPRB@voltaire>
In-Reply-To: <1450598643-7185-1-git-send-email-sven@narfation.org>
References: <1450598643-7185-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3368770.9yJo1j2Y9j";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Add lockdep assert for
	container_list_lock
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

--nextPart3368770.9yJo1j2Y9j
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, December 20, 2015 09:04:03 Sven Eckelmann wrote:
> The batadv_tvlv_container* functions state in their kernel-doc that they
> require tvlv.container_list_lock. Add an assert to automatically detect
> when this might have been ignored by the caller.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2: remove this from the kref patchset and instead submit it as standalone
> patch net/batman-adv/main.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied in revision 5f01697.

Thanks,
Marek

--nextPart3368770.9yJo1j2Y9j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWgnxCAAoJEFNVTo/uthzA/Z4IAKm7EENDMzu3CE2vTyIHtd0e
OJJPzEQz2K9y6hkjOOdsBlyGauuy+MyyT1tVhtQvDaP1p2o1xK9FKk6UzE2LFpz3
MbmBczCvyS0JCcJEG90swbiHjcPQeLYC1FLyxln0pjvIEx/j/iTW4b0Cx03fXZLs
ublKbtsus6gDC6QX5lkFJsOPuxel31N1e7GYCvp2+FE4KvLz/s7s1vnIn380lSSq
dxK9Vyl9xoGSZ1T9BiwzJgeqen1CpZc3eJrscnxXkjJSQhAWOLdoZsQiiRBwkeCd
gV3+njXpre7LjkmJeslQ6rIQStVVRXdzPKRLgV4PhyE/1gMDvcSMky6hAcZOfiM=
=hmy5
-----END PGP SIGNATURE-----

--nextPart3368770.9yJo1j2Y9j--

