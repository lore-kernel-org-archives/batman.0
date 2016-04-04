Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 04 Apr 2016 17:48:33 +0200
Message-ID: <1620382.1TbDfDECNB@prime>
In-Reply-To: <1459704107-11844-1-git-send-email-sven@narfation.org>
References: <1459704107-11844-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4695838.Ppx7hk4gtn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Don't accept user defined
	dataset source address in slave mode
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

--nextPart4695838.Ppx7hk4gtn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Sunday 03 April 2016 19:21:47 Sven Eckelmann wrote:
> The dataset source is used by master servers to identify if it has to be
> forwarded to other master servers. The data::source of an incoming UDP
> push_data is checked and compared against the address of the node sending
> the dataset. If both are same then the dataset is marked as
> SOURCE_FIRST_HAND. Otherwise it is already synced dataset (SOURCE_SYNCED).
> Only datasets marked as SOURCE_FIRST_HAND or SOURCE_LOCAL will be forwarded
> by master servers.
> 
> Allowing slave servers to accept push_data packets via unix socket with a
> modified data::source would break the synchronization of datasets between
> the master servers. The slave server would forward data to the master
> server as always but the master would now mark the packet as SOURCE_SYNCED.
> The synchronization process would end here. Parts of the alfred servers
> would therefore have access to the dataset and some not.
> 
> Instead drop the incoming push_data with a set data::source on the slave.
> No alfred server will have the dataset and the stable inconsistency is
> avoided.
> 
> Fixes: 58e109973bbe ("alfred: Allow setting the source mac via unix sock")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Depends on the patch https://patchwork.open-mesh.org/patch/15954/
> ---
>  unix_sock.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Applied in revision 7782e61.

Thanks!
     Simon
--nextPart4695838.Ppx7hk4gtn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXAozRAAoJEKEr45hCkp6h9QAQAMnZdcRqveniYy5k5XV1Ol9/
prFI+kO1T70rXV6zIYtC/r9QdgdOzqWDAjSGD1SCfs9JhzPqlIGqtGqKnGCRQqfE
7fU54dJJiIrZizQQAMOnGh67A5Nqt66EbFVwra8th0c8NYMgxiYuzDfJLgB4hune
EhXq8UojkF3d7FAGnSWYO1gmyfsAvnCXW84dxh4yWkpbgMmAWAqDWmFacBCRgeY3
QNpbG8uyQd2/+oS/9kPM/NMqwvYrkHfyowJShitpu31dmd9hftUnOncJuKcDyorY
39eGulTX0qoOFjYpk3AZ0Daqk4dp/kI0a4L43tIRE6Uz8J8pGvGiXT4u/ZQpjiIl
cmKx8WJPShb/4gGigG6XpOmTSgNw/4RxbNwMRWosSCabx3zQ3Krb+e/Y1oCww7kr
QGInhqMKRc69TSizvL4gYV4oA6tIKccde2RvhGTVeZ1Gi22L5v7fmgLfwHu2soLO
Wly8AENI4Bea7cFTibx2uvoRgr6ljV1fFxmb63olOOY9PbixtyNMTMBvPjX8VZU1
CvWish+5W1UjP+Vcu+8WRShSq647tyUe4HRdFeVHGLkyzl4qUVXnkgkKCgkRVtKb
HOytAJnZZa5Oa7DgUddIGPFed7WRAGyonFxCCrYXH9RMi/9UsdqxxDh7y8CJAJSP
ht3x46F8exhXWruFTn54
=jUim
-----END PGP SIGNATURE-----

--nextPart4695838.Ppx7hk4gtn--

