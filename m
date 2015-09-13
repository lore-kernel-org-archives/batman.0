Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 13 Sep 2015 18:20:12 +0800
Message-ID: <2662065.oem7IOexWu@voltaire>
In-Reply-To: <1441987453-5553-1-git-send-email-sw@simonwunderlich.de>
References: <1441987453-5553-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3030996.fV2LtNDfqc";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint v2] batman-adv: lock crc access in
	bridge loop avoidance
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


--nextPart3030996.fV2LtNDfqc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, September 11, 2015 18:04:13 Simon Wunderlich wrote:
> We have found some networks in which nodes were constantly requesting
> other nodes BLA claim tables to synchronize, just to ask for that again
> once completed. The reason was that the crc checksum of the asked nodes
> were out of sync due to missing locking and multiple writes to the same
> crc checksum when adding/removing entries. Therefore the asked nodes
> constantly reported the wrong crc, which caused repeating requests.
> 
> To avoid multiple functions changing a backbone gateways crc entry at
> the same time, lock it using a spinlock.
> 
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> Tested-by: Alfons Name <AlfonsName@web.de>
> ---
> Changes to PATCH-maint:
>  * fix spin_lock -> spin_unlock in claim table printing (thanks Petr)
> ---
>  net/batman-adv/bridge_loop_avoidance.c | 35
> +++++++++++++++++++++++++++++-----
> net/batman-adv/types.h                 |  2 ++
>  2 files changed, 32 insertions(+), 5 deletions(-)

Applied in revision b307e72.

Thanks,
Marek

--nextPart3030996.fV2LtNDfqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV9U3cAAoJEFNVTo/uthzA74MH/1bq/h6Ji3w6egQjDzvHSEgk
RstAuabfYUeWqETl9U4rulpCgUvP/lUHUct1JXbaD45rXWp9jO2byO4FqgWXw8ec
iyYyRg1hUzjDEkprVWyjyzraYYyqjB83QNfedWWamB96amIxGlfNmgWJf7BPt1fO
R0oyeFaXrpfTksUzzaethKvZmaOqVwbgLrxaO6tdrybTSwMRbTB2vwBM1mRvlRGU
nbpT/GPOf0/nnLID/XrSUf+JpyjHz9+t9kB29TXgmXgBO/zHDrjdkDOoUJulwdJ5
qa0x36PQrPqhUhxIOPH7bVUgQMiciZxVMzACcw64mE539Ww0UYcF9KyIamy3ElI=
=h34I
-----END PGP SIGNATURE-----

--nextPart3030996.fV2LtNDfqc--

