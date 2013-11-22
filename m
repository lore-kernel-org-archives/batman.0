Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 23 Nov 2013 01:20:18 +0800
Message-ID: <2086683.i5Pvxjn4Ed@diderot>
In-Reply-To: <1385039772-7485-1-git-send-email-sw@simonwunderlich.de>
References: <1385031136-15967-2-git-send-email-sw@simonwunderlich.de>
 <1385039772-7485-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2824825.O3BYpC0DFm";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 1/2] batman-adv: add debugfs structure
	for information per interface
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--nextPart2824825.O3BYpC0DFm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 21 November 2013 14:16:12 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> To show information per interface, add a debugfs hardif structure
> similar to the system in sysfs. Hard interface folders will be created
> in "$debugfs/batman-adv/". Files are not yet added.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
> Changes to PATCHv4:
>  * properly align the BATADV_HARDIF_DEBUGINFO macro
> 
> Changes to PATCHv3:
>  * move hardif debugfs files into $debugfs/batman-adv/$hardif
> 
> Changes to PATCHv2:
>  * add macro to add hardif debug infos
> ---
>  debugfs.c        |   73
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> debugfs.h        |    2 ++
>  hard-interface.c |    9 +++++++
>  types.h          |    2 ++
>  4 files changed, 86 insertions(+)

Applied in revision 3c926a0.

Thanks,
Marek

--nextPart2824825.O3BYpC0DFm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSj5JWAAoJEFNVTo/uthzAa58IAKyWwqep0hbV9CzrKNv1BwJO
41UkS1NFJgySv7Xxy/1bg22f3GNQf1ApzqiP8QUdiU0UsZJjwwCiWGqpMb0k9kDf
eCMXhcAatKXhZjHb7Z2kOGiMpCgNPVx2PAEz3YIdwmdnrjeUiBdGd3H5yOsgsJUf
/e95M8EKSXPsC1QX4OtFXylvC7MBEePXlFhXo8V7cFPfWTHqfsBsq7Fuuy0gd+mK
QlRroRNJMvqA2v1hLjpGgtKQIBhgBoVMQNH7Q7L+lWcuK2+1CmNBqBpiuq2Sj9h8
6/eFTN+fHtWHNINVKkG0FSAM3t2qsvu8OSTdLvn487qUDslsSWk9W3GfjicRKpw=
=tkV6
-----END PGP SIGNATURE-----

--nextPart2824825.O3BYpC0DFm--

