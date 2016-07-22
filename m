Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 22 Jul 2016 17:11:44 +0800
Message-ID: <2939805.ehlbhc0Aqg@voltaire>
In-Reply-To: <1468958992-2972-1-git-send-email-sven@narfation.org>
References: <1468836728-21890-11-git-send-email-sven@narfation.org>
 <1468958992-2972-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2152514.o2AxtNMDQG";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v12 11/11] batctl: Use debugfs fallback
	when netlink not supported
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

--nextPart2152514.o2AxtNMDQG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, July 19, 2016 22:09:52 Sven Eckelmann wrote:
> The batman-adv release v2016.2 already has the batadv netlink family . Thus
> the fallback to debugfs not only has to be triggered when the the netlink
> family doesn't exist but also when the cmd returns a -EOPNOTSUPP. This
> still has the problem that the header is generated via a different command
> then the actual table entries. Falling back to debugfs would cause a second
> header entry for the table.
> 
> The header print functionality is therefore refactored to only gather the
> data for the header and print the actual header either with the first
> received entry or when the CMD finished without any result.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v12:
>  - also use debugfs for originators/gwl when get_mesh_info is not supported
> ---
>  functions.h |   1 -
>  netlink.c   | 150
> ++++++++++++++++++++++++++++++++++++++++-------------------- 2 files
> changed, 101 insertions(+), 50 deletions(-)

Applied in revision 5401c71.

Thanks,
Marek

--nextPart2152514.o2AxtNMDQG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXkeNQAAoJEFNVTo/uthzAopkH/RcrCplcwiJqNyHcOe6vUKwK
an9LzslhBzkiN2WrzCZTMctaFBiY/iSGeKR6GF28dDHcsQVGPHLI5jqPkshPzpcz
yF0F8hhDHucL6bgHcmH2xSwOwoYeYia2zTolCUqxUwvt58xnv0kXBkFVs06XbILa
v1ogdc2wZbF2FXOyNEu/B53LHWIBUPWiep7wtl8TdXmuIE6XZEqUYaCRgIb8J8B2
lDuiVDheGcp4dujqlcFPSsLguNfZ8I2qm7TwWh7hg2uQsXemGkQ5Vv5w2xZA3Cro
4csECGzL4c2fmOU9Htlunv/c46xlIYww/XYGLGZ2ShHNWYz/dcWWQGmoGt0JphU=
=dKNp
-----END PGP SIGNATURE-----

--nextPart2152514.o2AxtNMDQG--

