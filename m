Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 20 May 2016 16:52:22 +0800
Message-ID: <3255416.Qqq4ERlxMC@voltaire>
In-Reply-To: <1463303266-25979-1-git-send-email-sven@narfation.org>
References: <1463303266-25979-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1779818.Lb0RQ9P6qK";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 1/6] batman-adv: Include main.h in all
	files
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

--nextPart1779818.Lb0RQ9P6qK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, May 15, 2016 11:07:41 Sven Eckelmann wrote:
> main.h includes statements which (re)define preprocessor variables which
> influence the compiled code. This makes it necessary to include it in all
> files. For example, it redefines pr_fmt used to the module as prefix for
> each pr_* message.
> 
> Reported-by: Antonio Quartulli <a@unstable.cc>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v3:
>  - no change
> v2:
>  - never existed
> ---
>  net/batman-adv/bat_algo.h  | 2 +-
>  net/batman-adv/bat_v_ogm.h | 4 ++--
>  net/batman-adv/netlink.h   | 2 ++
>  3 files changed, 5 insertions(+), 3 deletions(-)

Applied in revision 97d45f9.

Thanks,
Marek

--nextPart1779818.Lb0RQ9P6qK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXPtBGAAoJEFNVTo/uthzAYpQIAJRuy05hsuJ619WdZC3YPc2M
J3QsFw8cRxXENbenito3eJzZj0C3j2SYQ4x7HoQhCp8mpu3kT5G9K/lwvPhW0Knz
+y0dNgAvztzkklffok3GIn0RYHghOvfPaMyhDINjGbZmRYck1+xyjcI8eootYA5T
mmRtOgUETeCS9f895rsYxgMpvvJDiF8LWN56bmcT3EtDo5gC3PpNeei2ouCbCMcf
nFrLfMrSk3pFgAgIEX3PZ1JuiBcs2OSoPzMlJDwaADXUrfBnemjkS1OOUONhP26l
af/IX4tU4Cbuv+9h17hipGNy0fvLrzM7tNNNiFsszoPC6n6KQ0DqTOps8litSSI=
=YsX1
-----END PGP SIGNATURE-----

--nextPart1779818.Lb0RQ9P6qK--

