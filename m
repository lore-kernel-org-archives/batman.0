Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 27 Mar 2016 15:45:54 +0800
Message-ID: <5032791.H5mNqakjxe@voltaire>
In-Reply-To: <OFE8016C97.82D26F0A-ONC1257F76.003FBD12-C1257F76.00416CB9@phoenixcontact.com>
References: <1456652670-18226-1-git-send-email-sven@narfation.org>
 <9978680.AHfZt94x15@voltaire>
 <OFE8016C97.82D26F0A-ONC1257F76.003FBD12-C1257F76.00416CB9@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1460598.3iiPhounPr";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: ELP - use new
	ethtool_link_get_ksettings API
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart1460598.3iiPhounPr
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, March 14, 2016 12:54:36 Andreas Pape wrote:
> This patch breaks compatibility with older kernels (2.6.32 in my case ;-).
> 
> Is this intended? If I try to compile this I get
> 
> ..../compat-include/linux/ethtool.h:49: error: implicit declaration of
> function '__ethtool_get_settings'
> 
> I stumbled across this when I tried to update and test my patches for dat
> and bla due to the feedback I received after I updated the master branch.

Please note that we don't plan to support these dinosaurs (2.6.*) anymore. 
With the next release we are going to drop support for kernels older than 3.2. 

Cheers,
Marek

--nextPart1460598.3iiPhounPr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW94+yAAoJEFNVTo/uthzA0ugH/1CCYrIFaTHkHNsC86KXNNGw
aZmc6XGKmawtBahRS1DnHXWRSZz7KyyRgq9LlrI2DjfVkeiV+M8yMzvOIkpkvWjf
J+El6Yb03GEjVUu7H1M9V8ARepTbdjQy6GnJJBhO1sk7HUIXam94rWuetTwugwF7
ghND9IYppGnYKSq2gEFzX/fhMEKDKDp0Ux8CDu3eXlqcyMNwuH3KteuXAV10Dadw
AKYOBM3NAQ8ptQC8+ZseCVM2AqhrYvVFJ0rGRwgqQJq6b1DGTn+QQ8mHWbz8FGxP
DDmbXMjlau/paHn0r2qhlO8lSr71u3dmh7p7q8AMi7NH3mtEussCD1N8kYTQCi4=
=jBQG
-----END PGP SIGNATURE-----

--nextPart1460598.3iiPhounPr--

