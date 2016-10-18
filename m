Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 14:24:59 +0200
Message-ID: <3320851.xE1M4ho6LC@bentobox>
In-Reply-To: <1468961051-6447-1-git-send-email-sven@narfation.org>
References: <1468961051-6447-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1973900.7VkquaPvkm";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [1/4] batctl: Replace list implementation with
	linux-like-list
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

--nextPart1973900.7VkquaPvkm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 19. Juli 2016 22:44:08 CEST Sven Eckelmann wrote:
> The list-batman implementation of linked lists has an interface which tries
> to resample the linux double linked list implementation but in reality is
> incompatible. This resulted in code which moves most of the pointer
> arithmetic back to the actual code. This is rather unfortunate because this
> abstraction should reduce the pointer arithmetic and not increase it.
> 
> Also the incompatibilities between the list implementation used in
> batman-adv and the one used by batctl made coding features in both
> components error prone because each component required a slightly different
> implementation for the same list manipulation.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  Makefile      |   1 -
>  bisect_iv.c   |  40 ++-
>  bisect_iv.h   |  10 +-
>  list-batman.c | 123 ---------
>  list-batman.h | 120 ---------
>  list.h        | 834
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ tcpdump.c     | 
>  7 +-
>  tcpdump.h     |   2 +-
>  8 files changed, 860 insertions(+), 277 deletions(-)
>  delete mode 100644 list-batman.c
>  delete mode 100644 list-batman.h
>  create mode 100644 list.h

Applied in 315b3b0fac147b9d8dc8f83a6409fde91eca683a [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batctl.git/commit/315b3b0fac147b9d8dc8f83a6409fde91eca683a
--nextPart1973900.7VkquaPvkm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBhSbAAoJEF2HCgfBJntGaY8P/RBJUC0eSWZN4yLp7G5pgCYL
NzZQ1brQWzzckZeis3FkFNzpU4D1AjtKP8MOdKt6jQJUrJjAUV/xKHzIMYgka12I
yYMgWoXQiU1DVAnD1XyEULpaOF6O7/F6xN15DpWKOmOpJO7bXLlyPAKRAWVG903N
ozB5CGb/o1LV83jxw0h4OViuAIRHLpIEvSES66n1D5noAI05tIND48TiASe5dPBY
RtiPJ81MLxgLl15pmIaNSX0FYty4pq2HwJ0VQa1agudmvWpUu/NzGz0HZO2FN7Ra
ecktlZVFrOjapnhrh8bY2n+W41VLf+x8b8lDPIYNPK+8I+D8c0+ks/vml2XqwAfn
tFZx4A+BZNaV2cvwaqMvabD/ZG64v2svaZyFr/6nDzl2+ELE/hRsUuEsI+9IhGEX
ikMw7L3WwGdtwqUNKallBY4iRIz6nIfw+JZofXg/FdduaN7yT/4gNMiu/7oBuc4S
vHomY0ekYncdlMqlphkb422iZWMMzoZy7R+pPdlwoFOoJC0L3tMT+dy6x1CtObi4
mFiiBw1kJtAsGCu5fd8LsYEItDmxXWRYaBqMpr5F1/A2osIXyfQE+6fA18VT1yLY
2MjN4Uc7SXos8M4kM0ZDAfCJ1RdP8EU2hPeGGJA5RixsLZ9NKCBE+EpJtf0eP1mX
l3RyWj0pkXPyRw3RDOAZ
=SjuK
-----END PGP SIGNATURE-----

--nextPart1973900.7VkquaPvkm--

