Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 05 May 2016 22:58:43 +0800
Message-ID: <5193248.RzBv1OI7Vp@voltaire>
In-Reply-To: <1462444519-26509-2-git-send-email-sven.eckelmann@open-mesh.com>
References: <1462444519-26509-1-git-send-email-sven.eckelmann@open-mesh.com>
 <1462444519-26509-2-git-send-email-sven.eckelmann@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1712349.lL4lufeZSV";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Add missing include for
	container_of
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

--nextPart1712349.lL4lufeZSV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, May 05, 2016 12:35:19 Sven Eckelmann wrote:
> Fixes: 0d8468553c3c ("batman-adv: remove ogm_emit and ogm_schedule API
> calls") Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> ---
> Problem was found by
> https://lists.open-mesh.org/pipermail/linux-merge/2016-May/003146.html
> 
>  net/batman-adv/bat_iv_ogm.c | 1 +
>  1 file changed, 1 insertion(+)

Applied in revision ba17db2.

Thanks,
Marek

--nextPart1712349.lL4lufeZSV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXK1+jAAoJEFNVTo/uthzADOIH+wU+iP4zao9sZ8A0Ixk8nh7j
4EC9W6/sKs4rXbftxK01xaAHLORFlepwnA/M24kagvxIfdmOtTtybUh+lx9nKONR
cOeE1MnDJ9Yzcl+QO96R4STw47KCn/gx66hlpMTpgrBvONJBQnZmiOU2wiePbV9s
DpgijE32jCNd7AEAAiC0GuAEvSKaeLavpoAqJeVSUqvYmoO2k6iOSePROTz2rMI2
qUGc3FYvd6x3IwQAjWwJ8EDVKVrD8xf7alHReF0c7xluEXTIoNy17GiQx509BWRh
O2s6HYFhg5zikluW+MjX5RFGXJD5kSG0+qDa6UCtYcKVP/6V2eKkWOfxpHCMN1Y=
=vzmC
-----END PGP SIGNATURE-----

--nextPart1712349.lL4lufeZSV--

