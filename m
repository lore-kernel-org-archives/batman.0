Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 30 Sep 2013 21:04:21 +0800
Message-ID: <2191431.IgCfgzuJ3T@diderot>
In-Reply-To: <e1d5e2f6144c8c36bf80e6f1a6ffc7a4d4c22544.1380297720.git.mschiffer@universe-factory.net>
References: <2446824.BO6cEXVXT6@diderot>
 <e1d5e2f6144c8c36bf80e6f1a6ffc7a4d4c22544.1380297720.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3838411.rEeasRRrhQ";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 maint] batman-adv: set up network
	coding packet handlers during module init
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


--nextPart3838411.rEeasRRrhQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 27 September 2013 18:03:39 Matthias Schiffer wrote:
> batman-adv saves its table of packet handlers as a global state, so handlers
> must be set up only once (and setting them up a second time will fail).
> 
> The recently-added network coding support tries to set up its handler each
> time a new softif is registered, which obviously fails when more that one
> softif is used (and in consequence, the softif creation fails).
> 
> Fix this by splitting up batadv_nc_init into batadv_nc_init (which is called
> only once) and batadv_nc_mesh_init (which is called for each softif); in
> addition batadv_nc_free is renamed to batadv_nc_mesh_free to keep naming
> consistent.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
> v3: moved things around as Marek suggested
> 
>  main.c           |  5 +++--
>  network-coding.c | 28 ++++++++++++++++++----------
>  network-coding.h | 14 ++++++++++----
>  3 files changed, 31 insertions(+), 16 deletions(-)

Applied in revision 586cf84.

Thanks,
Marek

--nextPart3838411.rEeasRRrhQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQEcBAABAgAGBQJSSXbZAAoJEFNVTo/uthzArHYIAKZIZP1n0P22mJ/QW3s69PDA
82uBJnIfBweMDQo3AcRYy8z6LcZSL04KU7sjtxulXLVcvZHTK0FV8jBLGXJ3GFGU
YSE+gP8V5fiVCfHaPnPuqKjaQK6LRLplseRTFt4vHYAzd2hzDKXi+/x6PrLeQPM6
RZxFIrhD122qS1OJL3soP1wvgP51CeaP2isWyIp2gQw2khl1La/r8UKopzdR82jW
xLTTjSQMRXLV4hI3rGXlNxQxvlO2BT+Mx8zksNSF+anZqD8NdyDwhTSr4XZFJx4E
lUxgIuU0rUJ0p/IpGKcLPLWTQAscbrlp3v91QKNqtaJmXE+ocYKxnzoPnPXZP9Y=
=pItT
-----END PGP SIGNATURE-----

--nextPart3838411.rEeasRRrhQ--

