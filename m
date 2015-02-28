Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 28 Feb 2015 23:36:31 +0100
Message-ID: <3417561.ndC5tlHciH@prime>
In-Reply-To: <mct705$mdf$1@ger.gmane.org>
References: <1424719130-2661-1-git-send-email-sven@narfation.org>
 <mct705$mdf$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1957688.LFE4xPB5sW";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Drop capabilities when not needed
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


--nextPart1957688.LFE4xPB5sW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Saturday 28 February 2015 21:04:19 MK wrote:
> Hi!
> 
> Thanks for the patch. Setup seems to be still working. How can I verify that
> privileges really dropped?
> 
> There are further questions:
> 
> Is _read_ access for the alfred user (resp. group) sufficient in
> /sys/kernel/debug/batman_adv/* ?
> Or is write access on the socket file in this directory mandatory for full
> functionality?

Read functionality should be enough. We are only reading the originator table 
and (global) translation table.

Cheers,
    Simon

--nextPart1957688.LFE4xPB5sW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlTyQvQACgkQrzg/fFk7axZIAgCfcSSx7fzxUXgdpNJLNbORBYu7
CJgAn2x8/PXTLhlakgNElKtuqU8rbayn
=AEv+
-----END PGP SIGNATURE-----

--nextPart1957688.LFE4xPB5sW--

