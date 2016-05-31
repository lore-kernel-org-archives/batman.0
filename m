Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 31 May 2016 20:25:16 +0200
Message-ID: <1488113.KCrKATXhSP@bentobox>
In-Reply-To: <20160525152736.9031-2-a@unstable.cc>
References: <20160525152736.9031-1-a@unstable.cc>
 <20160525152736.9031-2-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3105815.hTs3FIm0j7";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 1/6] batman-adv: split routing API
	data structure in subobjects
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart3105815.hTs3FIm0j7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 25 May 2016 23:27:31 Antonio Quartulli wrote:
> The routing API data structure contains several function
> pointers that can easily be grouped together based on the
> component they work with.
> 
> Split the API in subobjects in order to improve definition readability.
> 
> At the same time, remove the "bat_" prefix from the API object and
> its fields names. These are batman-adv private structs and there is no
> need to always prepend such prefix, which only makes function invocations
> much much longer.
> 
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> ---

My eyes don't want to read diffs anymore which only removes bat_ and replaces
a "_" with a ".". I want more interesting stuff happening in my
movies^Wpatches :)

Reviewed-by: Sven Eckelmann <sven@narfation.org>



Btw. this is rather unrelated to your patch. But the kerneldoc contains
"(optional)" statements. Following functions don't have it (and didn't have it
before your patch):

 * iface.activate
 * neigh.hardif_init
 * orig.free
 * orig.add_if
 * orig.del_if

Kind regards,
	Sven
--nextPart3105815.hTs3FIm0j7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXTdcMAAoJEF2HCgfBJntGJaYQANCP2i7+CSCnbWslOeSYqTql
mfJmTusEGVIEY+khXeXbv9KVBJ+ll21WidmwFFMO8hiPyk0sTN0RyzunRXdKTYpE
W1s9YxNw8/4n4gtSSWR7M6snXaHPD5ql5AblSNXYAxVdCK2vKJVjWxrSikCP7XMm
MNniO1ZoJ5aYmxVuOyOlcBpC7kn+L5vB9JvlTNsnyK74klBupdCseq4sHcdyyFVT
ZLYv96NN2YVVopzdkgzrZUZ3EZikMgbWTQKRjti570lDYLOQ3G1VauAOt+gKMdBN
Iy6TfXhCQN/WCQVNMMY/jyq6gwQxwpOELBJeQyHtnLfDSNbn5IKHdGH003Hjg31w
iO4mBx6W7UuWVD7yTxdz4HYb2vv7TOCQZBcTkW9zRcydPERJmRYHbtqa5CMQRsZk
UtyLt0581VrBLtJ7cAq+ZSqwoKpGAlPmYcg0dxsVy85i95JtYHoa0o+4xV2/gZih
x7bk6wpr1yfyrOPitqUlTmYt72wstT4mgGbh0nFL1PuGP2k/26nN/pwATVf8FkmL
wlUsmL6Lxhl8sPEJ+MS675muSbuJCo9IIa1WUWCw9hqbH+OGNf6Ll0mitw8O6lk3
cvPd61Y0jEAEsReTbJ3Eq/9mrpRMmr+6P/x2QmhyR2aza8AEKIRxttD/ihQjU4as
X8vrRR3wNnDYhL8XJe9M
=GTD6
-----END PGP SIGNATURE-----

--nextPart3105815.hTs3FIm0j7--

