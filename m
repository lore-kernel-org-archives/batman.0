Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Nov 2013 11:35:45 +0800
Message-ID: <5949218.HgMH9zx54d@diderot>
In-Reply-To: <1384599832-3959-6-git-send-email-antonio@meshcoding.com>
References: <1384599832-3959-1-git-send-email-antonio@meshcoding.com>
 <1384599832-3959-6-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1773580.dC9kIpmkSf";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 5/6] batman-adv: create helper function
	to get AP isolation status
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart1773580.dC9kIpmkSf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 16 November 2013 12:03:51 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> The AP isolation status may be evaluated in different spots.
> Create an helper function to avoid code duplication.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  main.c              | 26 ++++++++++++++++++++++++++
>  main.h              |  1 +
>  translation-table.c | 13 +------------
>  3 files changed, 28 insertions(+), 12 deletions(-)

Applied in revision ceb002c.

Thanks,
Marek

--nextPart1773580.dC9kIpmkSf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSiDmSAAoJEFNVTo/uthzA8JsH/AmhV2dgqZ9F5jZPnvUn+bzD
1pNSqEzJu2GLXQw97rM4YXcbc8R6DVAPKvVSLjQrKs6geTlIHZDpsaXVd4YIKBai
e4aLLTGEWmKQ/SObiE0lhjQN/544vDYYNQ5TzTC4Jx+z97UdN1BW76McdyRjU32k
fuQ6Dma14giV7amvNIq+iEvAhYGo5kQBtwV+i0a/yb8FnHd49/MWeM6KqeCFOs2c
VidsjLpAAtrjw0QZaCYpOONeKXT06KzCVoRsjA+zYTxPBJgOqMetlICWk6VDwVrR
MNq2sRlNvOAec9uU2VP6Ia05wJv+iojF3XBw9EsO5EgpzqucXuLpKbs3aIzGQHc=
=V21X
-----END PGP SIGNATURE-----

--nextPart1773580.dC9kIpmkSf--

