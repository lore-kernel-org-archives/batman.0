Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 06 May 2016 00:09:31 +0800
Message-ID: <2921513.lgCmTUKKT7@voltaire>
In-Reply-To: <20160505153447.GQ11201@prodigo.lan>
References: <2083541.Hg032Jxeer@riseup.net>
 <20160505153447.GQ11201@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5230044.XytjydVVTH";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Batman-adv doesn't compile in openwrt after last
	commit
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

--nextPart5230044.XytjydVVTH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, May 05, 2016 23:34:47 Antonio Quartulli wrote:
> After such commit Marek introduced a dependency to another openwrt packet,
> therefore you need to type make in the openwrt root in order to properly
> rebuild what's required now.

The batman-adv package only had a partial dependency on cfg80211 on which it 
relies due to the supplied kernel backports. I fixed it.

Thanks for reporting!
Marek
 
--nextPart5230044.XytjydVVTH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXK3A7AAoJEFNVTo/uthzA+BAH/2twtjL9pJl6w29Zz3dpbWD8
XYKFYDgHcVlpdFLk2dKa2Sawv8l7Rsv2K+FrLWpSd002JydFbL/zuG9kCfEXSWxQ
xageu2PiD1OU+NEpQk8tWDsJVei7yWkRzmW5kj+zUnuLiec1mc/Rb4TuRSzMzWEX
tamu9I2acOHDTaf0HM+aJ0A38KKBapngvrexS4iO1tOEJ9blRyHo0tKWHYqjosRi
oSPv3LF/tRTrmP3cKgXXDktBZ1EwMPh1O5hy0dtVd1pGv4stJpm2mNNwyxQGycZE
RaMqpSP3DFXxfCJ4SZjMg1ly108ZoWyLojH1oUZJy1eM4JOmmoy5EqQXok+40jI=
=+4qO
-----END PGP SIGNATURE-----

--nextPart5230044.XytjydVVTH--

