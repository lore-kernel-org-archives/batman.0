Return-Path: <antonio@meshcoding.com>
Message-ID: <52A1A297.9010208@meshcoding.com>
Date: Fri, 06 Dec 2013 11:10:31 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1386317890.31845.26.camel@joe-AO722>
In-Reply-To: <1386317890.31845.26.camel@joe-AO722>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH -next] batadv: Slight optimization of
	batadv_compare_eth
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
To: Joe Perches <joe@perches.com>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 06/12/13 09:18, Joe Perches wrote:
> Use CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS to check if this
> function can be optimized by using the generic ether_addr_equal.
> 
> Remove the unnecessary ?: after the unoptimized memcmp.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Antonio Quartulli <antonio@meshcoding.com>


- -- 
Antonio Quartulli
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSoaKXAAoJEEKTMo6mOh1VMjoP/3GqGy0TQG1yXRzbrzAbbklJ
8Oa6DHQd2pSN/cJkR501JYwSUnCGh3m7eh7qc1HZYrEIgxIrJDLHWSqBL3FPtgap
gQ92BBQG/pd38ZmmWSeZob44bEMEGAn00B1kgFx+Xb4YW4bP2rDAlvPxjjaqjT3U
tBNbNYxUTBY2JMftI7WwEOwMWgLPVoHR1PhAbBTpbXMXCRrGp/vXN1xXam1xIDNx
kahFmHA1Dc91dwr8ev4bcUjfGO2tXkQOEoqKRkwc1SEzuKTjgJNDxdbFNqG6vMAm
k/aXhMvf3DOUkaCeslRQIkwefbKmzN69c1x2ND7S8mLEMIKyBuhKUFcf6PebD9SK
Dc+KdwIx0lsaS2vGqOt6mUSie1KfY8QNAc74eF6XjDhKyJynYXe6S3L40uT4eLXR
8fwGClJmyYVIiYD65NOtiIx6C2uHFchjDpXjlz0X8N9oQ2Azr4e2RMTGkkoihvOh
94r1dmAaBrnRiAu6AkImhgN+lWgLglHWD5trmmRCxNEJf0iW+x9ZaR4yAQFDUP3k
mrk5AN8JuRZkOeY5QK4AIZ0bFUh8tKW6JaNb8VHQGsLqjhAB/HPS6VljyRgMalyQ
c/kLlEOIIZ9dsjMwKMgyoJ9bMtTYUTxrriKz12mQbx8mWvm4CMFEQglljQiuTyvh
J+UsjAHs/ffW59JIGCfB
=8xL7
-----END PGP SIGNATURE-----
