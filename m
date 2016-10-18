Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 14:47:40 +0200
Message-ID: <3798601.mki1AaTVKQ@bentobox>
In-Reply-To: <1469615468-9261-1-git-send-email-sven@narfation.org>
References: <1469615468-9261-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15712797.k2AkgDobz1";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [1/2] batman-adv: Use proper name for fragments
	list head
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

--nextPart15712797.k2AkgDobz1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 27. Juli 2016 12:31:07 CEST Sven Eckelmann wrote:
> The batman-adv codebase is using "list" for the list node (prev/next) and
> <list content descriptor>+"_list" for the head of a list. Not using this
> naming scheme can up in confusions because list_head is used for both the
> head of the list and the list node (prev/next) in each item of the list.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/fragmentation.c | 14 +++++++-------
>  net/batman-adv/fragmentation.h |  2 +-
>  net/batman-adv/originator.c    |  2 +-
>  net/batman-adv/types.h         |  6 +++---
>  4 files changed, 12 insertions(+), 12 deletions(-)

Applied in dbc6c543fb9369def16146cf0278b3be0f524448 [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/dbc6c543fb9369def16146cf0278b3be0f524448
--nextPart15712797.k2AkgDobz1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBhnsAAoJEF2HCgfBJntG9jsQAL+a2ePDwjAZCzwIFimzJCsY
GRA9lZVoMn7+IiGLPyFWFael9ydAevJLaSgWpGtmxSDmzoCHiZFlwx8CAuz64NzQ
EvG/zphN8RSNSMuBq0i0GV+R+i64p8pzEL2/4b0CACIGESdti/zmrMeyQSrVZBBo
2fWgE9MAM6bxOT+3PVCZC4VrvoHeC4oCN2Ne8L3AOrf2oUd7ytEtNDmjG7gtNYZ+
QN+X5dQU/zzxVvjjze9SzUByts8DsTPxrTZWIsnUd+lfndkahHZz6fbPhPyz5DVD
bm4pWJRb3/eLVxqe5CNmmdE63gwayX6z2uIR1ZbzqyR27exKX+R+P75AUhjYrkYF
MMDT6F8PMRoarFnOFlWaD3x2YsRFlKN2ueBLqeuMwngm5DOUD6tWhWn4nlOPigd+
SrNoZgwpp2xr3e/Nf8aA7P1GlwIGCL/StiutLa1GhOSpTn4stFp2XcNqXVPBzz+b
3AGD0vdoAFZYRYkkwvCU5cGteYRhuOaNnq0JiwZOkNBA01woriTm05CTz9cBFq5/
kA9sY/xz35YTVJS1GlyKXtV/0br3AKrdV1G2G47kugfRg/Yl+ete4wYKVTQqt01F
Qvpxb/YpPchVxRYYZRanqxObAwhu/bCICiSrvOqZ2z+9ThYKiBuq/Xv9KvaUGg9x
8EZ0W4GNmGy2wh4cAjyT
=Qres
-----END PGP SIGNATURE-----

--nextPart15712797.k2AkgDobz1--

