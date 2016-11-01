Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 Nov 2016 08:30:09 +0100
Message-ID: <11199075.qxFJ5G89LN@bentobox>
In-Reply-To: <20161029080328.26584-2-sven@narfation.org>
References: <20161029080328.26584-2-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1882604.hFivVFfKiA";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [2/3] batman-adv: genetlink: statically
	initialize families
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

--nextPart1882604.hFivVFfKiA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 29. Oktober 2016 10:03:27 CET Sven Eckelmann wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Instead of providing macros/inline functions to initialize
> the families, make all users initialize them statically and
> get rid of the macros.
> 
> This reduces the kernel code size by about 1.6k on x86-64
> (with allyesconfig).
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> [sven@narfation.org: adjust compat code]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Patch already in net-next
> 
>  compat-include/net/genetlink.h | 21 ++-------------------
>  net/batman-adv/netlink.c       | 25 +++++++++++++++----------
>  2 files changed, 17 insertions(+), 29 deletions(-)

Applied in f0f80621705b629aa04ca90411633b9b3dd3c61f [1].

Kind regards,
        Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/f0f80621705b629aa04ca90411633b9b3dd3c61f

--nextPart1882604.hFivVFfKiA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYGESBAAoJEF2HCgfBJntG1tIP/1gXvqNFqrQPIW9WwParSuFL
n7VPCEnk8gMVCGNO4/LRFsy4eCNl9bJniDKM/0jLrBItXqZUE4DrJMTWlBMF5xXE
nfYBX1yvgYqvI2WQ8RItOAu8DsDhy6Fdp4ejEhoXpzvIi/GsWbfvd5G6it9veJUI
9c2jgl1OG3blMAK0c0wxyfhhC0zO1ctvOkQEgVQDFx2KuEaTQo3yK4EDghU3GS1a
gJjv3nV6SVbSYKWyk6uHBd4kq97u+XQVYsUTxrmjON6TTzGP/chGt42MepZwyAZM
GE7I68uLMusR3utiQguluXRK+CdeQ5Vv0Nh41LAbZxw6Yi3zqC/jDtNXgD5l45ub
P8Ekk+6dB0lz8Yk99fQ/FpyKUkEiHZtffrkE/li+BjYzHiSiLXlZKdm15rfTTNwm
IFZQPNkkDOSpEIMEi9C30UGa8lTt6tgiiOhYm15H34RmV9kgJZKkKEfOuNKFeih6
5ZE/0pWi1+cChuly8iQ3QLb23q50OPmbuLzWvmewcZHxkdNW58G8nsUIgWmmpnbm
Ieoi4B/a6Dng8pkWB4uUsjFbg1swoEsyRlVtXM97Bi4qnfGm4MGHtwBbbMaJlMso
cQeIDDUAWGcuDpaepaNntVwhN7+9FqyO5RdyFUT54uxb8Cry334oq0ExsJASQVYG
kF3xZP6EawiSYCHE+RzT
=ALqR
-----END PGP SIGNATURE-----

--nextPart1882604.hFivVFfKiA--

