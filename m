Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 14 May 2018 09:35:14 +0200
Message-ID: <3527728.6mgLYZWjGi@bentobox>
In-Reply-To: <20180513223849.14636-1-mareklindner@neomailbox.ch>
References: <20180513223849.14636-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1663633.Rj4KvFYZ46";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: disable ethtool link
 speed detection when auto negotiation off
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

--nextPart1663633.Rj4KvFYZ46
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 14. Mai 2018 06:38:49 CEST Marek Lindner wrote:
> Virtual interface drivers such as tun / tap interfaces, VLAN, etc tend
> to initialize the interface throughput with some value for the sake of
> having a throughput number to export via ethtool. This exported
> throughput leaves batman-adv to conclude the interface throughput is
> genuine (reflecting reality), thus no measurements are necessary.
> 
> Based on the observation that those interface types also tend to set
> the link auto-negotiation to 'off', batman-adv shall check this
> setting to differentiate between genuine link throughput information
> and placeholders installed by virtual interfaces.
> 
> The "default throughput" setting exported via sysfs still allows to
> configure the batman-adv throughput for the interface, thus disabling
> the measurements.
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> Acked-by: Antonio Quartulli <a@unstable.cc>
> ---
> v2:
>  * added ethtool compat code for Linux < 4.6
>  * additional explanation text in the commit msg & code


Applied in d60b8fc69ef2 [1]

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/d60b8fc69ef24d56a10b85210685f6a7d15a8a08
--nextPart1663633.Rj4KvFYZ46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlr5PDIACgkQXYcKB8Em
e0bNBxAAvVgJC8N2+mQn/OUp636do1pLHlD/Z+r7ibSB4eXQT4ASz48FWgoqWkLS
whQdh9xlf/nC7IoKitoxdEjhe8BSGXmu9Jz2OiWyPv/PGSqUHzK2IWsPt604xODP
T9DCY7OdKR3cg0JtlwM/YAGU3uAdehG2+HOTObN/6auajO8j93sUyTz6rgPHfkME
zDR3PJJhMFU/kfsgxVUCjCxE4FiGNbzuGf76nBFeknYYsBfCCHZXRS28LJI7IIph
eOKj3vcKuG4xlnhbNI/++bVv9zGXbMsT5NV13XFTCOQeBQ6VpHsKquAeqTQaUCRa
LTHSg1GhX1WZlWLC02lbO+sMzjgUPKer/U8ha4lAzVE9d8666b+8Rj1t9C3/32a4
/YjUUd0fvXfCQ/us1pCAH4+9fXhRVNPDulAp114KSvTKDYgt6mzFNqBxLtXR57sn
SJ0NrVNZ2XGtHI7AvIHsynRSslWTstDWQWY2qYA64AgsKpuWFLRQYpKgfq7x13c5
6opb2QOaJV7gqrFlWx/g0fgy+Uh631yyMJlVRGJzM7eX17j2oiU9orytUBXyeA5G
DIUZMZ/7+5dZ5lr0ojbaaq13W/gFFQLJTk4zIaBTk6iHxCqwhwqyqP60OUG00tIk
DAR3QwmCB7KHQBhE2alM7TrkeAwqNeDMaH4T42gskQ/rFtOsu9s=
=kado
-----END PGP SIGNATURE-----

--nextPart1663633.Rj4KvFYZ46--

